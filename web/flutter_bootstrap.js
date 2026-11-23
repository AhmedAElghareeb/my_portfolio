{{flutter_js}}
{{flutter_build_config}}

(() => {
  const buildVersion = {{flutter_service_worker_version}};
  const localEngine = { canvasKitBaseUrl: new URL('canvaskit/', document.baseURI).href };

  for (const build of _flutter.buildConfig.builds) {
    for (const key of ['mainJsPath', 'mainWasmPath', 'jsSupportRuntimePath']) {
      if (build[key]) build[key] += '?v=' + buildVersion;
    }
  }

  // Match Flutter 3.32's Skwasm capability checks for resource hints. Flutter
  // still selects the renderer, including the bundled CanvasKit fallback.
  const firstBuild = _flutter.buildConfig.builds[0];
  const canStartSkwasm = firstBuild?.renderer === 'skwasm' && firstBuild.mainWasmPath &&
      typeof ImageDecoder !== 'undefined' && navigator.vendor === 'Google Inc.' &&
      typeof Intl.v8BreakIterator !== 'undefined' && typeof Intl.Segmenter !== 'undefined' &&
      WebAssembly.validate(new Uint8Array([0, 97, 115, 109, 1, 0, 0, 0, 1, 5, 1, 95, 1, 120, 0]));
  const preload = (url, isModule = false) => new Promise((resolve, reject) => {
    const link = document.createElement('link');
    link.rel = isModule ? 'modulepreload' : 'preload';
    if (!isModule) link.as = 'fetch';
    link.crossOrigin = 'anonymous';
    link.href = url;
    link.onload = resolve;
    link.onerror = reject;
    document.head.append(link);
  });

  const startError = error => {
    console.error('Portfolio startup failed', error);
    document.getElementById('portfolio-startup-error')?.removeAttribute('hidden');
  };
  window.addEventListener('flutter-first-frame', () => {
    performance.mark('portfolio-first-flutter-frame');
    document.getElementById('portfolio-startup')?.remove();
  }, { once: true });

  performance.mark('portfolio-flutter-load');
  const load = config => _flutter.loader.load({
    config,
    onEntrypointLoaded: async engine => {
      try {
        performance.mark('portfolio-entrypoint-ready');
        const app = await engine.initializeEngine(config);
        performance.mark('portfolio-engine-ready');
        await app.runApp();
      } catch (error) {
        startError(error);
      }
    },
  });

  async function start() {
    const revision = _flutter.buildConfig.engineRevision;
    if (!canStartSkwasm || !revision) return load(localEngine);

    // Start both app downloads while we check the smaller, revision-matched
    // CDN engine. A blocked or failed CDN request selects the bundled engine
    // before Flutter starts, so there is never a second engine initialization.
    preload(new URL(firstBuild.mainWasmPath, document.baseURI).href).catch(() => {});
    preload(new URL(firstBuild.jsSupportRuntimePath, document.baseURI).href, true).catch(() => {});
    const cdn = new URL(revision + '/', 'https://www.gstatic.com/flutter-canvaskit/');
    let engine = localEngine;
    try {
      await Promise.all([
        preload(new URL('skwasm.wasm', cdn).href),
        preload(new URL('skwasm.js', cdn).href, true),
      ]);
      engine = { canvasKitBaseUrl: cdn.href };
    } catch {
      // This origin also ships the same engine revision.
    }
    return load(engine);
  }
  start().catch(startError);

  // Replace only this portfolio's legacy generated worker, and only if present.
  // Never wait on cache migration before loading Flutter.
  if ('serviceWorker' in navigator) {
    const scope = new URL('./', document.baseURI);
    navigator.serviceWorker.getRegistration(scope.href).then(registration => {
      if (registration?.scope !== scope.href) return;
      const oldWorker = registration.active ?? registration.waiting ?? registration.installing;
      if (!oldWorker || new URL(oldWorker.scriptURL).pathname !== new URL('flutter_service_worker.js', scope).pathname) return;
      return navigator.serviceWorker.register(new URL('retire_flutter_service_worker.js', scope), { scope: scope.href, updateViaCache: 'none' });
    }).catch(error => console.warn('Portfolio cache migration will retry on the next visit', error));
  }
})();

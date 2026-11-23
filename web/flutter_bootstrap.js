{{flutter_js}}
{{flutter_build_config}}

(() => {
  const buildVersion = {{flutter_service_worker_version}};
  const config = { canvasKitBaseUrl: new URL('canvaskit/', document.baseURI).href };

  for (const build of _flutter.buildConfig.builds) {
    for (const key of ['mainJsPath', 'mainWasmPath', 'jsSupportRuntimePath']) {
      if (build[key]) build[key] += '?v=' + buildVersion;
    }
  }

  const startError = error => {
    console.error('Portfolio startup failed', error);
    document.getElementById('portfolio-startup-error')?.removeAttribute('hidden');
  };
  window.addEventListener('flutter-first-frame', () => {
    performance.mark('portfolio-first-flutter-frame');
    document.getElementById('portfolio-startup')?.remove();
  }, { once: true });

  performance.mark('portfolio-flutter-load');
  _flutter.loader.load({
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
  }).catch(startError);

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

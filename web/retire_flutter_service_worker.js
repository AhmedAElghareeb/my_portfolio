self.addEventListener('install', event => event.waitUntil(self.skipWaiting()));

self.addEventListener('activate', event => {
  event.waitUntil((async () => {
    const scope = self.registration.scope;
    const oldNames = new Set(['flutter-app-cache', 'flutter-temp-cache', 'flutter-app-manifest']);
    try {
      for (const name of await caches.keys()) {
        if (!oldNames.has(name)) continue;
        const cache = await caches.open(name);
        await Promise.all((await cache.keys())
          .filter(request => request.url.startsWith(scope))
          .map(request => cache.delete(request)));
      }
    } finally {
      await self.clients.claim();
      await self.registration.unregister();
    }
  })());
});

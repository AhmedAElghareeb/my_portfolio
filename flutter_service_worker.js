'use strict';
const MANIFEST = 'flutter-app-manifest';
const TEMP = 'flutter-temp-cache';
const CACHE_NAME = 'flutter-app-cache';

const RESOURCES = {".git/COMMIT_EDITMSG": "8439beb8b1732c0a2985d22d90c57484",
".git/config": "05ee135c792f7938858eb14cb89ffd5f",
".git/description": "a0a7c3fff21f2aea3cfa1d0316dd816c",
".git/HEAD": "cf7dd3ce51958c5f13fece957cc417fb",
".git/hooks/applypatch-msg.sample": "ce562e08d8098926a3862fc6e7905199",
".git/hooks/commit-msg.sample": "579a3c1e12a1e74a98169175fb913012",
".git/hooks/fsmonitor-watchman.sample": "a0b2633a2c8e97501610bd3f73da66fc",
".git/hooks/post-update.sample": "2b7ea5cee3c49ff53d41e00785eb974c",
".git/hooks/pre-applypatch.sample": "054f9ffb8bfe04a599751cc757226dda",
".git/hooks/pre-commit.sample": "5029bfab85b1c39281aa9697379ea444",
".git/hooks/pre-merge-commit.sample": "39cb268e2a85d436b9eb6f47614c3cbc",
".git/hooks/pre-push.sample": "2c642152299a94e05ea26eae11993b13",
".git/hooks/pre-rebase.sample": "56e45f2bcbc8226d2b4200f7c46371bf",
".git/hooks/pre-receive.sample": "2ad18ec82c20af7b5926ed9cea6aeedd",
".git/hooks/prepare-commit-msg.sample": "2b5c047bdb474555e1787db32b2d2fc5",
".git/hooks/push-to-checkout.sample": "c7ab00c7784efeadad3ae9b228d4b4db",
".git/hooks/sendemail-validate.sample": "4d67df3a8d5c98cb8565c07e42be0b04",
".git/hooks/update.sample": "647ae13c682f7827c22f5fc08a03674e",
".git/index": "0b165b61abbc91bdcb1a68142eed5b7f",
".git/info/exclude": "036208b4a1ab4a235d75c181e685e5a3",
".git/logs/HEAD": "70df8d5f20a845ab952a4307afeedb06",
".git/logs/refs/heads/main": "4b65024e11800539f3cc07622b5b9193",
".git/logs/refs/remotes/origin/gh-pages": "0df45e2b6c6b9a513e0b76182a1261e9",
".git/objects/0f/89ccae693f6e30dd678826d0501bbac70bc811": "f88b4f02e9a0a5453e1e2a2d49acc78a",
".git/objects/11/ca60509417fa624904e80cf2beea2028aebe16": "3e6973c46eec6c734453e2ce97bc7edf",
".git/objects/19/d760504585b69ad686c7a9e654741ea0e2a8c3": "9e48a9d32e76189aa9119eb36bcea8cd",
".git/objects/1a/d7683b343914430a62157ebf451b9b2aa95cac": "94fdc36a022769ae6a8c6c98e87b3452",
".git/objects/1c/10972eceaea5bc6ddf055d7e4caa75e01e6f8e": "0185c67dad999f49755704755e660c16",
".git/objects/1f/8f52f4c5faef7ba66e7854efd3c2c751e5cbe1": "4989a2749761a0b4ef8ddaf899ffcf20",
".git/objects/22/0122a50ef1db902c16609c8f4591852ef444cc": "be1610c78e2b2682de47c23ae0dc80d6",
".git/objects/28/40f84df9f4d4a435554a95156f1f5033ee25c1": "bebe683ce0fdfa740fa2ba26c8892196",
".git/objects/2e/8cdaee8a7abf37be667584512ae54d9f54a749": "5a51cac95fa9a26d28c009d889336d2a",
".git/objects/35/a837ad3cc64d22da2d99f2ce095e3611d13c33": "e8f5dc5abc9dbfafed94c19b60684c11",
".git/objects/41/fcd35128e443b69eb7cff8b744ffa84ac1e603": "8a3f5a838e259d0058ed6a97df4dd6c9",
".git/objects/4c/51fb2d35630595c50f37c2bf5e1ceaf14c1a1e": "a20985c22880b353a0e347c2c6382997",
".git/objects/50/c722bb304018a44901ff56499d099de80233bb": "ce0d796164724907f45f4fb7129e2bda",
".git/objects/52/896f461139823daf687cc35421b4042e303fbc": "63a42eee682858c78a1735754a5479b4",
".git/objects/53/18a6956a86af56edbf5d2c8fdd654bcc943e88": "a686c83ba0910f09872b90fd86a98a8f",
".git/objects/53/3d2508cc1abb665366c7c8368963561d8c24e0": "4592c949830452e9c2bb87f305940304",
".git/objects/5d/56c2550af5a535751b45885eab47a66da3c654": "817e641a82ba607c1712a460cd0a465c",
".git/objects/5e/671682ec5755d3bc7ec732e7e2104e23c3dd9b": "f053e927bb6e8a9b3ad37bd8b270b640",
".git/objects/70/a234a3df0f8c93b4c4742536b997bf04980585": "d95736cd43d2676a49e58b0ee61c1fb9",
".git/objects/73/c63bcf89a317ff882ba74ecb132b01c374a66f": "6ae390f0843274091d1e2838d9399c51",
".git/objects/7a/5e9e890ebbf757ae867603237d74d3daec87ed": "a93c8e96e85ebb388ca309bf10f95ec7",
".git/objects/7b/27ceba6f61301397124cf491e0921c153203da": "a94858a620b389fc30327d1bd967b561",
".git/objects/7e/f2e21b9dc745c6ef14ee316279a6ba46786262": "b8860cab22291c99a1881f2b4075d619",
".git/objects/87/9e5d3931a06e64427e2ffcb4e0154377c2233b": "c89bd5e35c8415a8a2724b44490a241e",
".git/objects/88/cfd48dff1169879ba46840804b412fe02fefd6": "e42aaae6a4cbfbc9f6326f1fa9e3380c",
".git/objects/8b/93aacdc44f1810303840777180b8632c840682": "cbc3d64f004e11de3d09dac5ccd7859b",
".git/objects/8e/3c7d6bbbef6e7cefcdd4df877e7ed0ee4af46e": "025a3d8b84f839de674cd3567fdb7b1b",
".git/objects/94/0313f7a7a9ab4f59a9d53c8711b516de91fe56": "52992bbabaac3d0c86ab4032b973457c",
".git/objects/99/b595530c84a3d9e6c772ec4177ce06cc7ac32b": "03bf6bfa8c3e26e4176ac541c0f6b31c",
".git/objects/9b/d3accc7e6a1485f4b1ddfbeeaae04e67e121d8": "784f8e1966649133f308f05f2d98214f",
".git/objects/9e/e1919dc230d3433cce79d137c37081c974034a": "7918dcf5b15c1ac607255918935ca48a",
".git/objects/a2/cccadb0d3a55758fa4f1a6bf31786d8f672f8f": "f5a96d7c0e3c6f6552a03849caca3271",
".git/objects/a9/972b11c1ed8cdbecaf4f889a192759637b9beb": "4775b482d5b320ad4c3e9b7d43a1cf05",
".git/objects/b1/d0358fac6a4e4746412a99ea699200d7e01976": "1207282b425a7b3a43a5500ab9b7e931",
".git/objects/b5/b0f4f1c17b4056497295c815391a70187d4d51": "7403fed0ede3e4125bf581ff1983ac89",
".git/objects/b7/49bfef07473333cf1dd31e9eed89862a5d52aa": "36b4020dca303986cad10924774fb5dc",
".git/objects/b7/9d6156c30f4bf59e5a2026dbc1c148abf4bf3f": "9be0ae2a432a80b1ea43ccf2ea540a7e",
".git/objects/b9/0efadfd3b29e71449fe720b0d503d3a71e78fc": "1e1acdc2ff3aebde051a6ce6c0c9315c",
".git/objects/b9/2a0d854da9a8f73216c4a0ef07a0f0a44e4373": "f62d1eb7f51165e2a6d2ef1921f976f3",
".git/objects/b9/6a5236065a6c0fb7193cb2bb2f538b2d7b4788": "4227e5e94459652d40710ef438055fe5",
".git/objects/bf/db8b0b60b920ecdaf3001beb9dc5ca5c064360": "bae51df1e83d254fda9109c74e77bfce",
".git/objects/c1/599a549019ed38b2d518626ca3c7245d4a0b68": "d4eb95432669032b5070fe8778d21b9d",
".git/objects/c5/e51be6cb6299af14e9dd6e63d9a54c15e3415c": "5b88d898d03a535eb91c2ba2245661c1",
".git/objects/c8/08fb85f7e1f0bf2055866aed144791a1409207": "92cdd8b3553e66b1f3185e40eb77684e",
".git/objects/cc/ed4669a79e3bd04913678146aa79041ecf4ed8": "a81d3d80a567f7cb516863d73c5d2f07",
".git/objects/d4/3532a2348cc9c26053ddb5802f0e5d4b8abc05": "3dad9b209346b1723bb2cc68e7e42a44",
".git/objects/d5/05641a7b8d385596ca0562c231481ca8de8ddf": "3950149f2bc771355c2f136f5dbd71a8",
".git/objects/d6/9c56691fbdb0b7efa65097c7cc1edac12a6d3e": "868ce37a3a78b0606713733248a2f579",
".git/objects/da/43e61c3ef3740326c2d217426f3ee9913afdad": "30305cf03a7ac53c6711b8b592e3e808",
".git/objects/dc/11fdb45a686de35a7f8c24f3ac5f134761b8a9": "761c08dfe3c67fe7f31a98f6e2be3c9c",
".git/objects/dc/67dd363b44f82d30dc9bd7cf661744278f4dd3": "fedc759dd4ef5de29d7b523f1c03f1a6",
".git/objects/e0/7ac7b837115a3d31ed52874a73bd277791e6bf": "74ebcb23eb10724ed101c9ff99cfa39f",
".git/objects/ea/7684857b537ac162ca51f34fc1b862fa52ad1e": "1296b6380214136292b7482603b25a94",
".git/objects/eb/9b4d76e525556d5d89141648c724331630325d": "37c0954235cbe27c4d93e74fe9a578ef",
".git/objects/ec/d6a75c5e56fe65063dca6a1a973f6c67c66b78": "60df779878ccad582163fbe515cb7575",
".git/objects/ed/9565740b028341c0483cb1cf0518c76e172f0c": "36e34021a12a84fb1839f3441395e05e",
".git/objects/f2/04823a42f2d890f945f70d88b8e2d921c6ae26": "6b47f314ffc35cf6a1ced3208ecc857d",
".git/objects/f2/fe68289dc75cb31f51c1af40c04fd368466e56": "17d14b0efa64a44d4ec062a51f4fa984",
".git/objects/fb/6beec2ec8c42bf77c134a29645cdd30c1b2d49": "ed702d81d1f35ce0a0a4e5a95c888d68",
".git/objects/fe/3bfd084c44c54a98c5d06000427e1a3f19aee2": "6abb2d770d0c9404f17c0eeab22b5694",
".git/objects/ff/6081e9471dcbed9d7aed3564f1a9aa030e0ae1": "dcc410331277c91f0bfaabeef4e0346c",
".git/refs/heads/main": "f78ef30a2c6542614a8466631b3c42fd",
".git/refs/remotes/origin/gh-pages": "f78ef30a2c6542614a8466631b3c42fd",
"assets/AssetManifest.bin": "aed170e1f32ddd289fe16d5c74ac7a28",
"assets/AssetManifest.bin.json": "bd8074de0914f2a695327f2d5cb8e913",
"assets/AssetManifest.json": "a25706b3d88e636e8562bd03c9e7e813",
"assets/assets/projects/gebal.png": "b0be87ba1783395c07fb07d14b8cd3dc",
"assets/assets/projects/lirat.png": "1792343732833a0393c3b5e3a8344982",
"assets/assets/projects/p2p_syria.png": "8ea40bcb4fdb33482b41f89213a52404",
"assets/assets/projects/ufoo_driver.png": "a79fd5a42fd3cef582e9803eeccfcfbc",
"assets/assets/projects/zidcash.png": "3800bb951978c64264dae2f1450b1b98",
"assets/FontManifest.json": "3ddd9b2ab1c2ae162d46e3cc7b78ba88",
"assets/fonts/MaterialIcons-Regular.otf": "e4d64dbadce38b6167857e6e8b179d0b",
"assets/NOTICES": "6b9edc0397a5d81e23cddad4684609c7",
"assets/packages/font_awesome_flutter/lib/fonts/fa-brands-400.ttf": "a96eb2260ca81f6ab63444ce9bb78432",
"assets/packages/font_awesome_flutter/lib/fonts/fa-regular-400.ttf": "262525e2081311609d1fdab966c82bfc",
"assets/packages/font_awesome_flutter/lib/fonts/fa-solid-900.ttf": "269f971cec0d5dc864fe9ae080b19e23",
"assets/shaders/ink_sparkle.frag": "ecc85a2e95f5e9f53123dcaf8cb9b6ce",
"canvaskit/canvaskit.js": "728b2d477d9b8c14593d4f9b82b484f3",
"canvaskit/canvaskit.js.symbols": "bdcd3835edf8586b6d6edfce8749fb77",
"canvaskit/canvaskit.wasm": "7a3f4ae7d65fc1de6a6e7ddd3224bc93",
"canvaskit/chromium/canvaskit.js": "8191e843020c832c9cf8852a4b909d4c",
"canvaskit/chromium/canvaskit.js.symbols": "b61b5f4673c9698029fa0a746a9ad581",
"canvaskit/chromium/canvaskit.wasm": "f504de372e31c8031018a9ec0a9ef5f0",
"canvaskit/skwasm.js": "ea559890a088fe28b4ddf70e17e60052",
"canvaskit/skwasm.js.symbols": "e72c79950c8a8483d826a7f0560573a1",
"canvaskit/skwasm.wasm": "39dd80367a4e71582d234948adc521c0",
"favicon.png": "0686f1972980114147a08aebe4846029",
"flutter.js": "83d881c1dbb6d6bcd6b42e274605b69c",
"flutter_bootstrap.js": "a00c4fda7555e61ba2d79b70ffac0e89",
"icons/Icon-192.png": "ac9a721a12bbc803b44f645561ecb1e1",
"icons/Icon-512.png": "96e752610906ba2a93c65f8abe1645f1",
"icons/Icon-maskable-192.png": "c457ef57daa1d16f64b27b786ec2ea3c",
"icons/Icon-maskable-512.png": "301a7604d45b3e739efc881eb04896ea",
"index.html": "c67a7f1fc5426d3973a726859c4b6129",
"/": "c67a7f1fc5426d3973a726859c4b6129",
"main.dart.js": "8e6feb9221c80b994920f7d2c251b201",
"manifest.json": "d8fe34f7ae4c072a77b924e01dac8a50",
"version.json": "9b818ca9511483c901bed1545384376c"};
// The application shell files that are downloaded before a service worker can
// start.
const CORE = ["main.dart.js",
"index.html",
"flutter_bootstrap.js",
"assets/AssetManifest.bin.json",
"assets/FontManifest.json"];

// During install, the TEMP cache is populated with the application shell files.
self.addEventListener("install", (event) => {
  self.skipWaiting();
  return event.waitUntil(
    caches.open(TEMP).then((cache) => {
      return cache.addAll(
        CORE.map((value) => new Request(value, {'cache': 'reload'})));
    })
  );
});
// During activate, the cache is populated with the temp files downloaded in
// install. If this service worker is upgrading from one with a saved
// MANIFEST, then use this to retain unchanged resource files.
self.addEventListener("activate", function(event) {
  return event.waitUntil(async function() {
    try {
      var contentCache = await caches.open(CACHE_NAME);
      var tempCache = await caches.open(TEMP);
      var manifestCache = await caches.open(MANIFEST);
      var manifest = await manifestCache.match('manifest');
      // When there is no prior manifest, clear the entire cache.
      if (!manifest) {
        await caches.delete(CACHE_NAME);
        contentCache = await caches.open(CACHE_NAME);
        for (var request of await tempCache.keys()) {
          var response = await tempCache.match(request);
          await contentCache.put(request, response);
        }
        await caches.delete(TEMP);
        // Save the manifest to make future upgrades efficient.
        await manifestCache.put('manifest', new Response(JSON.stringify(RESOURCES)));
        // Claim client to enable caching on first launch
        self.clients.claim();
        return;
      }
      var oldManifest = await manifest.json();
      var origin = self.location.origin;
      for (var request of await contentCache.keys()) {
        var key = request.url.substring(origin.length + 1);
        if (key == "") {
          key = "/";
        }
        // If a resource from the old manifest is not in the new cache, or if
        // the MD5 sum has changed, delete it. Otherwise the resource is left
        // in the cache and can be reused by the new service worker.
        if (!RESOURCES[key] || RESOURCES[key] != oldManifest[key]) {
          await contentCache.delete(request);
        }
      }
      // Populate the cache with the app shell TEMP files, potentially overwriting
      // cache files preserved above.
      for (var request of await tempCache.keys()) {
        var response = await tempCache.match(request);
        await contentCache.put(request, response);
      }
      await caches.delete(TEMP);
      // Save the manifest to make future upgrades efficient.
      await manifestCache.put('manifest', new Response(JSON.stringify(RESOURCES)));
      // Claim client to enable caching on first launch
      self.clients.claim();
      return;
    } catch (err) {
      // On an unhandled exception the state of the cache cannot be guaranteed.
      console.error('Failed to upgrade service worker: ' + err);
      await caches.delete(CACHE_NAME);
      await caches.delete(TEMP);
      await caches.delete(MANIFEST);
    }
  }());
});
// The fetch handler redirects requests for RESOURCE files to the service
// worker cache.
self.addEventListener("fetch", (event) => {
  if (event.request.method !== 'GET') {
    return;
  }
  var origin = self.location.origin;
  var key = event.request.url.substring(origin.length + 1);
  // Redirect URLs to the index.html
  if (key.indexOf('?v=') != -1) {
    key = key.split('?v=')[0];
  }
  if (event.request.url == origin || event.request.url.startsWith(origin + '/#') || key == '') {
    key = '/';
  }
  // If the URL is not the RESOURCE list then return to signal that the
  // browser should take over.
  if (!RESOURCES[key]) {
    return;
  }
  // If the URL is the index.html, perform an online-first request.
  if (key == '/') {
    return onlineFirst(event);
  }
  event.respondWith(caches.open(CACHE_NAME)
    .then((cache) =>  {
      return cache.match(event.request).then((response) => {
        // Either respond with the cached resource, or perform a fetch and
        // lazily populate the cache only if the resource was successfully fetched.
        return response || fetch(event.request).then((response) => {
          if (response && Boolean(response.ok)) {
            cache.put(event.request, response.clone());
          }
          return response;
        });
      })
    })
  );
});
self.addEventListener('message', (event) => {
  // SkipWaiting can be used to immediately activate a waiting service worker.
  // This will also require a page refresh triggered by the main worker.
  if (event.data === 'skipWaiting') {
    self.skipWaiting();
    return;
  }
  if (event.data === 'downloadOffline') {
    downloadOffline();
    return;
  }
});
// Download offline will check the RESOURCES for all files not in the cache
// and populate them.
async function downloadOffline() {
  var resources = [];
  var contentCache = await caches.open(CACHE_NAME);
  var currentContent = {};
  for (var request of await contentCache.keys()) {
    var key = request.url.substring(origin.length + 1);
    if (key == "") {
      key = "/";
    }
    currentContent[key] = true;
  }
  for (var resourceKey of Object.keys(RESOURCES)) {
    if (!currentContent[resourceKey]) {
      resources.push(resourceKey);
    }
  }
  return contentCache.addAll(resources);
}
// Attempt to download the resource online before falling back to
// the offline cache.
function onlineFirst(event) {
  return event.respondWith(
    fetch(event.request).then((response) => {
      return caches.open(CACHE_NAME).then((cache) => {
        cache.put(event.request, response.clone());
        return response;
      });
    }).catch((error) => {
      return caches.open(CACHE_NAME).then((cache) => {
        return cache.match(event.request).then((response) => {
          if (response != null) {
            return response;
          }
          throw error;
        });
      });
    })
  );
}

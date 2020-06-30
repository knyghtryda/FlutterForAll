'use strict';
const MANIFEST = 'flutter-app-manifest';
const TEMP = 'flutter-temp-cache';
const CACHE_NAME = 'flutter-app-cache';
const RESOURCES = {
  "assets/AssetManifest.json": "2fddd63b42121c586395507295a86fc0",
"assets/assets/blue-screen.mp3": "4cae9c49e9677cc2a858414a2737c766",
"assets/assets/listview.png": "9c54d79d90aa0f61a39700fa06227a9b",
"assets/assets/microsoft.mp3": "bfb0771ecbcbc2273dfbda63f6a3ac16",
"assets/assets/win95blue.png": "ea6c065bc96bd5b5d0fd8f857136c496",
"assets/assets/win95logo.png": "fbd4cde25cdde1be47a5d4c34be336df",
"assets/assets/winbk.png": "6aed31f74c54f6d3c733acc13e388618",
"assets/assets/Windows_95_Desktop_screenshot.png": "a8ba4c18f324a501c3b93724097dbbe6",
"assets/FontManifest.json": "8c739df45e50e24aac32f713f28b14b6",
"assets/fonts/Apl2741.ttf": "b8005a06febdca1f23525071b14e43f7",
"assets/fonts/MaterialIcons-Regular.ttf": "56d3ffdef7a25659eab6a68a3fbfaf16",
"assets/fonts/roboto/Roboto-Medium.ttf": "58aef543c97bbaf6a9896e8484456d98",
"assets/fonts/VT323-Regular.ttf": "692c37377cd1e0f4850f47c7c0148426",
"assets/images/app-store-2019-09-25.png": "a06b324c1cff59c46ab8ca9ae61140b3",
"assets/images/bateries.png": "56b1c896f0ca4006fe74ee847c20f29f",
"assets/images/clippy.png": "10acd893aae09a7606b5114e465214fb",
"assets/images/clock.png": "ee0e29c168b7642ea78843b4300a372c",
"assets/images/company.png": "3649e71603f0d27d49f30a60fcab3c73",
"assets/images/machd.png": "eccef3ab00d58b8c19915a14e3c44752",
"assets/images/macos-catalina-2019-10-08.png": "004f52ba7d22ca6fae656c584540b185",
"assets/images/macos-desk-background.jpg": "4e0abf45b6c9dc1e3217984c3856ef7a",
"assets/images/music-2019-09-25.png": "869d1e417eb684359d3d714139bedd4f",
"assets/images/my_computer.ico": "fa139f6924c40a4e3f54bfc2c944afd7",
"assets/images/preview-2019-09-25.png": "24338f6d8be7820e6d764476800ea255",
"assets/images/recycle_bin.ico": "2452d88f6e14404f6cfd0ccaa5f3dfa0",
"assets/images/run.ico": "55d0c4548ae3112497de8984aed0a862",
"assets/images/safari-2019-09-25.png": "f95034936a942f4da6d94f2458174930",
"assets/images/shutdown.ico": "bea0c092c98ae34633543038d471098e",
"assets/images/slhack.png": "31053661d9a9a3e91a1ec41c0682034a",
"assets/images/speaker.png": "61c04390ec139dba8e97de39b9c21cf1",
"assets/images/start_menu.ico": "434131cf5351e343bff0236cac601751",
"assets/images/start_menu.png": "cfa9745dc9d269f56bdd729edc0e2ef5",
"assets/images/time-machine-2019-09-25.png": "9eedce810fd785353c1b714f922c3010",
"assets/images/time_machine_docs.png": "8d52f4fd8648e24ae230fe5dde6053ca",
"assets/images/voice-memos-2019-09-25.png": "5f1cab8475bb4c63a4be84feda0616a4",
"assets/images/wifi.png": "e409b51973dbf83c5c096f0d7eacd66b",
"assets/NOTICES": "e62ed557882c0dc7c73f977df0b432b8",
"assets/packages/cupertino_icons/assets/CupertinoIcons.ttf": "115e937bb829a890521f72d2e664b632",
"favicon.png": "5dcef449791fa27946b3d35ad8803796",
"icons/Icon-192.png": "ac9a721a12bbc803b44f645561ecb1e1",
"icons/Icon-512.png": "96e752610906ba2a93c65f8abe1645f1",
"index.html": "8603afe063238debe1969f6f06961e20",
"/": "8603afe063238debe1969f6f06961e20",
"main.dart.js": "61c7679328e491978915c348e8efa2b6",
"manifest.json": "f36a275f86aa0c3b1a8b7c09a1ee87f3"
};

// The application shell files that are downloaded before a service worker can
// start.
const CORE = [
  "/",
"main.dart.js",
"index.html",
"assets/LICENSE",
"assets/AssetManifest.json",
"assets/FontManifest.json"];

// During install, the TEMP cache is populated with the application shell files.
self.addEventListener("install", (event) => {
  return event.waitUntil(
    caches.open(TEMP).then((cache) => {
      // Provide a no-cache param to ensure the latest version is downloaded.
      return cache.addAll(CORE.map((value) => new Request(value, {'cache': 'no-cache'})));
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
  var origin = self.location.origin;
  var key = event.request.url.substring(origin.length + 1);
  // Redirect URLs to the index.html
  if (event.request.url == origin || event.request.url.startsWith(origin + '/#')) {
    key = '/';
  }
  // If the URL is not the the RESOURCE list, skip the cache.
  if (!RESOURCES[key]) {
    return event.respondWith(fetch(event.request));
  }
  event.respondWith(caches.open(CACHE_NAME)
    .then((cache) =>  {
      return cache.match(event.request).then((response) => {
        // Either respond with the cached resource, or perform a fetch and
        // lazily populate the cache. Ensure the resources are not cached
        // by the browser for longer than the service worker expects.
        var modifiedRequest = new Request(event.request, {'cache': 'no-cache'});
        return response || fetch(modifiedRequest).then((response) => {
          cache.put(event.request, response.clone());
          return response;
        });
      })
    })
  );
});

self.addEventListener('message', (event) => {
  // SkipWaiting can be used to immediately activate a waiting service worker.
  // This will also require a page refresh triggered by the main worker.
  if (event.message == 'skipWaiting') {
    return self.skipWaiting();
  }

  if (event.message = 'downloadOffline') {
    downloadOffline();
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
  for (var resourceKey in Object.keys(RESOURCES)) {
    if (!currentContent[resourceKey]) {
      resources.add(resourceKey);
    }
  }
  return Cache.addAll(resources);
}

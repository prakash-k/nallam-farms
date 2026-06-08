'use strict';
const MANIFEST = 'flutter-app-manifest';
const TEMP = 'flutter-temp-cache';
const CACHE_NAME = 'flutter-app-cache';

const RESOURCES = {"assets/AssetManifest.bin": "cd8edda7af1f81c278409aae36165b12",
"assets/AssetManifest.bin.json": "4bba332971c7b0a44db44bd41ea37c3d",
"assets/AssetManifest.json": "8e821745a4b9e8d3251716bb006d7e6e",
"assets/assets/images/apron.png": "d128228353ee53974df6dd545c3cff43",
"assets/assets/images/aqua_blue_placemat.png": "c6ec8898cb5ae0cd89701feeea1bed5f",
"assets/assets/images/cat_cooling_bed.png": "37826abac78773dcd024a3e02749f497",
"assets/assets/images/coastal_sands_placemat.png": "186342d7debbc6b79ca7863f4b8f9e80",
"assets/assets/images/curtain.png": "44ca35cd0c944023b92be0393a1936be",
"assets/assets/images/cushion_cover.png": "bf365210dedfa79b468c71831bfa98bf",
"assets/assets/images/lime_green_placemat.png": "d4b12c68c72071bcaba47955ae11b00f",
"assets/assets/images/pet_bed.png": "503c75124539765b0f5bf52584af8513",
"assets/assets/images/pet_canopy_bed.png": "86fe0ebdb62644deb70715e8bcd87339",
"assets/assets/images/pet_fabric_canvas.png": "c7353371e35861ec8acdf155f038da8e",
"assets/assets/images/pet_fabric_corduroy.png": "a9a3569de8fc70c611665f024cee73f9",
"assets/assets/images/pet_fabric_lambswool.png": "07e9e7090d646aa2817faba7fbe427fc",
"assets/assets/images/pet_fabric_oxford.png": "2f65aad1b55cb6f5cefd8dba74ef9902",
"assets/assets/images/pet_fabric_plush.png": "c90e9b02183834770cfcbd83ab2fbbd9",
"assets/assets/images/pet_fill_cotton.png": "9b5d6bf408e8bd97fa9cf91f0567cad4",
"assets/assets/images/pet_fill_foam.png": "ab6d17290f5d85c51c5af144c45779b1",
"assets/assets/images/pet_fill_gel.png": "9867d65b3439b2c1d622bbf871817aeb",
"assets/assets/images/pet_fill_sponge.png": "713095b5558c325b89e33f84662a9fe7",
"assets/assets/images/pet_mat.png": "1c15e9de1630d27c5c8f4c7d2d0c192a",
"assets/assets/images/snuffle_mat.png": "dda91f820b9ad7af45fa02e9c0f66f91",
"assets/assets/images/upholstery_fabric.png": "2c6577e78618b6ba1c24e73e6550a7f9",
"assets/FontManifest.json": "7b2a36307916a9721811788013e65289",
"assets/fonts/MaterialIcons-Regular.otf": "6fed84ecda8d9a241ac1f6f514baefa6",
"assets/NOTICES": "e49e7934d64c8912d9e11edab1b55c86",
"assets/shaders/ink_sparkle.frag": "ecc85a2e95f5e9f53123dcaf8cb9b6ce",
"assets/web/farms/assets/about_farm.png": "5375e497c47b20a38fbe76684304d8d3",
"assets/web/farms/assets/category_organic.png": "c7519b57f090749620fbf7104a427f66",
"assets/web/farms/assets/category_produce.png": "7898d51319dfd6bb7434955a675f9ebb",
"assets/web/farms/assets/farming.jpg": "59f12992361534f4764d93635fc6c940",
"assets/web/farms/assets/groundnut.png": "e97b32bc0f8da182c854059e6becdb9c",
"assets/web/farms/assets/hero_background.png": "9185135dcd380b32be94994e3cc076f8",
"assets/web/farms/assets/nallam_founder.jpeg": "c7546c74c3347ae8114615c0db8bd1af",
"assets/web/farms/assets/sunset.png": "7a15bc6e08c8c5d9671ffbeef4889bde",
"canvaskit/canvaskit.js": "738255d00768497e86aa4ca510cce1e1",
"canvaskit/canvaskit.js.symbols": "74a84c23f5ada42fe063514c587968c6",
"canvaskit/canvaskit.wasm": "9251bb81ae8464c4df3b072f84aa969b",
"canvaskit/chromium/canvaskit.js": "901bb9e28fac643b7da75ecfd3339f3f",
"canvaskit/chromium/canvaskit.js.symbols": "ee7e331f7f5bbf5ec937737542112372",
"canvaskit/chromium/canvaskit.wasm": "399e2344480862e2dfa26f12fa5891d7",
"canvaskit/skwasm.js": "5d4f9263ec93efeb022bb14a3881d240",
"canvaskit/skwasm.js.symbols": "c3c05bd50bdf59da8626bbe446ce65a3",
"canvaskit/skwasm.wasm": "4051bfc27ba29bf420d17aa0c3a98bce",
"canvaskit/skwasm.worker.js": "bfb704a6c714a75da9ef320991e88b03",
"farms/assets/about_farm.png": "5375e497c47b20a38fbe76684304d8d3",
"farms/assets/category_organic.png": "c7519b57f090749620fbf7104a427f66",
"farms/assets/category_produce.png": "7898d51319dfd6bb7434955a675f9ebb",
"farms/assets/farming.jpg": "59f12992361534f4764d93635fc6c940",
"farms/assets/groundnut.png": "e97b32bc0f8da182c854059e6becdb9c",
"farms/assets/hero_background.png": "9185135dcd380b32be94994e3cc076f8",
"farms/assets/nallam_founder.jpeg": "c7546c74c3347ae8114615c0db8bd1af",
"farms/assets/sunset.png": "7a15bc6e08c8c5d9671ffbeef4889bde",
"farms/css/style.css": "bc800aa4da78d7b6b18d21f9b4c1f0d8",
"farms/index.html": "5ae6e5baad94788df85cd3a52b609ffd",
"farms/js/main.js": "6646a2dafff45daba1c090bf26964904",
"flutter.js": "383e55f7f3cce5be08fcf1f3881f585c",
"flutter_bootstrap.js": "31dd0bbc210e90c92efbb41648fabc95",
"index.html": "fd75b2b54c22e25a3ebdf795231448ab",
"/": "fd75b2b54c22e25a3ebdf795231448ab",
"main.dart.js": "73de0130daa076366489ed28aa5bfe25",
"version.json": "06eb48782ba43fb1b72c777e5a60fe31"};
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

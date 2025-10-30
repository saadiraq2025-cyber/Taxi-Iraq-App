// Service Worker - تكسي العراق الشامل
const CACHE_NAME = "taxi-iraq-cache-v1";
const urlsToCache = [
  "index.html",
  "rider.html",
  "driver.html",
  "admin.html",
  "app.js",
  "app.css",
  "manifest.json",
  "icon-192.png",
  "icon-512.png"
];

self.addEventListener("install", (event) => {
  event.waitUntil(
    caches.open(CACHE_NAME).then((cache) => cache.addAll(urlsToCache))
  );
});

self.addEventListener("fetch", (event) => {
  event.respondWith(
    caches.match(event.request).then((response) => response || fetch(event.request))
  );
});
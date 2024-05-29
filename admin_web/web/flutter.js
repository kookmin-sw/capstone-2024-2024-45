// flutter.js
(function() {
  window.addEventListener('load', function () {
    if (typeof FlutterLoader !== 'undefined') {
      FlutterLoader.loadEntrypoint({
        serviceWorker: {
          serviceWorkerVersion: '{{flutter_service_worker_version}}',
        },
      });
    } else {
      console.error("FlutterLoader is not defined");
    }
  });
})();

 (function () {
  var scheme = 'videohandler://';
  
  var videos = document.getElementsByTagName('video');
  
  for (var i = 0; i < videos.length; i++) {
  videos[i].addEventListener('webkitbeginfullscreen', onBeginFullScreen, false);
  videos[i].addEventListener('webkitendfullscreen', onEndFullScreen, false);
  }
  
  function onBeginFullScreen() {
  window.location = scheme + 'video-beginfullscreen';
  }
  
  function onEndFullScreen() {
  window.location = scheme + 'video-endfullscreen';
  }
  })();

function tooltip_lang_init() {
  var tooltips = document.querySelectorAll('#columns rect');
  for (var i = 0, length = tooltips.length; i < length; i++) {
    delay(tooltips[i].parentNode, set_tooltip);
  }
}

var delay = function (elem, callback) {
  // http://stackoverflow.com/questions/6231052/how-to-have-a-mouseover-event-fire-only-if-the-mouse-is-hovered-over-an-element
  var timeout = null;
  elem.onmouseover = function (event) {
    // Set timeout to be a timer which will invoke callback after delay
    // http://stackoverflow.com/questions/1190642/how-can-i-pass-a-parameter-to-a-settimeout-callback
    // https://developer.mozilla.org/en-US/docs/Web/API/WindowTimers/setTimeout
    var xPos = event.pageX;
    var yPos = event.pageY;
    context = elem;
    timeout = setTimeout(callback, 500, context, xPos, yPos);
  };
  elem.onmouseout = function () {
    // Clear any timers set to timeout
    clearTimeout(timeout);
  };
};

var set_tooltip = function (context, xPos, yPos) {
  var offset = parseInt(context.getElementsByTagName('text')[0].textContent, 16);
  // readCookie() is loaded in lgToggle.js
  var lg = readCookie('lg');
  var windowWidth = window.innerWidth;
  if (windowWidth - xPos < 150) {
    xPos = windowWidth - 155;
  };
  var popupId = "n" + Math.random();
  // overlay.setAttribute("onmouseout", "document.body.removeChild(document.getElementById('" + popupId + "'))");
  var xhttp = new XMLHttpRequest();
  xhttp.onreadystatechange = function () {
    if (xhttp.readyState == 4 && xhttp.status == 200) {
      let overlay = document.getElementById("overlay");
      overlay.innerHTML = xhttp.responseText;
      overlay.style.left = xPos + "px";
      overlay.style.top = yPos + "px";
    }
  };
  xhttp.open("GET", "ajax-title-by-lg?offset=" + offset, true);
  xhttp.send();
}
window.addEventListener('DOMContentLoaded', tooltip_lang_init, false);
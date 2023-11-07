function tooltip_lang_init() {
    var triggers = document.querySelectorAll('#columns rect');
    for (var i = 0, length = triggers.length; i < length; i++) {
        delay(triggers[i].parentNode, set_tooltip);
        triggers[i].addEventListener('mouseout', hide_tooltip);
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

hide_tooltip = function() {
  let tooltip = document.getElementById('tooltip');
  tooltip.setAttributeNS(null, "visibility", "hidden");  
}

set_tooltip = function(context, xPos, yPos) {
  let tooltip = document.getElementById('tooltip');
  tooltip.setAttributeNS(null, "visibility", "visible");
}
//set_tooltip = function (context, xPos, yPos) {
//    // relies on first class value always being cXXXX
//    // set correctly on <g> parent of <rect>
//    let input_text = context.getElementsByTagName('rect')[0].classList[0].substring(1);
//    let offset = parseInt(input_text, 16);
//    // readCookie() is loaded in lgToggle.js
//    let lg = readCookie('lg');
//    let overlay = document.createElement("div");
//    let windowWidth = window.innerWidth;
//    if (windowWidth - xPos < 150) {
//        xPos = windowWidth - 155;
//    };
//    let popupId = "n" + Math.random();
//    overlay.setAttribute("id", popupId);
//    overlay.setAttribute("style", "font-size: smaller; z-index: 10; position: absolute; left: " + xPos + "px; top: " + yPos + "px; background-color: aqua; border: 2px solid black; max-width: 150px; padding: 2px; margin: 0;")
//    overlay.setAttribute("class", "overlay");
//    // overlay.setAttribute("onmouseout", "document.body.removeChild(document.getElementById('" + popupId + "'))");
//    let xhttp = new XMLHttpRequest();
//    xhttp.onreadystatechange = function () {
//        if (xhttp.readyState == 4 && xhttp.status == 200) {
//            overlay.innerHTML = xhttp.responseText;
//            // remove all existing overlays before creating a new one
//            let overlays = document.getElementsByClassName('overlay');
//            for (var i = 0, length = overlays.length; i < length; i++) {
//                document.body.removeChild(overlays[i]);
//            }
//            document.body.appendChild(overlay);
//            setTimeout(function () {
//                if (document.getElementById(popupId)) {
//                    document.body.removeChild(document.getElementById(popupId))
//                }
//            },
//            5000);
//        }
//    };
//    xhttp.open("GET", "ajax-title-by-lg?offset=" + offset, true);
//    xhttp.send();
//}
window.addEventListener('DOMContentLoaded', tooltip_lang_init, false);

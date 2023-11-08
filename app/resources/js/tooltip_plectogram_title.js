"use strict";
function tooltip_lang_init() {
    var tooltips = document.querySelectorAll('#columns rect');
    for (var i = 0, length = tooltips.length; i < length; i++) {
        delay(tooltips[i].parentNode, set_tooltip);
    }
}

let delay = function (elem, callback) {
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

let set_tooltip = function (context, xPos, yPos) {
    var input_text = context.getElementsByTagName('rect')[0].getAttributeNS('http://www.obdurodon.org', 'title')
    // readCookie() is loaded in lgToggle.js
    var lg = readCookie('lg');
    var overlay = document.createElement("div");
    var windowWidth = window.innerWidth;
    if (windowWidth - xPos < 150) {
        xPos = windowWidth - 155;
    };
    var popupId = "n" + Math.random();
    overlay.setAttribute("id", popupId);
    overlay.setAttribute("style", "font-size: smaller; z-index: 10; position: absolute; left: " + xPos + "px; top: " + yPos + "px; background-color: aqua; border: 2px solid black; max-width: 150px; padding: 2px; margin: 0;")
    overlay.setAttribute("class", "overlay");
    // overlay.setAttribute("onmouseout", "document.body.removeChild(document.getElementById('" + popupId + "'))");
    var xhttp = new XMLHttpRequest();
    xhttp.onreadystatechange = function () {
        if (xhttp.readyState == 4 && xhttp.status == 200) {
            overlay.innerHTML = xhttp.responseText;
            // remove all existing overlays before creating a new one
            var overlays = document.getElementsByClassName('overlay');
            for (var i = 0, length = overlays.length; i < length; i++) {
                document.body.removeChild(overlays[i]);
            }
            document.body.appendChild(overlay);
            setTimeout(function () {
                if (document.getElementById(popupId)) {
                    document.body.removeChild(document.getElementById(popupId))
                }
            },
            5000);
        }
    };
    xhttp.open("GET", "http://repertorium.obdurodon.org:8080/exist/rest/db/repertorium/xquery/title_by_lang.xql?bg=" + input_text + "&lg=" + lg, true);
    xhttp.send();
}
window.addEventListener('DOMContentLoaded', tooltip_lang_init, false);

"use strict";
window.addEventListener('DOMContentLoaded', (e) => {
    document.querySelectorAll('fieldset input').forEach(checkbox => {
        checkbox.addEventListener('click', runSearch, false);
    })
    document.getElementById("query-string").addEventListener("keyup", debounceForData, false);
    document.getElementById("reset").addEventListener("click", reset, false);
},
false);

function runSearch() {
    document.getElementById('submit').click();
}

// Debounce code from https://dev.to/sbrshkappa/what-is-debouncing-a-javascript-implementation-3aoh
// AJAX code from https://blog.openreplay.com/ajax-battle-xmlhttprequest-vs-the-fetch-api
const getSuggestions = (e) => {
    let qt = document.getElementById("query-string").value;
    // input string
    if (![ 'ArrowRight', 'ArrowLeft', 'ArrowDown', 'ArrowUp'].includes(e.code) && qt.length >= 3) {
        const xhr = new XMLHttpRequest();
        let target = document.getElementById("titles");
        // <datalist>
        xhr.open("GET", `ajax-article-titles?query-string=${qt}`);
        xhr.responseType = 'document';
        xhr.overrideMimeType('text/xml');
        // state change event
        xhr.onreadystatechange = () => {
            // is request complete?
            if (xhr.readyState !== 4) return;
            if (xhr.status === 200) {
                // request successful
                let options = xhr.responseXML.querySelectorAll("option");
                target.innerHTML = "";[].forEach.call(options, function (item) {
                    target.appendChild(item);
                });
            } else {
                // request not successful
                console.log("HTTP error", xhr.status, xhr.statusText);
            }
        };
        // start request
        xhr.send();
    }
}

const debounce = function (fn, d) {
    let timer;
    return function () {
        let context = this, args = arguments;
        clearTimeout(timer);
        timer = setTimeout(() => {
            fn.apply(context, args);
        },
        d)
    }
}

const debounceForData = debounce(getSuggestions, 250);

function reset() {
    window.location.href = 'search';
}
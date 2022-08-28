"use strict";
window.addEventListener('DOMContentLoaded', (e) => {
    document.querySelectorAll('fieldset input').forEach(checkbox => {
        checkbox.addEventListener('click', runSearch, false);
    })
},
false);
function runSearch() {
    document.getElementById('submit').click();
};
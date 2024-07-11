"use strict";
/*
 * Manage faceted search interface for Repertorium
 */

document.addEventListener('DOMContentLoaded', (e) => {
    /* Attach event listeners to country, settlement, repository drop-downs
       Resubmit the form on every checkbox change, but text input requires manual "Submit" press*/
    let dropdowns = document.getElementsByTagName('select');
    // console.log("in init: dropdowns = " + dropdowns + "(count: " + dropdowns.length + ")");
    for (var i = 0, length = dropdowns.length; i < length; i++) {
        dropdowns[i].addEventListener('change', process_dropdown_change, false);
    }
    document.getElementById('submit').addEventListener('click', remove_null_params, false);
    document.getElementById('clear-form').addEventListener('click', clear_form, false);
});
/*
 * Resubmit form on every dropdown change
 */
function process_dropdown_change() {
    console.log("Processing");
    remove_null_params();
    console.log("Processed");
    document.getElementById('submit').click();
}
function clear_form() {
    window.location.href = window.location.pathname;
}
function remove_null_params() {
    let form = document.getElementsByTagName("form")[0];
    let elements = form.elements;
    for (var i = 0, len = elements.length; i < len; i++) {
        if (elements[i].value === "") elements[i].disabled = true;
    }
}

/*
Filename: lgToggle.js
Author: David J. Birnbaum
Date: 2013-08-09
Copyright: Creative Commons BY-NC-SA 3.0 (http://creativecommons.org/licenses/by-nc-sa/3.0/)
Project home page: http://repertorium.obdurodon.org
Project director: David J. Birnbaum (djbpitt@gmail.com)
Synopsis: Toggles language of Repertorium project pages
 */

//Cookie management functions from http://www.quirksmode.org/js/cookies.html
function createCookie(name, value, days) {
    if (days) {
        var date = new Date();
        date.setTime(date.getTime() +(days * 24 * 60 * 60 * 1000));
        var expires = "; expires=" + date.toGMTString();
    } else var expires = "";
    document.cookie = name + "=" + value + expires + "; path=/";
}

function readCookie(name) {
    var nameEQ = name + "=";
    var ca = document.cookie.split(';');
    for (var i = 0; i < ca.length; i++) {
        var c = ca[i];
        while (c.charAt(0) == ' ') c = c.substring(1, c.length);
        if (c.indexOf(nameEQ) == 0) return c.substring(nameEQ.length, c.length);
    }
    return null;
}

//Project-specific code begins here

/*
 * Listen for clicks on flags to change language
 * When the page loads, create a new cookie with the old value, so that
 *   it's always good for 30 days
 */
function lg_init() {
    var i, length;
    var flags = document.getElementsByClassName('flag');
    for (i = 0, length = flags.length; i < length; i++) {
        flags[i].addEventListener('click', changeLang, false);
    }
    
    var lang = readCookie('lg');
    if ([ 'bg', 'en', 'ru'].indexOf(lang) == -1) {
        // default to bg if no value has been selected
        lang = 'bg;'
    }
    createCookie('lg', lang, 30);
    changeLang();
    
    var links = document.getElementsByTagName('a')
    for (i = 0, length = links.length; i < length; i++) {
        links[i].addEventListener('click', languageCookie, false);
    }
}
function languageCookie () {
    var current_href = this.getAttribute('href');
    if (current_href.indexOf("?") > -1) {
        // there's already a query string, so add to it
        // this will break if there's a '#' in the url, which isn't an issue for us
        this.setAttribute('href', current_href + '&lg=' + readCookie('lg'));
    } else {
        // there isn't, so create one
        this.setAttribute('href', current_href + '?lg=' + readCookie('lg'));
    }
}
/*
 * Called from init and when a lg flag is clicked;
 * if this.id is undefined, it's been called from init, so use the current cookie value (if any)
 * otherwise get the language from the flag that's been clicked
 */
function changeLang() {
    if (typeof this.id === 'undefined') {
        var id = readCookie('lg')
    } else {
        var id = this.id;
    }
    createCookie('lg', id, 30);
    var bgs = document.getElementsByClassName('bg');
    var bgsLength = bgs.length;
    var ens = document.getElementsByClassName('en');
    var ensLength = ens.length;
    var rus = document.getElementsByClassName('ru');
    var rusLength = rus.length;
    var flagImgs = document.querySelectorAll('.flag > img');
    var flagImgsLength = flagImgs.length;
    for (var i = 0; i < flagImgsLength; i++) {
        if (flagImgs[i].parentNode.id == id) {
            flagImgs[i].style.boxShadow = '0 0 5px brown';
        } else {
            flagImgs[i].style.boxShadow = 'none';
        }
    }
    // The form action needs to hold the current cookie value
    if (document.getElementById('lg_hidden')) {
        lg_hidden = document.getElementById('lg_hidden');
        lg_hidden.setAttribute('value', id);
    }
    switch (id) {
        case 'bg':
        for (var i = 0; i < bgsLength; i++) {
            // bgs[i].style.display = 'inline';
            bgs[i].classList.add('lg');
            bgs[i].classList.remove('hide');
            bgs[i].removeAttribute('style');
        }
        for (var i = 0; i < ensLength; i++) {
            // ens[i].style.display = 'none';
            ens[i].classList.remove('lg');
            ens[i].classList.add('hide');
            ens[i].removeAttribute('style');
        }
        for (var i = 0; i < rusLength; i++) {
            // rus[i].style.display = 'none';
            rus[i].classList.remove('lg');
            rus[i].classList.add('hide');
            rus[i].removeAttribute('style');
        }
        break;
        case 'en':
        for (var i = 0; i < bgsLength; i++) {
            // bgs[i].style.display = 'none';
            bgs[i].classList.remove('lg');
            bgs[i].classList.add('hide');
            bgs[i].removeAttribute('style');
        }
        for (var i = 0; i < ensLength; i++) {
            // ens[i].style.display = 'inline';
            ens[i].classList.add('lg');
            ens[i].classList.remove('hide');
            ens[i].removeAttribute('style');
        }
        for (var i = 0; i < rusLength; i++) {
            // rus[i].style.display = 'none';
            rus[i].classList.remove('lg');
            rus[i].classList.add('hide');
            rus[i].removeAttribute('style');
        }
        break;
        case 'ru':
        for (var i = 0; i < bgsLength; i++) {
            // bgs[i].style.display = 'none';
            bgs[i].classList.remove('lg');
            bgs[i].classList.add('hide');
            bgs[i].removeAttribute('style');
        }
        for (var i = 0; i < ensLength; i++) {
            // ens[i].style.display = 'none';
            ens[i].classList.remove('lg');
            ens[i].classList.add('hide');
            ens[i].removeAttribute('style');
        }
        for (var i = 0; i < rusLength; i++) {
            // rus[i].style.display = 'inline';
            rus[i].classList.add('lg');
            rus[i].classList.remove('hide');
            rus[i].removeAttribute('style');
        }
    }
}
/*
 * use addEventListener instead of window.onload= in order to add
 * onload events in multiple scrips without overwriting
 */
window.addEventListener('DOMContentLoaded', lg_init, false);
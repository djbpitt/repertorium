window.addEventListener('DOMContentLoaded', (e) => {
    document.querySelectorAll('.flag').forEach(flag => {
        flag.addEventListener('click', toggleLanguage, false);
    })
},
false);

const toggleLanguage = function () {
    /* toggle language and set lg cookie */
    document.querySelector('body').setAttribute('class', this.id);
    document.cookie = 'lg=' + this.id;
}

const readLanguage = function () {
    /* Get all cookies, split into rows, find lg row, return value
     * Splitting on '=' will error out if no such row, so test first
     * Returns null if not set */
    const languageRow = document.cookie.split('; ').find((row) => row.startsWith('lg='))
    if (languageRow) {
        return languageRow.split('=')[1]
    } else {
        return null
    }
}
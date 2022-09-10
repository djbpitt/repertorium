window.addEventListener('DOMContentLoaded', (e) => {
    document.querySelectorAll('.flag').forEach(flag => {
        let lg = (readLanguage()) ? readLanguage():'bg';
        document.getElementById(lg).classList.add('highlight');
        flag.addEventListener('click', toggleLanguage, false);
    })
},
false);

const toggleLanguage = function () {
    /* toggle language and set lg cookie */
    document.querySelector('body').setAttribute('class', this.id);
    document.cookie = 'lg=' + this.id;
    remove_highlighting();
    document.getElementById(this.id).classList.add('highlight');
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

const remove_highlighting = function () {
    /* Unhighlight all flags in preparation for highlighting new selection */
    document.querySelectorAll('.flag').forEach(flag => {
        flag.classList.remove('highlight');
    })
}
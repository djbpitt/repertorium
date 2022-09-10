window.addEventListener('DOMContentLoaded', (e) => {
    document.querySelectorAll('.flag').forEach(flag => {
        let lg = (readLanguage()) ? readLanguage(): 'bg';
        document.getElementById(lg).classList.add('highlight');
        flag.addEventListener('click', toggleLanguage, false);
    })
},
false);

const toggleLanguage = function () {
    /* toggle language and set lg cookie */
    document.querySelector('body').setAttribute('class', this.id);
    document.cookie = 'lg=' + this.id;
    /* Remove highlighting from all flags and highlight selected one */
    remove_highlighting();
    document.getElementById(this.id).classList.add('highlight');
    /* If on search page, change prompt in query-string prompt */
    if (document.querySelector('main').id == 'search') {
        var language_name;
        switch (this.id) {
            case 'ru':
            language_name = 'Russian';
            break;
            case 'en':
            language_name = 'English';
            break;
            default:
            language_name = 'Bulgarian';
        }
        document.getElementById('query-string').setAttribute('placeholder', '[Enter partial title in ' + language_name + ' or change language]')
    }
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
xquery version "3.1";
declare namespace xinclude = "http://www.w3.org/2001/XInclude";
declare variable $title external;
declare variable $fqcontroller external;
declare variable $resource external;
(:
    slider:         plectogram
    plectogram:     browse, search
    browse/search:  browse, search, encoding-policies-updates
    languages
:)
<div
    xmlns="http://www.w3.org/1999/xhtml">
    <h1><a
            href="{concat($fqcontroller, '/')}"
            class="logo">&lt;rep&gt;</a>
        <cite>Repertorium of Old Bulgarian Literature and Letters</cite></h1>
    <hr/>
    <div
        class="boilerplate">
        <span
            class="text"><strong>Maintained by:</strong> David J. Birnbaum (<a
                href="mailto:djbpitt@gmail.com">djbpitt@gmail.com</a>) <a
                href="http://creativecommons.org/licenses/by-nc-sa/4.0/"
                style="outline: none;">
                <img
                    src="{concat($fqcontroller, 'resources/images/cc-by-nc-sa-80x15.png')}"
                    alt="[Creative Commons BY-NC-SA 4.0 International License]"
                    title="Creative Commons BY-NC-SA 4.0 International License"
                    style="height: 1em; vertical-align: text-bottom;"/>
            </a>
        </span>
        <span
            class="flags">
            {
                if ($resource = ('plectogram')) then
                    <span
                        id="slider">
                        <input
                            id="slider1"
                            type="range"
                            value="1"
                            min="0.1"
                            max="2"
                            step="0.01"/>
                    </span>
                else
                    ()
            }
            <span
                id="codic">
                <a
                    title="codic"
                    id="codicLink"
                    href="placeholder"
                ><!--#include virtual="../images/codicology.svg" --></a>
            </span>
            <span
                id="texts">
                <a
                    title="texts"
                    id="textsLink"
                    href="placeholder"
                ><!--#include virtual="../images/texts.svg" --></a>
            </span>
            <span
                id="xml">
                <a
                    title="XML"
                    id="xmlLink"
                    href="placeholder"
                ><!--#include virtual="../images/xml.svg" --></a>
            </span>
            <span
                id="plectogram">
                <input
                    type="image"
                    src="{concat($fqcontroller, 'resources/images/ico_compare.png')}"
                    id="plectogram_image"
                    height="16"
                    width="16"
                    title="Generate plectogram"
                    alt="[Generate plectogram]"/>
            </span>
            <span
                id="browse">
                <a
                    title="Browse the collection"
                    href="browse">
                    <img
                        src="{concat($fqcontroller, 'resources/images/browse.png')}"
                        alt="[Browse]"/>
                </a>
            </span>
            <span
                id="search">
                <a
                    title="Search the collection"
                    href="search">
                    <img
                        src="{concat($fqcontroller, 'resources/images/search.png')}"
                        alt="[Search]"/>
                </a>
            </span>
            {
                if ($resource = ('browse', 'search')) then
                    (<span>&#xa0;&#xa0;</span>,
                    <span
                        class="flag"
                        id="bg">
                        <img
                            title="Use Bulgarian titles"
                            src="{concat($fqcontroller, 'resources/images/bg.png')}"
                            alt="[Bulgarian]"/>
                    </span>,
                    <span
                        class="flag"
                        id="en">
                        <img
                            title="Use English titles"
                            src="{concat($fqcontroller, 'resources/images/us.png')}"
                            alt="[Englist]"/>
                    </span>,
                    <span
                        class="flag"
                        id="ru">
                        <img
                            title="Use Russian titles"
                            src="{concat($fqcontroller, 'resources/images/ru.png')}"
                            alt="[Russian]"/>
                    </span>)
                else
                    ()
            }
        </span>
        <span
            class="text">
            <strong>Last modified: </strong>
            {current-dateTime()}
        </span>
    </div>
    <hr/>
    <h2>{$title}</h2>
</div>

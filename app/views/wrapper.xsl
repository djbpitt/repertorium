<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    xmlns:math="http://www.w3.org/2005/xpath-functions/math"
    xpath-default-namespace="http://www.w3.org/1999/xhtml" xmlns="http://www.w3.org/1999/xhtml"
    exclude-result-prefixes="#all" version="3.0">
    <xsl:output method="xhtml" html-version="5" omit-xml-declaration="no" include-content-type="no"
        indent="yes" byte-order-mark="no"/>
    <xsl:param name="xslt.fqcontroller" required="yes"/>
    <xsl:param name="xslt.lg" required="yes"/>
    <xsl:template match="/">
        <html>
            <head>
                <title>
                    <xsl:value-of select="descendant::h2"/>
                </title>
                <link rel="stylesheet" type="text/css" href="resources/css/repertorium.css"/>
                <link rel="stylesheet" type="text/css" href="resources/fonts/font.css"/>
                <link rel="icon" href="favicon.svg" type="image/svg+xml"/>
                <!--<script type="text/javascript" src="resources/js/lgToggle.js"/>-->
            </head>
            <body class="{$xslt.lg}">
                <header>
                    <h1><a class="logo" href="index"><span>&lt;rep&gt;</span></a> Repertorium of Old
                        Bulgarian Literature and Letters</h1>
                    <div id="flags">
                        <span id="plectogram">
                            <input type="image" src="resources/images/ico_compare.png"
                                id="plectogram_image" height="16" width="16"
                                title="Generate plectogram" alt="[Generate plectogram]"/>
                        </span>

                        <span id="browse">
                            <a title="Browse the collection" href="/browse-checkbox.php">
                                <img src="resources/images/browse.png" alt="[Browse]"/>
                            </a>
                        </span>
                        <span id="search">
                            <a title="Search the collection" href="/search.php">
                                <img src="resources/images/search.png" alt="[Search]"/>
                            </a>
                        </span>
                        <xsl:text>&#xa0;&#xa0;</xsl:text>
                        <span class="flag" id="bg">
                            <img title="Use Bulgarian titles" src="resources/images/bg.png"
                                alt="[Bulgarian]"/>
                        </span>
                        <span class="flag" id="en">
                            <img title="Use English titles" src="resources/images/us.png"
                                alt="[Englist]"/>
                        </span>
                        <span class="flag" id="ru">
                            <img title="Use Russian titles" src="resources/images/ru.png"
                                alt="[Russian]"/>
                        </span>
                    </div>
                </header>
                <main>
                    <xsl:copy-of select="descendant::section[not(ancestor::section)]/node()"/>
                </main>
                <footer>
                    <hr/>
                    <p>Anisava Miltenova, Andrej Bojadžiev, Dilyana Radoslavova, and David J.
                        Birnbaum. Results generated <xsl:value-of select="
                                current-dateTime() =>
                                format-dateTime('[Y0001]-[M01]-[D01] at [H01]:[m01]:[s01] [z,6-6]')
                                "/>. <a
                            href="https://creativecommons.org/licenses/by-nc-sa/4.0/"><img
                                title="[CC BY-NC-SA 4.0]"
                                src="resources/images/cc-by-nc-sa-80x15.png"/></a>
                    </p>
                </footer>
            </body>
        </html>
    </xsl:template>
</xsl:stylesheet>

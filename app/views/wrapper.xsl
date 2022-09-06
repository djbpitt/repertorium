<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    xmlns:math="http://www.w3.org/2005/xpath-functions/math"
    xpath-default-namespace="http://www.w3.org/1999/xhtml" xmlns="http://www.w3.org/1999/xhtml"
    exclude-result-prefixes="#all" version="3.0">
    <xsl:output method="xhtml" html-version="5" omit-xml-declaration="no" include-content-type="no"
        indent="yes" byte-order-mark="no"/>
    <xsl:param name="xslt.fqcontroller" required="yes"/>
    <xsl:param name="xslt.resource" required="yes"/>
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
                <script type="text/javascript" src="resources/js/lgToggle.js"/>
            </head>
            <body class="{$xslt.lg}">
                <header>
                    <h1><a class="logo" href="index"><span>&lt;rep&gt;</span></a> Repertorium of Old
                        Bulgarian Literature and Letters</h1>
                    <div id="flags">
                        <img src="resources/images/compare.svg" id="plectogram_image" height="16"
                            width="16" title="Generate plectogram" alt="[Generate plectogram]"/>
                        <img src="resources/images/magnifying-glass-search-svgrepo-com.svg"
                            alt="[Search]"/>
                        <xsl:text>&#xa0;&#xa0;</xsl:text>
                        <img title="Use Bulgarian titles" src="resources/images/bg.png" id="bg"
                            alt="[Bulgarian]" class="flag"/>
                        <img title="Use English titles" src="resources/images/us.png" id="en"
                            alt="[Englist]" class="flag"/>
                        <img title="Use Russian titles" src="resources/images/ru.png" id="ru"
                            alt="[Russian]" class="flag"/>
                    </div>
                </header>
                <main id="{$xslt.resource}">
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

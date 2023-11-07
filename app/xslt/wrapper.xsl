<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    xmlns:math="http://www.w3.org/2005/xpath-functions/math" xmlns:svg="http://www.w3.org/2000/svg"
    xpath-default-namespace="http://www.w3.org/1999/xhtml" xmlns="http://www.w3.org/1999/xhtml"
    exclude-result-prefixes="#all" version="3.0">
    <xsl:output method="xhtml" html-version="5" omit-xml-declaration="no" include-content-type="no"
        indent="no" byte-order-mark="no"/>
    <xsl:param name="xslt.fqcontroller" required="no"/>
    <xsl:param name="xslt.query-filename" required="no"/>
    <!-- ================================================================ -->
    <!-- Page-top widgets                                                 -->
    <!-- Classes:                                                         -->
    <!--   view: codicology, titles, xml                                  -->
    <!--   nav: search, plectogram, bibliography                          -->
    <!--   flag: languages                                                -->
    <!-- ================================================================ -->
    <xsl:variable name="titles" as="element(span)">
        <span class="view" id="titles">
            <a href="titles?filename={$xslt.query-filename}">
                <img title="Explore contents" src="resources/images/texts.svg"
                    alt="[Explore contents]"/>
            </a>
        </span>
    </xsl:variable>
    <xsl:variable name="codicology" as="element(span)">
        <span class="view" id="codicology">
            <a href="codicology?filename={$xslt.query-filename}">
                <img title="Read codicological description" src="resources/images/codicology.svg"
                    alt="[Read codicological description]"/>
            </a>
        </span>
    </xsl:variable>
    <xsl:variable name="xml" as="element(span)">
        <span class="view" id="xml">
            <a href="mss/{$xslt.query-filename}">
                <img title="View XML source" src="resources/images/xml.svg" alt="[View XML source]"
                />
            </a>
        </span>
    </xsl:variable>
    <xsl:variable name="search" as="element(span)">
        <span class="nav" id="search">
            <a href="search">
                <img title="Search manuscripts" src="resources/images/eye-monitoring-icon.svg"
                    alt="[Search manuscripts]"/>
            </a>
        </span>
    </xsl:variable>
    <xsl:variable name="bibliography" as="element(span)">
        <span class="nav" id="bibliography">
            <a href="bibliography">
                <img title="Explore bibliography"
                    src="resources/images/books-stack-of-three-svgrepo-com.svg"
                    alt="[Explore bibliography]"/>
            </a>
        </span>
    </xsl:variable>
    <xsl:variable name="plectogram" as="element(button)">
        <!--        <span class="nav" id="plectogram">
            <a href="plectogram">
                <img title="Create plectogram" src="resources/images/plectogram.svg"
                    alt="[Create plectogram]"/>
            </a>
        </span>-->
        <button type="submit" form="plectogram-form">
            <img title="Create plectogram" src="resources/images/plectogram.svg"
                alt="[Create plectogram]"/>
        </button>
    </xsl:variable>
    <xsl:variable name="slider" as="element(span)">
        <span id="slider">
            <input id="slider1" type="range" value="1" min="0.1" max="2" step="0.01"/>
        </span>
    </xsl:variable>
    <xsl:variable name="flags" as="element(span)+">
        <span class="flag" id="bg">
            <img title="Use Bulgarian titles" src="resources/images/bg.svg" alt="[Bulgarian]"/>
        </span>
        <span class="flag" id="en">
            <img title="Use English titles" src="resources/images/us.svg" alt="[Englist]"/>
        </span>
        <span class="flag" id="ru">
            <img title="Use Russian titles" src="resources/images/ru.svg" alt="[Russian]"/>
        </span>
    </xsl:variable>

    <!-- ================================================================ -->
    <!-- Main                                                             -->
    <!-- ================================================================ -->
    <xsl:template match="/">
        <html>
            <head>
                <title>
                    <xsl:choose>
                        <!-- ============================================ -->
                        <!-- Main page headers are all <h2>               -->
                        <!-- ============================================ -->
                        <xsl:when test="descendant::main/@id eq 'index'">Repertorium</xsl:when>
                        <xsl:when test="descendant::main/@id eq 'titles'">Article titles</xsl:when>
                        <xsl:otherwise>
                            <xsl:value-of select="descendant::h2"/>
                        </xsl:otherwise>
                    </xsl:choose>
                </title>
                <link rel="stylesheet" type="text/css" href="resources/css/style.css"/>
                <link rel="stylesheet" type="text/css" href="resources/css/repertorium.css"/>
                <link rel="icon" href="resources/images/favicon.ico" type="image/svg+xml"/>
                <script src="resources/js/lgToggle.js"/>
                <xsl:if test="descendant::main/@id eq 'main_svg'">
                    <script src="resources/js/plectogram.js"></script>
                    <script src="resources/js/plectogram_drag.js"></script>
                    <script src="resources/js/tooltip_plectogram_title.js"></script>
                </xsl:if>
                <xsl:if test="descendant::main/@id eq 'search'">
                    <script src="resources/js/search.js"/>
                </xsl:if>
            </head>
            <body>
                <header>
                    <h1><a class="logo" href="index"><span>&lt;rep&gt;</span></a> Repertorium of Old
                        Bulgarian Literature and Letters</h1>
                </header>
                <xsl:apply-templates select="main"/>
                <footer>
                    <hr/>
                    <p>Maintained by David J. Birnbaum. Results generated <xsl:value-of select="
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
    <xsl:template match="h2[not(ancestor::main/@id = ('index'))]" priority="10">
        <!-- ============================================================ -->
        <!-- Surround title with rule on all pages except main            -->
        <!-- ============================================================ -->
        <hr/>
        <xsl:next-match/>
        <hr/>
    </xsl:template>
    <xsl:template match="h2">
        <h2>
            <xsl:apply-templates/>
            <span id="widgets">
                <xsl:choose>
                    <xsl:when test="../@id eq 'search'">
                        <xsl:sequence select="$plectogram, $bibliography, $flags"/>
                    </xsl:when>
                    <xsl:when test="../@id eq 'codicology'">
                        <xsl:sequence select="$titles, $xml, $plectogram, $search, $bibliography"/>
                    </xsl:when>
                    <xsl:when test="../@id eq 'titles'">
                        <xsl:sequence select="$codicology, $xml, $search, $bibliography, $flags"/>
                    </xsl:when>
                    <xsl:when test="../@id eq 'main_svg'">
                        <xsl:sequence select="$slider, $search, $bibliography, $flags"/>
                    </xsl:when>
                </xsl:choose>
            </span>
        </h2>
    </xsl:template>
    <xsl:template match="h2[. eq 'Repertorium']">
        <!-- ============================================================ -->
        <!-- Suppress textual value of <h2> for main page (only)          -->
        <!-- (<h2> is needed because it's also used for <title>)          -->
        <!-- ============================================================ -->
        <xsl:apply-templates select="img"/>
    </xsl:template>
    <xsl:template match="main">
        <main>
            <xsl:copy-of select="@id"/>
            <xsl:apply-templates/>
        </main>
    </xsl:template>
    <xsl:template match="svg:svg">
        <!-- ============================================================ -->
        <!-- Retain namespace only for SVG (others are in m:)             -->
        <!-- ============================================================ -->
        <xsl:copy-of select="."/>
    </xsl:template>
    <xsl:template match="*">
        <xsl:element name="{local-name()}">
            <xsl:copy-of select="@*"/>
            <xsl:apply-templates/>
        </xsl:element>
    </xsl:template>
</xsl:stylesheet>

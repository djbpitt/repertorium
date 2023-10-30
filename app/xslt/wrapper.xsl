<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    xmlns:math="http://www.w3.org/2005/xpath-functions/math"
    xmlns:svg="http://www.w3.org/2000/svg"
    xpath-default-namespace="http://www.w3.org/1999/xhtml" 
    xmlns="http://www.w3.org/1999/xhtml"
    exclude-result-prefixes="#all" version="3.0">
    <xsl:output method="xhtml" html-version="5" omit-xml-declaration="no" include-content-type="no"
        indent="no" byte-order-mark="no"/>
    <xsl:param name="xslt.fqcontroller" required="yes"/>
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
                <script src="resources/js/lgToggle.js"></script>
                <xsl:if test="descendant::main/@id eq 'search'">
                    <script src="resources/js/search.js"></script>
                </xsl:if>
            </head>
            <body>
                <header>
                    <h1><a class="logo" href="index"><span>&lt;rep&gt;</span></a> Repertorium of Old
                        Bulgarian Literature and Letters</h1>
                </header>
                <xsl:apply-templates select="main"/>
                <!--
                <span id="plectogram"><input type="image" src="../resources/images/ico_compare.png" id="plectogram_image" height="16" width="16" title="Generate plectogram" alt="[Generate plectogram]"/></span>
                <span id="browse"><a title="Browse the collection" href="browse"><img src="../resources/images/browse.png" alt="[Browse]"/></a></span>
                <span id="search"><a title="Search the collection" href="search"><img src="../resources/images/search.png" alt="[Search]"/></a></span>
                -->

                <footer>
                    <hr/>
                    <p>Maintained by David J. Birnbaum. Results generated
                            <xsl:value-of select="
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
    <xsl:template match="h2[not(ancestor::main/@id = ('titles', 'index'))]" priority="10">
        <!-- Surround title with rule on all pages except main and titles -->
        <hr/>
        <xsl:next-match/>
        <hr/>
    </xsl:template>
    <xsl:template match="h2">
        <h2>
            <xsl:apply-templates/>
            <xsl:if test="../@id ne 'index' and not(following-sibling::*[1][self::h2])">
                <span id="widgets">
                    <span class="flags">
                        <!--
                            Slider: plectogram.php, plectogram-dev-checkbox.php
                            Codicology: readFile.php
                            Texts: msDesc.php
                            XML: readFile.php, msDesc.php
                            Plectogram (ico_compare.png): browse.php, 
                                browse-checkbox.php, 
                                runSearch.php, 
                                runSearch-checkbox.php, 
                                searchTitlesFree.php, 
                                worksByAuthor.php
                            Browse, search, lg flags: All
                        -->
                        <span>&#xa0;&#xa0;</span>
                        <span class="flag" id="bg"><img title="Use Bulgarian titles" src="resources/images/bg.svg" alt="[Bulgarian]"/></span>
                        <span class="flag" id="en"><img title="Use English titles" src="resources/images/us.svg" alt="[Englist]"/></span>
                        <span class="flag" id="ru"><img title="Use Russian titles" src="resources/images/ru.svg" alt="[Russian]"/></span>
                    </span>
                </span>
            </xsl:if>
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

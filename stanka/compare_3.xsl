<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xhtml="http://www.w3.org/1999/xhtml" xmlns="http://www.w3.org/1999/xhtml"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    xmlns:math="http://www.w3.org/2005/xpath-functions/math" exclude-result-prefixes="#all"
    xpath-default-namespace="http://www.tei-c.org/ns/1.0"
    xmlns:re="http://www.ilit.bas.bg/repertorium/ns/3.0" version="3.0">
    <xsl:output method="xml" indent="yes"/>
    <xsl:import href="stanka_lib.xsl"/>

    <!-- *-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*_*  -->
    <!-- stylesheet variables                                           -->
    <!-- *-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*_*  -->
    <xsl:variable name="drag" as="document-node()" select="doc('drag_test1-red-fin.xml')"/>
    <xsl:variable name="sin" as="document-node()" select="doc('Sinait-Slav-25.xml')"/>
    <xsl:variable name="skop" as="document-node()" select="doc('skopski-red.xml')"/>
    <xsl:variable name="all-dates" as="xs:string+" select="re:getAllDates(($drag, $sin, $skop))"/>

    <!-- *-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*_*  -->
    <!-- functions                                                      -->
    <!-- *-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*_*  -->
    <xsl:function name="re:processEntry" as="element(xhtml:section)">
        <!-- Top-level msItemStruct -->
        <xsl:param name="entry" as="element(msItemStruct)"/>
        <section class="ms">
            <h3>
                <xsl:value-of select="$entry/title"/>
            </h3>
            <xsl:apply-templates select="$entry/re:sampleText/head"/>
            <ul>
                <xsl:apply-templates select="$entry/msItemStruct"/>
            </ul>
        </section>
    </xsl:function>

    <xsl:template name="xsl:initial-template">
        <html>
            <head>
                <title>Hymnographica</title>
                <link rel="stylesheet" type="text/css" href="http://www.obdurodon.org/css/style.css"/>
                <link rel="stylesheet" type="text/css"
                    href="http://repertorium.obdurodon.org/css/repertorium.css"/>
                <link rel="stylesheet" type="text/css" href="compare.css"/>
            </head>
            <body>
                <h1>Hymnographic comparison</h1>
                <p>Left: <cite>Draganov menaion</cite>; middle: <cite>Skopski</cite>, right
                        <cite>Sinai 25</cite>
                    <br/>
                    <span style="background-color: lightgreen;">Green: agreement of all
                    three</span>; <span style="background-color: yellow;">yellow: agreement of
                        two</span>; <span style="background-color: pink;">red: disagreement</span>;
                    no color: at least one is missing <br/>
                    <xsl:value-of select="current-dateTime()"/></p>
                <xsl:for-each select="$all-dates => re:sort-gMonthDay()">
                    <xsl:variable name="dragEntry" as="element(msItemStruct)?"
                        select="re:getEntry($drag, .)"/>
                    <xsl:variable name="sinEntry" as="element(msItemStruct)?"
                        select="re:getEntry($sin, .)"/>
                    <xsl:variable name="skopEntry" as="element(msItemStruct)?"
                        select="re:getEntry($skop, .)"/>
                    <xsl:variable name="dragTitle" as="xs:string?"
                        select="$dragEntry/title/string()"/>
                    <xsl:variable name="sinTitle" as="xs:string?" select="$sinEntry/title/string()"/>
                    <xsl:variable name="skopTitle" as="xs:string?"
                        select="$skopEntry/title/string()"/>
                    <section>
                        <xsl:variable name="distinct-count" as="xs:integer"
                            select="count(distinct-values(($dragTitle, $sinTitle, $skopTitle)))"/>
                        <xsl:attribute name="class"
                            select="
                                'date ' || (if (count(($dragEntry, $sinEntry, $skopEntry)) lt 3)
                                then
                                    ()
                                else
                                    if
                                    ($distinct-count eq 3)
                                    then
                                        'different'
                                    else
                                        if ($distinct-count eq 2) then
                                            'partial'
                                        else
                                            'same')"/>
                        <h2>
                            <xsl:value-of select="re:month-day-from-gMonthDay(.)"/>
                        </h2>
                        <section class="mss">
                            <!--<xsl:message select="if ($dragEntry) then 'Yes D' else 'No D'"/>
                            <xsl:message select="if ($sinTitle) then 'Yes S' else 'No S'"/>-->
                            <xsl:choose>
                                <xsl:when test="$dragEntry">
                                    <xsl:sequence select="re:processEntry($dragEntry)"/>
                                </xsl:when>
                                <xsl:otherwise>
                                    <section class="ms">
                                        <h3>[missing]</h3>
                                    </section>
                                </xsl:otherwise>
                            </xsl:choose>
                            <hr/>
                            <xsl:choose>
                                <xsl:when test="$skopEntry">
                                    <xsl:sequence select="re:processEntry($skopEntry)"/>
                                </xsl:when>
                                <xsl:otherwise>
                                    <section class="ms">
                                        <h3>[missing]</h3>
                                    </section>
                                </xsl:otherwise>
                            </xsl:choose>
                            <hr/>
                            <xsl:choose>
                                <xsl:when test="$sinEntry">
                                    <xsl:sequence select="re:processEntry($sinEntry)"/>
                                </xsl:when>
                                <xsl:otherwise>
                                    <section class="ms">
                                        <h3>[missing]</h3>
                                    </section>
                                </xsl:otherwise>
                            </xsl:choose>
                        </section>
                    </section>
                </xsl:for-each>
            </body>
        </html>
    </xsl:template>
    <xsl:template match="msContents/msItemStruct">
        <!-- Already output title -->
        <ul>
            <xsl:apply-templates select="msItemStruct"/>
        </ul>
    </xsl:template>
    <xsl:template match="msContents/msItemStruct/msItemStruct">
        <li>
            <span class="title">
                <xsl:apply-templates select="title"/>
            </span>
            <xsl:if test="re:sampleText/incipit">
                <xsl:text> (</xsl:text>
                <xsl:apply-templates select="re:sampleText/incipit"/>
                <xsl:text> )</xsl:text>
            </xsl:if>
            <xsl:if test="msItemStruct">
                <ul>
                    <xsl:apply-templates select="msItemStruct"/>
                </ul>
            </xsl:if>
        </li>
    </xsl:template>
    <xsl:template match="msContents/msItemStruct/msItemStruct/msItemStruct">
        <li>
            <span class="title">
                <xsl:apply-templates select="title"/>
            </span>
            <xsl:if test="re:sampleText/incipit">
                <xsl:text> (</xsl:text>
                <xsl:apply-templates select="re:sampleText/incipit"/>
                <xsl:text> )</xsl:text>
            </xsl:if>
        </li>
    </xsl:template>

    <!-- <sampleText> components: <head>, <incipit> -->
    <xsl:template match="head">
        <h4 class="os">
            <xsl:apply-templates/>
        </h4>
    </xsl:template>
    <xsl:template match="incipit">
        <span class="os">
            <xsl:apply-templates/>
        </span>
    </xsl:template>

    <!-- Inline elements inside <sampleText> -->
    <xsl:template match="seg[@rend = 'sup']">
        <sup>
            <xsl:apply-templates/>
        </sup>
    </xsl:template>
    <xsl:template match="supplied">
        <xsl:text>[</xsl:text>
        <xsl:apply-templates/>
        <xsl:text>]</xsl:text>
    </xsl:template>
    <xsl:template match="unclear">
        <xsl:text>&lt;</xsl:text>
        <xsl:apply-templates/>
        <xsl:text>&gt;</xsl:text>
    </xsl:template>
    <xsl:template match="gap">
        <xsl:text>[</xsl:text>
        <xsl:value-of
            select="
                for $i in 1 to @quantity
                return
                    '.'"/>
        <xsl:text>]</xsl:text>
    </xsl:template>
</xsl:stylesheet>

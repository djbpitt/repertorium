<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns="http://www.w3.org/1999/xhtml" xmlns:xs="http://www.w3.org/2001/XMLSchema"
    xmlns:math="http://www.w3.org/2005/xpath-functions/math" exclude-result-prefixes="#all"
    xpath-default-namespace="http://www.tei-c.org/ns/1.0"
    xmlns:re="http://www.ilit.bas.bg/repertorium/ns/3.0" version="3.0">
    <xsl:output method="xml" indent="yes"/>
    <xsl:import href="stanka_lib.xsl"/>
    <xsl:variable name="drag" as="document-node()" select="doc('drag_test1-red-fin.xml')"/>
    <xsl:variable name="sin" as="document-node()" select="doc('Sinait-Slav-25.xml')"/>
    <xsl:variable name="all-dates" as="xs:string+"
        select="distinct-values(($drag | $sin)//msContents/msItemStruct/date/@when)"/>
    <xsl:function name="re:getTitles">
        <xsl:param name="ms" as="document-node()"/>
        <xsl:param name="qdate" as="xs:string"/>
        <xsl:variable name="results" as="xs:string*"
            select="$ms//msContents/msItemStruct[date/@when eq $qdate]/title/string()"/>
        <xsl:sequence select="($results, '[Missing]')[1]"/>
    </xsl:function>
    <xsl:template name="xsl:initial-template">
        <html>
            <head>
                <title>Hymnographica</title>
                <link rel="stylesheet" type="text/css" href="http://www.obdurodon.org/css/style.css"/>
                <link rel="stylesheet" type="text/css" href="compare.css"/>
            </head>
            <body>
                <h1>Hymnographic comparison</h1>
                <p>Left: <cite>Draganov menaion</cite>; right: <cite>Sinai 25</cite></p>
                <xsl:for-each select="$all-dates => re:sort-gMonthDay()">
                    <xsl:variable name="dragTitle" as="xs:string" select="re:getTitles($drag, .)"/>
                    <xsl:variable name="sinTitle" as="xs:string" select="re:getTitles($sin, .)"/>
                    <section>
                        <xsl:attribute name="class"
                            select="
                                'date ' || (if (($dragTitle, $sinTitle) = '[Missing]')
                                then
                                    ()
                                else
                                    if
                                    ($dragTitle ne $sinTitle)
                                    then
                                        'different'
                                    else
                                        'same')"/>
                        <h2>
                            <xsl:value-of select="re:month-day-from-gMonthDay(.)"/>
                        </h2>
                        <section class="mss">
                            <section class="ms">
                                <xsl:sequence select="$dragTitle"/>
                            </section>
                            <section class="ms">
                                <xsl:sequence select="$sinTitle"/>
                            </section>
                        </section>
                    </section>
                </xsl:for-each>
            </body>
        </html>
    </xsl:template>
</xsl:stylesheet>

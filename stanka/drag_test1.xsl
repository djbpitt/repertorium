<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns="http://www.w3.org/1999/xhtml"
    xmlns:math="http://www.w3.org/2005/xpath-functions/math" exclude-result-prefixes="#all"
    xpath-default-namespace="http://www.tei-c.org/ns/1.0" xmlns:tei="http://www.tei-c.org/ns/1.0"
    xmlns:re="http://www.ilit.bas.bg/repertorium/ns/3.0" version="3.0">
    <xsl:output method="xml" indent="yes" doctype-public="about:legacy-compat"
        omit-xml-declaration="yes"/>
    <xsl:function name="re:titleCase" as="xs:string">
        <xsl:param name="input" as="xs:string"/>
        <xsl:sequence select="concat(upper-case(substring($input, 1, 1)), substring($input, 2))"/>
    </xsl:function>
    <xsl:template match="/">
        <html>
            <head>
                <title><xsl:value-of select="descendant::tei:titleStmt/tei:title"/></title>
                <link rel="stylesheet" type="text/css" href="http://www.obdurodon.org/css/style.css"/>
                <link rel="stylesheet" type="text/css"
                    href="http://suprasliensis.obdurodon.org/css/suprasliensis.css"/>
                <style type="text/css">
                    h1 {
                        font-size: 16pt;
                    }
                    h2 {
                        font-size: 13pt;
                    }
                    h3 {
                        font-size: 12pt;
                    }
                    li {
                        font-size: 11pt;
                    }
                    .os {
                        font-family: Bukyvede;
                    }</style>
            </head>
            <body>
                <h1>
                    <xsl:value-of select="descendant::titleStmt/title"/>
                </h1>
                <xsl:for-each-group select="descendant::msItemStruct[re:sampleText]"
                    group-by="title">
                    <xsl:sort select="current-grouping-key()"/>
                    <xsl:variable name="count" as="xs:integer" select="count(current-group())"/>
                    <section>
                        <h2>
                            <xsl:value-of select="current-grouping-key()"/>
                            <xsl:text> (</xsl:text>
                            <xsl:value-of select="$count"/>
                            <xsl:text> </xsl:text>
                            <xsl:value-of
                                select="
                                    if ($count eq 1) then
                                        'entry'
                                    else
                                        'entries'"/>
                            <xsl:text>)</xsl:text>
                        </h2>
                        <ul>
                            <xsl:for-each select="current-group()">
                                <xsl:apply-templates select="re:sampleText"/>
                            </xsl:for-each>
                        </ul>
                    </section>
                </xsl:for-each-group>
            </body>
        </html>
    </xsl:template>
    <xsl:template match="msItemStruct">
        <li>
            <xsl:apply-templates select="re:sampleText/(head, incipit)"/>
        </li>
    </xsl:template>
    <xsl:template match="head | incipit">
        <strong><xsl:value-of select="re:titleCase(name())"/>: </strong>
        <span class="os">
            <xsl:apply-templates/>
        </span>
        <xsl:text> (Item </xsl:text>Песнопение за връщане
        <xsl:value-of select="substring(ancestor::msItemStruct[1]/@xml:id, 4)"/>
        <xsl:text>, Locus </xsl:text>
        <xsl:value-of select="ancestor::msItemStruct/locus"/>
        <xsl:text>)</xsl:text>
        <br/>
    </xsl:template>
    <xsl:template match="seg[@rend eq 'sup']">
        <sup>
            <xsl:apply-templates/>
        </sup>
    </xsl:template>
    <xsl:template match="sic">
        <xsl:apply-templates/>
        <xsl:text> (sic!)</xsl:text>
    </xsl:template>
    <xsl:template match="corr">
        <xsl:text> (= </xsl:text>
        <xsl:apply-templates/>
        <xsl:text>) </xsl:text>
    </xsl:template>
    <xsl:template match="gap">
        <xsl:text>[</xsl:text>
        <xsl:for-each select="1 to @extent">
            <xsl:text>.</xsl:text>
        </xsl:for-each>
        <xsl:text>]</xsl:text>
    </xsl:template>
    <xsl:template match="supplied">
        <xsl:text>&lt;</xsl:text>
        <xsl:apply-templates/>
        <xsl:text>&gt;</xsl:text>
    </xsl:template>
</xsl:stylesheet>

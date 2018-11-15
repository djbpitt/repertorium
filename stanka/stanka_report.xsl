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
    <xsl:function name="re:recursiveContents">
        <xsl:param name="children"/>
        <xsl:if test="exists($children)">
            <ul>
                <xsl:apply-templates select="$children"/>
            </ul>
        </xsl:if>
    </xsl:function>
    <xsl:template match="/">
        <html>
            <head>
                <title><xsl:value-of select="descendant::tei:titleStmt/tei:title"/></title>
                <meta charset="UTF-8"/>
                <link rel="stylesheet" type="text/css" href="http://www.obdurodon.org/css/style.css"/>
                <style type="text/css">
                    .os {
                        font-family: Bukyvede;
                    }
                    .label {
                        color: gray;
                    }
                    .title {
                        font-size: larger;
                        font-weight: bolder;
                    }</style>
            </head>
            <body>
                <h1>
                    <xsl:value-of select="descendant::titleStmt/title"/>
                </h1>
                <xsl:apply-templates select="descendant::msContents/msItemStruct"/>
            </body>
        </html>
    </xsl:template>
    <xsl:template match="msContents/msItemStruct">
        <h2>
            <xsl:value-of
                select="
                    concat(
                    title,
                    ' (',
                    substring(@xml:id, 4),
                    '; ',
                    date[@type eq 'churchCal'],
                    '; ',
                    locus,
                    ')')"
            />
        </h2>
        <xsl:sequence select="re:recursiveContents(msItemStruct)"/>
    </xsl:template>
    <xsl:template match="msItemStruct/msItemStruct">
        <li>
            <span class="title">
                <xsl:apply-templates select="title"/>
            </span>
            <xsl:value-of
                select="
                    concat(
                    ' (',
                    substring(@xml:id, 4),
                    ')')"/>
            <xsl:apply-templates select="re:sampleText/(head, incipit)"/>
            <xsl:sequence select="re:recursiveContents(msItemStruct)"/>
        </li>
    </xsl:template>

    <xsl:template match="head | incipit">
        <br/>
        <span class="label"><xsl:value-of select="re:titleCase(name())"/>: </span>
        <span class="os">
            <xsl:apply-templates/>
        </span>
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

<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns="http://www.w3.org/1999/xhtml"
    xmlns:math="http://www.w3.org/2005/xpath-functions/math" exclude-result-prefixes="#all"
    xpath-default-namespace="http://www.tei-c.org/ns/1.0" xmlns:tei="http://www.tei-c.org/ns/1.0"
    xmlns:re="http://www.ilit.bas.bg/repertorium/ns/3.0" version="3.0">
    <xsl:output method="xml" indent="yes" doctype-public="about:legacy-compat"
        omit-xml-declaration="yes"/>
    <xsl:template match="/">
        <html>
            <head>
                <title><xsl:value-of select="descendant::tei:titleStmt/tei:title"/></title>
                <link rel="stylesheet" type="text/css" href="http://www.obdurodon.org/css/style.css"/>
                <link rel="stylesheet" type="text/css"
                    href="http://suprasliensis.obdurodon.org/css/suprasliensis.css"/>
                <style type="text/css">
                    .os {
                        font-family: Bukyvede;
                    }</style>
            </head>
            <body>
                <h1>
                    <xsl:value-of select="descendant::titleStmt/title"/>
                </h1>
                <ul>
                    <xsl:apply-templates select="descendant::incipit">
                        <xsl:sort/>
                    </xsl:apply-templates>
                </ul>
            </body>
        </html>
    </xsl:template>
    <xsl:template match="incipit">
        <li>
            <span class="os">
                <xsl:apply-templates/>
            </span>
            <xsl:text> (</xsl:text>
            <xsl:value-of select="ancestor::msItemStruct[1]/@xml:id"/>
            <xsl:if test="ancestor::msItemStruct/locus">
                <xsl:text>, </xsl:text>
                <xsl:apply-templates select="ancestor::msItemStruct/locus"/>
            </xsl:if>
            <xsl:text>)</xsl:text>
        </li>
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

<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    xmlns:math="http://www.w3.org/2005/xpath-functions/math" xmlns="http://www.w3.org/1999/xhtml"
    xpath-default-namespace="http://www.tei-c.org/ns/1.0" exclude-result-prefixes="xs math"
    version="3.0">
    <!--
        Transform the Repertorium guidlines from TEI P5 to XHTML.
    -->
    <xsl:output method="xml" indent="no"/>
    <xsl:template match="/">
        <html>
            <head>
                <title><xsl:value-of select="//titleStmt/title"/></title>
                <!-- General obdurodon styling, with some fine-tuning -->
                <link rel="stylesheet" type="text/css" href="http://www.obdurodon.org/css/style.css"/>
                <link rel="stylesheet" type="text/css" href="guidelines.css"/>
            </head>
            <body>
                <h1>
                    <xsl:value-of select="//titleStmt/title"/>
                </h1>
                <xsl:apply-templates select="//text"/>
            </body>
        </html>
    </xsl:template>
    <xsl:template match="div">
        <div>
            <xsl:apply-templates/>
        </div>
    </xsl:template>
    <xsl:template match="p">
        <!-- 
            Transforming to <div>, rather than <p>, because may contain <ul> and <ol>,
            which HTML permits for <div> but not for <p>
        -->
        <div class="p">
            <xsl:apply-templates/>
        </div>
    </xsl:template>
    <xsl:template match="list">
        <!--
            TEI list may contain a <head>; if so, it has to be moved above the
                <ul> or <ol>
            Header levels are determined by depth of nesting
        -->
        <xsl:if test="head">
            <xsl:element name="{concat('h', count(ancestor::div) + 2)}">
                <xsl:value-of select="head"/>
            </xsl:element>
        </xsl:if>
        <xsl:element name="{if (@type='numbered') then 'ol' else 'ul'}">
            <xsl:apply-templates select="* except head"/>
        </xsl:element>
    </xsl:template>
    <xsl:template match="item">
        <li>
            <xsl:apply-templates/>
        </li>
    </xsl:template>
    <xsl:template match="val">
        <!-- attribute value -->
        <q>
            <xsl:apply-templates/>
        </q>
    </xsl:template>
    <xsl:template match="code">
        <code>
            <xsl:apply-templates/>
        </code>
    </xsl:template>
    <xsl:template match="gi | tag">
        <!-- 
            <gi> is just element name, <tag> may include attribute information
            In both cases, angle brackets need to be added during formatting
        -->
        <code>
            <xsl:text>&lt;</xsl:text>
            <xsl:value-of select="."/>
            <xsl:text>&gt;</xsl:text>
        </code>
    </xsl:template>
    <xsl:template match="att">
        <!-- attribute name -->
        <code>
            <xsl:text>@</xsl:text>
            <xsl:value-of select="."/>
        </code>
    </xsl:template>
    <xsl:template match="head">
        <!-- headerlevel is determined by nesting depth -->
        <xsl:element name="{concat('h', count(ancestor::div) + 1)}">
            <xsl:apply-templates/>
        </xsl:element>
    </xsl:template>
    <xsl:template match="ref">
        <!-- <ref> has content, with URL in @target attribute -->
        <a href="{@target}">
            <xsl:apply-templates/>
        </a>
    </xsl:template>
    <xsl:template match="ptr">
        <!-- 
            <ptr> is empty, with URL in @target attribute
            Copy the URL as both @href and content of <a>
        -->
        <a href="{@target}">
            <xsl:value-of select="@target"/>
        </a>
    </xsl:template>
    <xsl:template match="Q{http://www.tei-c.org/ns/Examples}egXML">
        <!--
            $lines is a sequence of each line of an XML example after flattening
            $minLpad is the smallest left padding for a line, which must be stripped to remove indentation
            TODO: each line except the first winds up with a leading space
                temporarily add extra space before first line to align them
                should instead get rid of spurious spaces from other lines
        -->
        <xsl:variable name="lines" as="xs:string*"
            select="((serialize(node()) ! 
            replace(., '&amp;lt;', '&lt;') ! 
            replace(., '&amp;gt;', '&gt;')) =>
            tokenize('\n+'))[string-length(normalize-space()) gt 0]"/>
        <xsl:variable name="minLpad" as="xs:integer"
            select="
                min(for $line in $lines
                return
                    string-length($line) - string-length(replace($line, '^ +', '')))"/>
        <pre>
            <xsl:text> </xsl:text>
            <xsl:value-of select="
                    for $line in $lines
                    return
                        concat(substring($line, $minLpad + 1), '&#x0a;')"/>
        </pre>
    </xsl:template>
    <xsl:template match="term">
        <dfn>
            <xsl:apply-templates/>
        </dfn>
    </xsl:template>
</xsl:stylesheet>

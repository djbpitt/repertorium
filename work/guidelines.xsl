<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:re="http://www.ilit.bas.bg/repertorium/ns/3.0" xmlns:xs="http://www.w3.org/2001/XMLSchema"
    xmlns:math="http://www.w3.org/2005/xpath-functions/math" xmlns="http://www.w3.org/1999/xhtml"
    xpath-default-namespace="http://www.tei-c.org/ns/1.0" exclude-result-prefixes="#all"
    version="3.0">
    <!--
        Transform the Repertorium guidlines from TEI P5 to XHTML.
    -->
    <xsl:output method="xml" indent="no"/>

    <xsl:function name="re:number" as="xs:string*">
        <xsl:param name="head_param" as="element(head)"/>
        <xsl:variable name="level" as="xs:integer" select="$head_param/count(ancestor::div)"/>
        <xsl:variable name="number" as="xs:integer*">
            <xsl:for-each select="reverse(1 to $level)">
                <xsl:value-of
                    select="$head_param/ancestor::div[current()]/count(preceding-sibling::div) + 1"
                />
            </xsl:for-each>
        </xsl:variable>
        <xsl:variable name="results" as="xs:string*">
            <xsl:choose>
                <xsl:when test="$head_param/ancestor::body">
                    <xsl:value-of select="string-join($number, '.') || '. '"/>
                </xsl:when>
                <xsl:when test="$head_param/parent::div/parent::back">
                    <xsl:text>Appendix</xsl:text>
                    <xsl:number select="$head_param/.." level="multiple" format="A. "/>
                </xsl:when>
            </xsl:choose>
        </xsl:variable>
        <xsl:sequence select="$results"/>
    </xsl:function>

    <!-- *-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*_*  -->
    <!-- Title page -->
    <!-- *-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*_*  -->
    <xsl:template match="titlePage">
        <xsl:apply-templates select="docTitle"/>
        <p>
            <xsl:value-of
                select="'By ' || string-join(docAuthor[position() ne last()], ', ') || ', and ' || docAuthor[last()]"
            />
        </p>
        <xsl:apply-templates select="docImprint, /TEI/teiHeader//availability"/>
        <hr/>
    </xsl:template>
    <xsl:template match="docTitle">
        <h1>
            <xsl:apply-templates/>
        </h1>
    </xsl:template>
    <xsl:template match="docImprint">
        <p>
            <xsl:value-of
                select="../docEdition || '. ' || pubPlace || ': ' || publisher || ', ' || docDate || '.'"
            />
        </p>
    </xsl:template>
    <xsl:template match="availability/p">
        <p class="note">
            <xsl:apply-templates/>
        </p>
    </xsl:template>

    <!-- *-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*_*  -->
    <!-- Main -->
    <!-- *-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*_*  -->
    <xsl:template match="/">
        <html>
            <head>
                <title><xsl:value-of select="//titleStmt/title"/></title>
                <!-- General obdurodon styling, with some fine-tuning -->
                <link rel="stylesheet" type="text/css" href="http://www.obdurodon.org/css/style.css"/>
                <link rel="stylesheet" type="text/css" href="guidelines.css"/>
            </head>
            <body>
                <nav>
                    <ul>
                        <xsl:apply-templates mode="toc" select="//text/front//head"/>
                    </ul>
                    <ul>
                        <xsl:apply-templates mode="toc" select="//text/body//head"/>
                    </ul>
                    <ul>
                        <xsl:apply-templates mode="toc"
                            select="//text/back//head[ancestor::div/head]"/>
                    </ul>
                </nav>
                <main>
                    <xsl:apply-templates select="//text"/>
                </main>
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
    <xsl:template match="head">
        <xsl:variable name="level" as="xs:integer" select="count(ancestor::div)"/>
        <xsl:element name="{concat('h', $level + 1)}">
            <xsl:value-of select="re:number(.)"/>
            <xsl:apply-templates/>
        </xsl:element>
    </xsl:template>

    <!-- *-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*_*  -->
    <!-- highlighting and emphaasis -->
    <!-- *-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*_*  -->
    <xsl:template match="term">
        <dfn>
            <xsl:apply-templates/>
        </dfn>
    </xsl:template>

    <!-- *-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*_*  -->
    <!-- links -->
    <!-- *-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*_*  -->
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

    <!-- *-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*_*  -->
    <!-- code: gi, tag, att, val, code  -->
    <!-- *-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*_*  -->
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

    <!-- *-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*_*  -->
    <!-- code blocks: egXML and eg -->
    <!-- *-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*_*  -->
    <xsl:template match="Q{http://www.tei-c.org/ns/Examples}egXML">
        <!--
            $lines is a sequence of each line of an XML example after flattening
            $minLpad is the smallest left padding for a line, which must be stripped to remove indentation
            TODO: highlight markup in example (e.g., bold for gis and blue for attribute names)
        -->
        <xsl:variable name="lines" as="xs:string*"
            select="
                ((serialize(.)) =>
                replace('&lt;egXML xmlns=&quot;http://www.tei-c.org/ns/Examples&quot;&gt;', '') =>
                replace('&lt;/egXML&gt;', '') =>
                tokenize('\n+'))[string-length(normalize-space()) gt 0]"/>
        <xsl:variable name="minLpad" as="xs:integer"
            select="
                min(for $line in $lines
                return
                    string-length($line) - string-length(replace($line, '^ +', '')))"/>
        <pre>
            <xsl:value-of separator="" select="
                    for $line in $lines
                    return
                        concat(substring(replace($line,'&amp;#xA;','&#x0a;'), $minLpad + 1), '&#x0a;')"/>
        </pre>
        <!--<pre><xsl:sequence select="serialize(., $params)"/></pre>-->
    </xsl:template>
    <xsl:template match="eg">
        <pre><xsl:apply-templates/></pre>
    </xsl:template>

    <!-- *-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*_*  -->
    <!-- bibliography -->
    <!-- *-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*_*  -->
    <xsl:template match="listBibl">
        <ul>
            <xsl:apply-templates/>
        </ul>
    </xsl:template>
    <xsl:template match="listBibl/bibl">
        <li>
            <xsl:apply-templates/>
        </li>
    </xsl:template>

    <!-- *-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*_*  -->
    <!-- tables -->
    <!-- *-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*_*  -->
    <xsl:template match="table">
        <table>
            <xsl:apply-templates/>
        </table>
    </xsl:template>
    <xsl:template match="row">
        <tr>
            <xsl:apply-templates/>
        </tr>
    </xsl:template>
    <xsl:template match="cell">
        <xsl:choose>
            <xsl:when test="parent::row[@role eq 'label']">
                <th>
                    <xsl:apply-templates/>
                </th>
            </xsl:when>
            <xsl:otherwise>
                <td>
                    <xsl:apply-templates/>
                </td>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>

    <!-- *-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*_*  -->
    <!-- TOC mode -->
    <!-- *-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*_*  -->
    <xsl:template match="head" mode="toc">
        <li>
            <xsl:value-of select="."/>
        </li>
    </xsl:template>
</xsl:stylesheet>

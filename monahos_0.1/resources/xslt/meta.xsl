<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns="http://www.w3.org/1999/xhtml" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:tei="http://www.tei-c.org/ns/1.0" xmlns:ns2="http://www.tei-c.org/ns/Examples" exclude-result-prefixes="tei ns2" version="2.0"><!-- <xsl:strip-space elements="*"/>-->
    <xsl:param name="path2source"/>
    <!--
##################################
### Seitenlayout und -struktur ###
##################################
-->
    <xsl:template match="/">
        <div class="container">
            <div class="card">
                <div class="card-header">
                    <div>
                            <h1 style="text-align:center">
                                <xsl:value-of select="//tei:title"/>                                
                            </h1>
                            <h4 style="text-align:center">от<br/>
                <xsl:for-each select="//tei:titleStmt//tei:author">
                    <xsl:apply-templates select="."/>
                    <br/>
                </xsl:for-each>
            </h4>
                    </div>
                </div>
                <div class="card-body">
                    <xsl:apply-templates select="//tei:text"/>
                    
                    <p style="text-align:center;">
                        <xsl:for-each select="tei:TEI/tei:text/tei:body//tei:note">
                            <div class="footnotes">
                                <xsl:element name="a">
                                    <xsl:attribute name="name">
                                        <xsl:text>fn</xsl:text>
                                        <xsl:number level="any" format="1" count="tei:note"/>
                                    </xsl:attribute>
                                    <a>
                                        <xsl:attribute name="href">
                                            <xsl:text>#fna_</xsl:text>
                                            <xsl:number level="any" format="1" count="tei:note"/>
                                        </xsl:attribute>
                                        <span style="font-size:9pt;vertical-align:super;">
                                            <xsl:number level="any" format="1" count="tei:note"/>
                                            <xsl:text>. </xsl:text>
                                        </span>
                                    </a>
                                </xsl:element>
                                <xsl:choose>
                                    <xsl:when test=".//tei:ptr">
                                        <xsl:for-each select=".//tei:ptr">
                                            <xsl:variable name="selctedID">
                                                <xsl:value-of select="substring-after(data(./@target),'#')"/>
                                            </xsl:variable>
                                            <xsl:variable name="selectedBook">
                                                <xsl:value-of select="ancestor::tei:TEI//tei:biblStruct[@xml:id=$selctedID]"/>
                                            </xsl:variable>
                                            <xsl:choose>
                                                <xsl:when test="ancestor::tei:TEI//tei:biblStruct[@xml:id=$selctedID]//tei:persName">
                                                    <xsl:value-of select=" string-join(ancestor::tei:TEI//tei:biblStruct[@xml:id=$selctedID]//tei:surname, '/')"/>,
                                                <xsl:value-of select="ancestor::tei:TEI//tei:biblStruct[@xml:id=$selctedID]//tei:date[1]"/>
                                                    <xsl:apply-templates/>
                                                    <xsl:if test="position() &lt; last()">; </xsl:if>
                                                </xsl:when>
                                                <xsl:otherwise>
                                                    <xsl:value-of select=" string-join(ancestor::tei:TEI//tei:biblStruct[@xml:id=$selctedID]//tei:author, '/')"/>,
                                                    <xsl:value-of select="ancestor::tei:TEI//tei:biblStruct[@xml:id=$selctedID]//tei:date[1]"/>
                                                    <xsl:apply-templates/>
                                                    <xsl:if test="position() &lt; last()">; </xsl:if>
                                                </xsl:otherwise>
                                            </xsl:choose>
                                        </xsl:for-each>
                                    </xsl:when>
                                    <xsl:otherwise>
                                        <xsl:value-of select="."/>
                                    </xsl:otherwise>
                                </xsl:choose>
                            </div>
                        </xsl:for-each>
                    </p>
                    
                </div>
                <div class="card-footer text-muted" style="text-align:center">
                    Станка Петрова-Христова, 
                    <em>
                        <xsl:value-of select="//tei:title[1]"/>
                    </em>
                    <br/>
                    <a>
                        <xsl:attribute name="href">
                            <xsl:value-of select="$path2source"/>
                        </xsl:attribute>
                        Източник в XML
                    </a>
                </div>
            </div>
        </div>
    </xsl:template>
    
    <xsl:template match="tei:date[@*]">
        <abbr>
            <xsl:attribute name="title">
                <xsl:value-of select="data(./@*)"/>
            </xsl:attribute>
            <xsl:apply-templates/>
        </abbr>
    </xsl:template>
    
    <xsl:template match="tei:term">
        <span class="term">
            <xsl:apply-templates/>
        </span>
    </xsl:template>
    
    <xsl:template match="tei:hi">
        <xsl:choose>
            <xsl:when test="@rend='ul'">
                <u>
                    <xsl:apply-templates/>
                </u>
            </xsl:when>
            <xsl:when test="@rend='sup'">
                <sup>
                    <xsl:apply-templates/>
                </sup>
            </xsl:when>
            <xsl:when test="@rend='strike'">
                <strike>
                    <xsl:apply-templates/>
                </strike>
            </xsl:when>
            <xsl:when test="@rend='italic'">
                <em>
                    <xsl:apply-templates/>
                </em>
            </xsl:when>
            
            <xsl:otherwise>
                <span>
                    <xsl:attribute name="style">
                        <xsl:value-of select="@rend"/>
                    </xsl:attribute>
                    <xsl:apply-templates/>
                </span>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>
    
    <!--    footnotes -->   
    <xsl:template match="tei:note">
        <xsl:element name="a">
            <xsl:attribute name="name">
                <xsl:text>fna_</xsl:text>
                <xsl:number level="any" format="1" count="tei:note"/>
            </xsl:attribute>
            <xsl:attribute name="href">
                <xsl:text>#fn</xsl:text>
                <xsl:number level="any" format="1" count="tei:note"/>
            </xsl:attribute>
            <xsl:attribute name="title">
                <xsl:value-of select="normalize-space(.)"/>
            </xsl:attribute>
            <span style="font-size:9pt;vertical-align:super;">
                <xsl:number level="any" format="1" count="tei:note"/>
            </span>
        </xsl:element>
    </xsl:template>

    <xsl:template match="tei:div">
        <xsl:choose>
            <xsl:when test="@xml:id">
                <xsl:element name="div">
                    <xsl:attribute name="id">
                        <xsl:value-of select="@xml:id"/>
                    </xsl:attribute>
                    <xsl:apply-templates/>
                </xsl:element>
            </xsl:when>
            <xsl:otherwise>
                <xsl:apply-templates/>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>
    
    <xsl:template match="tei:ref">
        <xsl:choose>
            <xsl:when test="@target[ends-with(.,'.xml')]">
                <xsl:element name="a">
                    <xsl:attribute name="href">
                       show.html?ref=<xsl:value-of select="tokenize(./@target, '/')[4]"/>
                    </xsl:attribute>
                    <xsl:value-of select="."/>
                </xsl:element>
            </xsl:when>
            <xsl:otherwise>
                <xsl:element name="a">
                    <xsl:attribute name="href">
                        <xsl:value-of select="@target"/>
                    </xsl:attribute>
                    <xsl:value-of select="."/>
                </xsl:element>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>
    
    <xsl:template match="tei:respStmt/tei:resp">
        <xsl:apply-templates/> 
    </xsl:template>
    <xsl:template match="tei:respStmt/tei:name">
        <xsl:for-each select=".">
            <li>
                <xsl:apply-templates/>
            </li>
        </xsl:for-each>
        
    </xsl:template>
    <xsl:template match="tei:title[@ref]">
        <strong>
            <xsl:element name="a">
                <xsl:attribute name="class">reference</xsl:attribute>
                <xsl:attribute name="data-type">listtitle.xml</xsl:attribute>
                <xsl:attribute name="data-key">
                    <xsl:value-of select="substring-after(data(@ref), '#')"/>
                    <xsl:value-of select="@key"/>
                </xsl:attribute>
                <xsl:value-of select="."/>
            </xsl:element>
        </strong>
    </xsl:template>
    
   
    <xsl:template match="tei:author[@ref]">
        <strong>
            <xsl:element name="a">
                <xsl:attribute name="class">reference</xsl:attribute>
                <xsl:attribute name="data-type">listperson.xml</xsl:attribute>
                <xsl:attribute name="data-key">
                    <xsl:value-of select="substring-after(data(@ref), '#')"/>
                    <xsl:value-of select="@key"/>
                </xsl:attribute>
                <xsl:value-of select="."/>
            </xsl:element>
        </strong>
    </xsl:template>
    
    <xsl:template match="tei:rs[@ref or @key]">
        <strong>
            <xsl:element name="a">
                <xsl:attribute name="class">reference</xsl:attribute>
                <xsl:attribute name="data-type">
                    <xsl:value-of select="concat('list', data(@type), '.xml')"/>
                </xsl:attribute>
                <xsl:attribute name="data-key">
                    <xsl:value-of select="substring-after(data(@ref), '#')"/>
                    <xsl:value-of select="@key"/>
                </xsl:attribute>
                <xsl:value-of select="."/>
            </xsl:element>
        </strong>
    </xsl:template>
    
    <xsl:template match="tei:persName[@key]">
        <strong>
            <xsl:element name="a">
                <xsl:attribute name="class">reference</xsl:attribute>
                <xsl:attribute name="data-type">listperson.xml</xsl:attribute>
                <xsl:attribute name="data-key">
                    <xsl:value-of select="@key"/>
                </xsl:attribute>
                <xsl:value-of select="."/>
            </xsl:element>
        </strong>
    </xsl:template>
    
    <xsl:template match="tei:placeName[@key]">
        <strong>
            <xsl:element name="a">
                <xsl:attribute name="class">reference</xsl:attribute>
                <xsl:attribute name="data-type">listplace.xml</xsl:attribute>
                <xsl:attribute name="data-key">
                    <xsl:value-of select="@key"/>
                </xsl:attribute>
                <xsl:value-of select="."/>
            </xsl:element>
        </strong>
    </xsl:template>
    
    <xsl:template match="tei:region[@key] | tei:country[@key]">
        <strong>
            <xsl:element name="a">
                <xsl:attribute name="class">reference</xsl:attribute>
                <xsl:attribute name="data-type">listplace.xml</xsl:attribute>
                <xsl:attribute name="data-key">
                    <xsl:value-of select="@key"/>
                </xsl:attribute>
                <xsl:value-of select="."/>
            </xsl:element>
        </strong>
    </xsl:template>
    
    <xsl:template match="tei:add">
        <xsl:element name="span">
            <xsl:attribute name="style">
                <xsl:text>color:blue;</xsl:text>
            </xsl:attribute>
            <xsl:attribute name="title">
                <xsl:choose>
                    <xsl:when test="@place='margin'">
                        <xsl:text>addition in margins</xsl:text>(<xsl:value-of select="./@place"/>).
                    </xsl:when>
                    <xsl:when test="@place='above'">
                        <xsl:text>addition above the line</xsl:text>(<xsl:value-of select="./@place"/>)
                    </xsl:when>
                    <xsl:when test="@place='below'">
                        <xsl:text>addition below the line</xsl:text>(<xsl:value-of select="./@place"/>)
                    </xsl:when>
                    <xsl:when test="@place='inline'">
                        <xsl:text>addtion inline</xsl:text>(<xsl:value-of select="./@place"/>)
                    </xsl:when>
                    <xsl:when test="@place='top'">
                        <xsl:text>addition in top margin</xsl:text>(<xsl:value-of select="./@place"/>)
                    </xsl:when>
                    <xsl:when test="@place='bottom'">
                        <xsl:text>addition in bottom margin</xsl:text>(<xsl:value-of select="./@place"/>)
                    </xsl:when>
                    <xsl:otherwise>
                        <xsl:text>addition</xsl:text>(<xsl:value-of select="./@place"/>)
                    </xsl:otherwise>
                </xsl:choose>
            </xsl:attribute>
            <xsl:text/>
            <xsl:apply-templates/>
        </xsl:element>
    </xsl:template>
    <xsl:template match="tei:bibl">
        <xsl:element name="strong">
            <xsl:apply-templates/>
        </xsl:element>
    </xsl:template>
    
    <xsl:template match="tei:pb">
        <xsl:element name="div">
            <xsl:attribute name="style">
                <xsl:text>text-align:right;</xsl:text>
            </xsl:attribute>
            <xsl:text>[f.</xsl:text>
            <xsl:value-of select="@n"/>
            <xsl:text>]</xsl:text>
        </xsl:element>
        <xsl:element name="hr"/>
    </xsl:template>
    
    <xsl:template match="tei:table">
        <xsl:element name="table">
            <xsl:attribute name="class">
                <xsl:text>table table-bordered table-striped table-condensed table-hover</xsl:text>
            </xsl:attribute>
            <xsl:element name="tbody">
                <xsl:apply-templates/>
            </xsl:element>
        </xsl:element>
    </xsl:template>
    
    <xsl:template match="tei:row">
        <xsl:element name="tr">
            <xsl:apply-templates/>
        </xsl:element>
    </xsl:template>
    <xsl:template match="tei:cell">
        <xsl:element name="td">
            <xsl:apply-templates/>
        </xsl:element>
    </xsl:template>
    
    <xsl:template match="tei:head">
        <a>
            <xsl:attribute name="name">
                <xsl:text>hd</xsl:text>
                <xsl:number level="any"/>
            </xsl:attribute>
            <xsl:text> </xsl:text>
        </a>
        <h3>
            <div>
                <xsl:apply-templates/>
            </div>
        </h3>
    </xsl:template>
    <xsl:template match="tei:q">
        <xsl:element name="i">
            <xsl:apply-templates/>
        </xsl:element>
    </xsl:template>
    <xsl:template match="tei:lb">
        <br/>
    </xsl:template>
    <xsl:template match="tei:p">
        <xsl:element name="p">
            <xsl:apply-templates/>
        </xsl:element>
    </xsl:template>
    
    <xsl:template match="tei:del">
        <xsl:element name="strike">
            <xsl:apply-templates/>
        </xsl:element>
    </xsl:template>
    
    <xsl:template match="tei:origDate[@notBefore and @notAfter]">
        <xsl:variable name="dates">
            <xsl:value-of select="./@*" separator="-"/>
        </xsl:variable>
        <abbr title="{$dates}">
            <xsl:value-of select="."/>
        </abbr>
    </xsl:template>
    
    
    <xsl:template match="tei:title">
        <strong>
            <xsl:apply-templates/>
        </strong>
    </xsl:template>
    
    <xsl:template match="tei:listBibl">
        <xsl:for-each select=".//tei:bibl">
            <li>
                <xsl:apply-templates/>
            </li>
        </xsl:for-each>
    </xsl:template>
    
    <xsl:template match="tei:ptr">
        <xsl:variable name="x">
            <xsl:value-of select="./@target"/>
        </xsl:variable>
        <a href="{$x}" class="fas fa-link"/>
    </xsl:template>
    
     <xsl:template match="tei:code">
        <code>
            <xsl:apply-templates/>
        </code>
    </xsl:template>
    
    <xsl:template match="ns2:egXML">
<pre>
        <code>
            <xsl:apply-templates/>
        </code>
     </pre>       

    </xsl:template>
    
    <xsl:template match="tei:gi">
        <code>
            <xsl:apply-templates/>
        </code>
    </xsl:template>
    
    <xsl:template match="tei:ref[starts-with(./@target, '#meta__')]">
        <xsl:variable name="point-to">
            <xsl:value-of select="substring-after(./@target, '#')"/>
        </xsl:variable>
        <xsl:variable name="link">
            <xsl:value-of select="concat('./show.html?document=', $point-to, '&amp;directory=texts')"/>
        </xsl:variable>
        <a>
            <xsl:attribute name="href">
                <xsl:value-of select="$link"/>
            </xsl:attribute>
            <xsl:apply-templates/>
        </a>
    </xsl:template>
    
    <xsl:template match="tei:ref">
        <xsl:choose>
            <xsl:when test="@target[ends-with(.,'.xml')]">
                <xsl:element name="a">
                    <xsl:attribute name="href">
                       show.html?ref=<xsl:value-of select="tokenize(./@target, '/')[4]"/>
                    </xsl:attribute>
                    <xsl:value-of select="."/>
                </xsl:element>
            </xsl:when>
            
            <xsl:otherwise>
                <xsl:element name="a">
                    <xsl:attribute name="href">
                        <xsl:value-of select="@target"/>
                    </xsl:attribute>
                    <xsl:value-of select="."/>
                </xsl:element>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>
    
    <xsl:template match="tei:list">
        <ul>
            <xsl:apply-templates/>
        </ul>
    </xsl:template>
    
    <xsl:template match="tei:list/tei:item">
        <li>
            <xsl:apply-templates/>
        </li>
    </xsl:template>
 

    
    
</xsl:stylesheet>
<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns="http://www.w3.org/1999/xhtml" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:re="http://www.ilit.bas.bg/repertorium/ns/3.0" xmlns:tei="http://www.tei-c.org/ns/1.0" exclude-result-prefixes="tei re" version="3.0">
     
    <xsl:template match="/">
    
        <div class="container-fluid">
               
                    <h2 align="center">
                        <xsl:apply-templates select="//tei:titleStmt/tei:title"/>
                    </h2>

                
                    <div class="card border-secondary mb-3">
                        <div class="card-header">
                                <h2 align="center">Manuscript Description</h2>
                        </div>
                        <div class="card-body">
                            <table class="table table-striped table-sm table-responsive">
                                <tbody>
                                    <tr>
                                        <th> Title </th>
                                        <td>
                                            <xsl:apply-templates select="//tei:fileDesc/tei:titleStmt/tei:title/text()"/>
                                        </td>
                                    </tr>
                                    <tr>
                                    <th>Generic name</th>
                                    <td>
                                    <xsl:value-of select="//tei:msIdentifier/tei:msName[@type='general']"/>
                                    </td>
                                    </tr>
                                    <tr>
                                    <th>Individual name</th>
                                    <td>
                                    <xsl:for-each select="//tei:msIdentifier/tei:msName[@type='individual']">
                                                <xsl:element name="abbr">
                                                    <xsl:attribute name="title">
                                                        <xsl:value-of select="name(.)"/>
                                                    </xsl:attribute>
                                                    <xsl:value-of select="."/>
                                                    <xsl:text> | </xsl:text>
                                                </xsl:element>
                                            </xsl:for-each>
                                    
                                    </td>
                                    </tr>
                                    <tr>
                                    <th>Country</th>
                                    <td>
                                    <xsl:value-of select="//tei:msIdentifier//tei:country"/>
                                    </td>
                                    </tr>
                                    <tr>
                                    <th>Repository</th>
                                    <td>
                                    <xsl:value-of select="//tei:msIdentifier//tei:repository"/>
                                    </td>
                                    </tr>
                                    <tr>
                                    <th>Shelfmark</th>
                                    <td>
                                    <mark>
                                        <xsl:value-of select="//tei:msIdentifier/tei:idno[@type='shelfmark']"/>
                                    </mark>
                                    </td>
                                    </tr>
                                    <tr>
                                     <th>Former identifiers</th>
                                    <td>
                                    <xsl:if test="//tei:altIdentifier[@type='former']/tei:idno[@type='catalogue']">
                                    <mark>Catalogue: </mark>
                                    <xsl:value-of select="//tei:altIdentifier[@type='former']/tei:idno[@type='catalogue']"/>
                                    </xsl:if>
                                    </td>
                                    </tr>
                                    <tr>
                                        <th>Material</th>
                                        <td>
                                            <xsl:apply-templates select="//tei:support/tei:material"/>
                                        </td>
                                    </tr>
                                     <tr>
                                        <th>Extent</th>
                                        <td>
                                        <p>
                                        <mark>Folia:</mark>
                                        <xsl:apply-templates select="//tei:measure[@unit='folia']"/>
                                    </p>
                                        <p>
                                        <mark>Dimensions: </mark>
                                        <xsl:apply-templates select="//tei:dimensions"/>
                                    </p>
                                         
                                        </td>
                                    </tr>
                                    <tr>
                                        <th>Layout</th>
                                        <td>
                                            <xsl:apply-templates select="//tei:layoutDesc/tei:layout"/>
                                        </td>
                                    </tr>
                                    <tr>
                                        <th>Ink</th>
                                        <td>
                                            <xsl:apply-templates select="//re:ink"/>
                                        </td>
                                    </tr>
                                    <tr>
                                        <th>Decoration</th>
                                        <td>
                                            <xsl:apply-templates select="//tei:decoDesc"/>
                                        </td>
                                    </tr>
                                      <tr>
                                        <th>Binding</th>
                                        <td>
                                            <xsl:apply-templates select="//tei:binding"/>
                                        </td>
                                    </tr>
                                    <tr>
                                        <th>Condition</th>
                                        <td>
                                            <xsl:apply-templates select="//tei:supportDesc/tei:condition"/>
                                        </td>
                                    </tr>
                                     <tr>
                                        <th>Scribe</th>
                                        <td>
                                        <p>
                                        <mark>Folia: </mark>
                                        <xsl:apply-templates select="//re:scribe/tei:locus"/>
                                    </p>
                                        <p>
                                        <mark>Name: </mark>
                                            <xsl:apply-templates select="//re:scribe/tei:name"/>
                                    </p>
                                        </td>
                                    </tr>
                                    <tr>
                                        <th>Content</th>
                                        <td>
                                            <xsl:apply-templates select="//tei:msContents"/>
                                        </td>
                                    </tr>
                                   
                                     <tr>
                                        <th>Author of description</th>
                                        <td>
                                            <xsl:apply-templates select="//tei:titleStmt//tei:author"/>
                                        </td>
                                    </tr>
                                    <tr>
                                        <th>Editor of description</th>
                                        <td>
                                            <xsl:apply-templates select="//tei:titleStmt//tei:editor"/>
                                        </td>
                                    </tr>
                                    <tr>
                                        <th>Other responsibility</th>
                                        <td>
                                            <xsl:apply-templates select="//tei:titleStmt/tei:respStmt"/>
                                        </td>
                                    </tr>
                                    <tr>
                                        <th>Licence</th>
                                        <td>
                                            <xsl:element name="a">
                                                <xsl:attribute name="href">
                                                    <xsl:apply-templates select="//tei:licence/@target"/>
                                                </xsl:attribute>
                                                <xsl:apply-templates select="//tei:availability//tei:p[1]"/>
                                            </xsl:element>
                                        </td>
                                    </tr>
                                </tbody>
                            </table>
                             <div class="card-footer">
                                <p style="text-align:center">
                                    <a id="link_to_source" class="text-muted"/>
                                </p>
                            </div>
                        </div>
            
            </div>
            <script type="text/javascript">
                // creates a link to the xml version of the current docuemnt available via eXist-db's REST-API
                var params={};
                window.location.search
                .replace(/[?&amp;]+([^=&amp;;]+)=([^&amp;;]*)/gi, function(str,key,value) {
                params[key] = value;
                }
                );
                var collection;
                //alert(params['directory'])
                if (params['directory'] === "undefined"  || params['directory'] === "") {
                collection = 'editions';
                } else {
                collection = params['directory']
                }
                var path = window.location.origin+window.location.pathname;
                var replaced = path.replace("exist/apps/", "exist/rest/db/apps/");
                current_html = window.location.pathname.substring(window.location.pathname.lastIndexOf("/") + 1)
                var source_dokument = replaced.replace("pages/"+current_html, "data/"+collection+"/"+params['document']);
                // console.log(source_dokument)
                $( "#link_to_source" ).attr('href',source_dokument);
                $( "#link_to_source" ).text(source_dokument);
            </script>
        </div>
    </xsl:template>
    
     <xsl:template match="tei:div">
        <xsl:element name="div">
            <xsl:attribute name="class">body-div</xsl:attribute>
            <xsl:attribute name="id">
                <xsl:value-of select="@xml:id"/>
            </xsl:attribute>
            <xsl:apply-templates/>
        </xsl:element>
    </xsl:template>
    
     <xsl:template match="tei:head">
        <xsl:element name="h2">
            <xsl:element name="a">
                <xsl:attribute name="href">
                    <xsl:text>#nav_</xsl:text>
                    <xsl:value-of select="parent::tei:div/@xml:id"/>
                </xsl:attribute>
                <xsl:attribute name="id">
                    <xsl:text>text_</xsl:text>
                    <xsl:value-of select="parent::tei:div/@xml:id"/>
                </xsl:attribute>
                <xsl:apply-templates/>
            </xsl:element>
        </xsl:element>
    </xsl:template>
    
     
    <xsl:template match="tei:p">
        <xsl:element name="p">
            <xsl:apply-templates/>
        </xsl:element>
    </xsl:template>
    
 <!-- Phrase level elements -->
 <xsl:template match="tei:corr">
        <xsl:text> (= </xsl:text>
        <xsl:apply-templates/>
        <xsl:text>) </xsl:text>
    </xsl:template>
    
     <xsl:template match="tei:gap">
        <xsl:text>[</xsl:text>
        <xsl:for-each select="1 to @extent">
            <xsl:text>.</xsl:text>
        </xsl:for-each>
        <xsl:text>]</xsl:text>
    </xsl:template>
    
     <xsl:template match="//re:sampleText">
     <div class="sample">
         <xsl:apply-templates/>
        </div>
    </xsl:template>
    
     <xsl:template match="//re:sampleText//tei:head">
     <mark>Heading: </mark>
        <span lang="cu">
         <xsl:apply-templates/>
        </span>
    </xsl:template>
    
    <xsl:template match="tei:incipit">
        <li>
        <mark>Incipit: </mark>
            <span lang="cu">
                <xsl:apply-templates/>
            </span>
            <xsl:text> (</xsl:text>
            <xsl:value-of select="ancestor::tei:msItemStruct[1]/@xml:id"/>
            <xsl:if test="ancestor::tei:msItemStruct/tei:locus">
                <xsl:text>, </xsl:text>
                <xsl:apply-templates select="ancestor::tei:msItemStruct/tei:locus"/>
            </xsl:if>
            <xsl:text>)</xsl:text>
        </li>
    </xsl:template>
    
    <xsl:template match="tei:seg[@rend eq 'sup']">
        <sup>
            <xsl:apply-templates/>
        </sup>
    </xsl:template>
    
     <xsl:template match="tei:sic">
        <xsl:apply-templates/>
        <xsl:text> (sic!)</xsl:text>
    </xsl:template>
    
    <xsl:template match="tei:supplied">
        <xsl:text>&lt;</xsl:text>
        <xsl:apply-templates/>
        <xsl:text>&gt;</xsl:text>
    </xsl:template>
    
    <xsl:template match="tei:subst">
        <xsl:element name="span">
            <xsl:attribute name="class">tei-subst</xsl:attribute>
            <xsl:apply-templates/>
        </xsl:element>
    </xsl:template>
    <xsl:template match="tei:del">
        <del>
            <xsl:apply-templates/>
        </del>
    </xsl:template>
    
    <xsl:template match="tei:sub">
        <sub>
            <xsl:apply-templates/>
        </sub>
    </xsl:template>

    <xsl:template match="tei:pb">
        <div class="pb">f. <xsl:value-of select="./@n"/>
        </div>
    </xsl:template>
    
    <xsl:template match="tei:msItemStruct">
        <xsl:for-each select=".">
            <p>
                <ul>
                    <xsl:for-each select="./*">
                        <li>
                            <strong>
                                <xsl:value-of select="name(.)"/>
                            </strong>: <xsl:apply-templates select="."/>
                        </li>
                    </xsl:for-each>
                </ul>
            </p>
        </xsl:for-each>
    </xsl:template>
    
     <xsl:template match="tei:dimensions">
        <xsl:choose>
            <xsl:when test="following-sibling::tei:dimensions">
                <span>
                    <xsl:apply-templates/>
                    <xsl:if test="@unit">
                        <xsl:text/>
                        <xsl:value-of select="@unit"/>
                    </xsl:if>
                    <xsl:if test="@type">
                        (<xsl:value-of select="@type"/>)
                    </xsl:if>
                    <xsl:text>, </xsl:text>
                </span>
            </xsl:when>
            <xsl:otherwise>
                <span>
                    <xsl:apply-templates/>
                    <xsl:if test="@unit">
                        <xsl:value-of select="@unit"/>
                    </xsl:if>
                    <xsl:if test="@type">
                        (<xsl:value-of select="@type"/>)
                    </xsl:if>
                </span>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>
    <xsl:template match="tei:height">
        <xsl:apply-templates/>
        <xsl:text> x</xsl:text>
    </xsl:template>
    <xsl:template match="tei:measure">
        <xsl:if test="@unit='folio'">
            <span>
                <xsl:apply-templates/>
                <xsl:text> f. </xsl:text>
            </span>
        </xsl:if>
        <xsl:if test="@unit='folia'">
            <span>
                <xsl:apply-templates/>
                <xsl:text> ff. </xsl:text>
            </span>
        </xsl:if>
    </xsl:template>
    
    <!--  Links to indices   --><!--
    #####################
    ###  entity-index-linking ###
    #####################
-->
    <xsl:template match="node()[@ref]">
        <strong style="color:green" class="linkedEntity">
            <xsl:attribute name="data-key">
                <xsl:value-of select="current()/@ref"/>
            </xsl:attribute>
            <xsl:apply-templates/>
        </strong>
    </xsl:template>
    
    <xsl:template match="tei:cb"/>
    <xsl:template match="tei:lb" mode="col">
        <xsl:choose>
            <xsl:when test="@break">
                <xsl:text>|</xsl:text>
            </xsl:when>
            <xsl:otherwise>
                <xsl:text> | </xsl:text>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>
    <xsl:template match="tei:locus">
    <span class="locus">
    <xsl:apply-templates/>
    </span>
    </xsl:template>
    
    
  
</xsl:stylesheet>
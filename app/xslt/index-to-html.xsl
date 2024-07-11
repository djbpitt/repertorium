<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns:xs="http://www.w3.org/2001/XMLSchema"
  xmlns:math="http://www.w3.org/2005/xpath-functions/math"
  xpath-default-namespace="http://repertorium.obdurodon.org/model"
  xmlns="http://www.w3.org/1999/xhtml" 
  exclude-result-prefixes="#all" version="3.0">
  <xsl:template match="main">
    <main id="index">
      <h2>
        <xsl:value-of select="header/title"/>
        <img class="folio" title="Codex Zographensis" alt="[Codex Zographensis]"
          src="{header/image/@url}"/>
      </h2>
      <xsl:apply-templates select="body/node()"/>
    </main>
  </xsl:template>
  <xsl:template match="section">
    <section>
      <xsl:if test="preceding-sibling::section">
        <hr/>
      </xsl:if>
      <xsl:apply-templates/>
    </section>
  </xsl:template>
  <xsl:template match="title">
    <!-- ================================================================ -->
    <!-- Section title                                                    -->
    <!-- Assumes no more than five levels of sections                     -->
    <!--   (hero is h1, index doesn’t have a page title, so               -->
    <!--   the subsections are next)                                      -->
    <!-- ================================================================ -->
    <xsl:element name="{concat('h', count(ancestor::section) + 1)}">
      <xsl:apply-templates/>
    </xsl:element>
  </xsl:template>
  <xsl:template match="svg">
    <!-- ================================================================ -->
    <!-- Links to SVG documents move up and over into images directory    -->
    <!-- XML declaration is ignored automatically (not part of sequence)  -->
    <!-- ================================================================ -->
    <xsl:sequence select="doc(concat('../', string(@src)))/*"/>
  </xsl:template>
  <xsl:template match="a">
    <a href="{@url}">
      <xsl:apply-templates/>
    </a>
  </xsl:template>
  <xsl:template match="ul">
    <xsl:element name="{local-name()}">
      <xsl:copy-of select="@class"/>
      <xsl:apply-templates/>
    </xsl:element>
  </xsl:template>
  <xsl:template match="*">
    <xsl:element name="{local-name()}">
      <xsl:apply-templates/>
    </xsl:element>
  </xsl:template>
  <xsl:template match="@*">
    <xsl:copy-of select="."/>
  </xsl:template>
  <xsl:template match="svg">
    <xsl:copy-of select="doc('../' || @src)"/>
  </xsl:template>
</xsl:stylesheet>

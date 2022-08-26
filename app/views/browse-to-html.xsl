<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns:xs="http://www.w3.org/2001/XMLSchema"
  xmlns:math="http://www.w3.org/2005/xpath-functions/math"
  xmlns:re="http://www.ilit.bas.bg/repertorium/ns/3.0"
  xpath-default-namespace="http://www.obdurodon.org/model" xmlns="http://www.w3.org/1999/xhtml"
  exclude-result-prefixes="#all" version="3.0">
  <!-- ================================================================== -->
  <!-- Import function library                                            -->
  <!-- ================================================================== -->
  <xsl:import href="functions.xsl"/>
  <!-- ================================================================== -->
  <!-- Main                                                               -->
  <!-- ================================================================== -->
  <xsl:template match="/">
    <!-- ================================================================ -->
    <!-- All descriptions have country, settlement, repository except     -->
    <!--   convolutes                                                     -->
    <!-- ================================================================ -->
    <section>
      <h2>Browse the collection</h2>
      <ul id="browse-list">
        <xsl:apply-templates>
          <xsl:sort/>
        </xsl:apply-templates>
      </ul>
    </section>
  </xsl:template>
  <xsl:template match="ms">
    <li>
      <xsl:choose>
        <xsl:when test="country[node()]">
          <a href="search">
            <xsl:value-of select="country"/>
          </a>
          <xsl:text>, </xsl:text>
          <a href="search">
            <xsl:value-of select="settlement"/>
          </a>
          <xsl:text>, </xsl:text>
          <a href="search">
            <xsl:value-of select="repository"/>
          </a>
          <xsl:text>, </xsl:text>
          <xsl:value-of select="idno"/>
        </xsl:when>
        <xsl:otherwise>[Multiple repositories] </xsl:otherwise>
      </xsl:choose>
      <xsl:text> (</xsl:text>
      <xsl:value-of select="orig-date"/>
      <xsl:text>) [</xsl:text>
      <xsl:value-of select="id"/>
      <xsl:text>]</xsl:text>
      <br/>
      <span lang="bg">
        <xsl:value-of select="re:title-case(title[@xml:lang eq 'bg'])"/>
      </span>
      <span lang="en">
        <xsl:value-of select="re:title-case(title[@xml:lang eq 'en'])"/>
      </span>
      <span lang="ru">
        <xsl:value-of select="re:title-case(title[@xml:lang eq 'ru'])"/>
      </span>
      <a href="" class="lozenge">
        <img src="resources/images/codicology.svg"/>
      </a>
      <a href="" class="lozenge">
        <img src="resources/images/texts.svg"/>
      </a>
      <a href="" class="lozenge">
        <img src="resources/images/xml.svg"/>
      </a>
    </li>
  </xsl:template>
</xsl:stylesheet>

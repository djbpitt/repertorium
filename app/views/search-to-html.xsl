<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns:xs="http://www.w3.org/2001/XMLSchema"
  xmlns:math="http://www.w3.org/2005/xpath-functions/math"
  xmlns:re="http://www.ilit.bas.bg/repertorium/ns/3.0" xmlns:m="http://www.obdurodon.org/model"
  xpath-default-namespace="http://www.obdurodon.org/model" xmlns="http://www.w3.org/1999/xhtml"
  exclude-result-prefixes="#all" version="3.0">
  <!-- ================================================================== -->
  <!-- Import function library                                            -->
  <!-- ================================================================== -->
  <xsl:import href="functions.xsl"/>
  <!-- ================================================================== -->
  <!-- Variables                                                          -->
  <!-- ================================================================== -->
  <xsl:variable name="facet-labels" as="map(*)" select="
      map {
        'countries': 'country',
        'settlements': 'settlement',
        'repositories': 'repository'
      }"/>
  <!-- ================================================================== -->
  <!-- Main                                                               -->
  <!-- ================================================================== -->
  <xsl:template match="/">
    <section>
      <script src="resources/js/search.js"/>
      <xsl:apply-templates/>
    </section>
  </xsl:template>
  <xsl:template match="results">
    <!-- ================================================================ -->
    <!-- All descriptions have country, settlement, repository except     -->
    <!--   convolutes                                                     -->
    <!-- ================================================================ -->
    <form action="search" method="get" id="search">
      <div id="text-query-and-submit">
        <input type="text" id="article-title" name="article-title"/>
        <input type="submit" id="submit" name="submit"/>
      </div>
      <div id="checkboxes-and-mss">
        <aside id="fieldsets">
          <xsl:apply-templates select="countries, settlements, repositories"/>
        </aside>
        <xsl:apply-templates select="mss"/>
      </div>
    </form>
  </xsl:template>
  <!-- ================================================================== -->
  <!-- Query facets                                                       -->
  <!-- ================================================================== -->
  <xsl:template match="countries | settlements | repositories">
    <fieldset>
      <legend>
        <xsl:value-of select="re:title-case(re:title-case(local-name()))"/>
      </legend>
      <ul>
        <xsl:apply-templates/>
      </ul>
    </fieldset>
  </xsl:template>
  <xsl:template match="item">
    <li>
      <label>
        <input type="checkbox" name="{$facet-labels(.. ! local-name())}" value="{@key}">
          <xsl:if test="@checked">
            <xsl:attribute name="checked" select="'checked'"/>
          </xsl:if>
        </input>
        <xsl:text> </xsl:text>
        <xsl:value-of select="concat(@key, ' (', ., ')')"/>
      </label>
    </li>
  </xsl:template>

  <!-- ================================================================== -->
  <!-- Results list                                                       -->
  <!-- ================================================================== -->
  <xsl:template match="mss">
    <section id="mss">
      <h2>
        <xsl:text>Manuscript descriptions (</xsl:text>
        <xsl:value-of select="count(*)"/>
        <xsl:text>)</xsl:text>
      </h2>
      <ul>
        <xsl:apply-templates/>
      </ul>
    </section>
  </xsl:template>
  <xsl:template match="ms">
    <li>
      <label>
        <input type="checkbox" name="mss[]" value="{id}"/>
        <xsl:text> </xsl:text>
      </label>
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

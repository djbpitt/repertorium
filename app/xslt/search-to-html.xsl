<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns:xs="http://www.w3.org/2001/XMLSchema"
  xmlns:math="http://www.w3.org/2005/xpath-functions/math"
  xpath-default-namespace="http://repertorium.obdurodon.org/model"
  xmlns="http://www.w3.org/1999/xhtml" exclude-result-prefixes="#all" version="3.0">
  <xsl:variable name="lg" select="/main/lg"/>
  <xsl:template match="main">
    <main id="search">
        <xsl:apply-templates select="h2"/>
        <section id="contents">
            <section id="searchControls">
                <form action="search" method="get">
                    <fieldset>
                        <legend>Filter by</legend>
                        <div>
                            <label for="country">
                                <xsl:value-of select="'Country&#xa0;'"/>
                            </label>
                            <select name="country" id="country">
                                <option value="">[All]</option>
                                <xsl:apply-templates select="facets/country-facets/country"/>
                            </select>
                            <label for="settlement">
                                <xsl:value-of select="'Settlement&#xa0;'"/>
                            </label>
                            <select name="settlement" id="settlement">
                                <option value="">[All]</option>
                                <xsl:apply-templates select="facets/settlement-facets/settlement"/>
                            </select>
                            <label for="repository">
                                <xsl:value-of select="'Repository&#xa0;'"/>
                            </label>
                            <select name="repository" id="repository">
                                <option value="">[All]</option>
                                <xsl:apply-templates select="facets/repository-facets/repository"/>
                            </select>
                            <hr/>
                            <label for="titleWords">
                                <xsl:value-of select="'Title words&#xa0;'"/>
                            </label>
                            <input type="text" size="40" id="titleWords" name="titleWords"/>
                            <label for="authorWords">
                                <xsl:value-of select="'Author words&#xa0;'"/>
                            </label>
                            <input type="text" size="38" id="authorWords" name="authorWords"/>
                            <hr/>
                        </div>
                        <div>
                          <input id="submit" type="submit" value="Submit"/>
                          <button id="clear-form" type="reset">Clear</button>
                        </div>
                    </fieldset>
                </form>
            </section>
            <section id="mss">
                <h3>
                    <xsl:text>Results (</xsl:text>
                    <xsl:value-of select="count(/main/ul/li)"/>
                    <xsl:text>)</xsl:text>
                </h3>
                <xsl:apply-templates select="ul"/>
            </section>
        </section>
    </main>
  </xsl:template>
  <!-- ================================================================== -->
  <!-- Widgets                                                            -->
  <!-- ================================================================== -->
  <xsl:template match="facets/*/*">
    <option value="{label}">
      <xsl:if test="/descendant::input[@k eq current()/local-name() and . eq current()/label]">
        <xsl:attribute name="selected" select="'yes'"/>
      </xsl:if>
      <xsl:value-of select="concat(label, ' (', count, ')')"/>
    </option>
  </xsl:template>
  <!-- ================================================================== -->
  <!-- Manuscripts list                                                   -->
  <!-- ================================================================== -->
  <xsl:template match="li">
    <li>
      <input type="checkbox" name="mss[]" value="{uri}"/>
      <xsl:text> </xsl:text>
      <xsl:apply-templates select="country, settlement, repository, idno, origDate, uri, availability"/>
      <br/>
      <xsl:apply-templates select="bg, en, ru"/>
      <a href="msDesc?filename={uri}.xml"><xsl:sequence select="doc('../resources/images/codicology.svg')"/></a>
      <a href="readFile?filename={uri}.xml"><xsl:sequence select="doc('../resources/images/texts.svg')"/></a>
      <a href="mss/{uri}.xml"><xsl:sequence select="doc('../resources/images/xml.svg')"/></a>
    </li>
  </xsl:template>
  <xsl:template match="country">
    <xsl:choose>
        <xsl:when test="exists(./node())">
            <a href="search?country={encode-for-uri(.)}"><xsl:apply-templates/></a>
            <xsl:text>, </xsl:text> 
        </xsl:when>
        <xsl:otherwise>
            <xsl:text>[Multiple locations]</xsl:text>
        </xsl:otherwise>
    </xsl:choose>
  </xsl:template>
  <xsl:template match="settlement | repository">
      <a href="search?{local-name()}={encode-for-uri(.)}"><xsl:apply-templates/></a>
      <xsl:text>, </xsl:text>
  </xsl:template>
  <xsl:template match="idno">
    <xsl:text> </xsl:text>
    <xsl:apply-templates/>
    <xsl:text> </xsl:text>
  </xsl:template>
  <xsl:template match="origDate">
    <xsl:text> (</xsl:text>
    <xsl:apply-templates/>
    <xsl:text>) </xsl:text>
  </xsl:template>
  <xsl:template match="uri">
    <xsl:text> [</xsl:text>
      <xsl:apply-templates/>
    <xsl:text>] </xsl:text>
  </xsl:template>
  <xsl:template match="availability">
    <xsl:text> (</xsl:text>
    <xsl:apply-templates/>
    <xsl:text>)</xsl:text>
  </xsl:template>
  <xsl:template match="bg | en | ru">
    <xsl:variable name="id" as="xs:string" select="substring(name(), 1, 2)"/>
    <xsl:variable name="status" as="xs:string?" select="'hide'[$id ne $lg]"/>
    <span class="{string-join(($id, $status), ' ')}"><xsl:apply-templates/></span>
  <!-- ================================================================== -->
  <!-- General                                                            -->
  <!-- ================================================================== -->
  </xsl:template>
    <xsl:template match="svg">
    <xsl:copy-of select="doc('../' || @src)"/>
  </xsl:template>
  <xsl:template match="*">
    <xsl:element name="{local-name()}">
        <xsl:apply-templates/>
    </xsl:element>
  </xsl:template>
</xsl:stylesheet>
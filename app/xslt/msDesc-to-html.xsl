<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns:xs="http://www.w3.org/2001/XMLSchema"
  xmlns:math="http://www.w3.org/2005/xpath-functions/math"
  xpath-default-namespace="http://repertorium.obdurodon.org/model"
  xmlns:re="http://www.ilit.bas.bg/repertorium/ns/3.0"
  xmlns="http://www.w3.org/1999/xhtml" exclude-result-prefixes="#all" version="3.0">
  <xsl:import href="re-lib.xsl"/>
  <xsl:template match="main">
    <main id="msDesc">
        <!-- ============================================================ -->
        <!-- En title is main, Bg invokes Ru as sibling                   -->
        <!-- ============================================================ -->
        <xsl:apply-templates select="enMsName, bgMsName"/>
        <table id="msDescTable">
            <xsl:apply-templates select="(
              location, date, material, extent, condition
            )"/>
        </table>
        <hr/>
        <footer>
          <xsl:apply-templates select="id, authors, editors, genres"/>
        </footer>
    </main>
  </xsl:template>
  <xsl:template match="enMsName">
    <h2>
        <xsl:apply-templates/>
    </h2>
  </xsl:template>
  <xsl:template match="bgMsName">
    <p>
        <span class="label">Bg: </span>
        <xsl:value-of select="."/>
        <span class="label"> Ru: </span>
        <xsl:value-of select="../ruMsName"/>
    </p>
  </xsl:template>
  <xsl:template match="location">
    <tr>
      <th>Location</th>
      <td>
        <xsl:variable name="locationParts" as="xs:string+" select="country, settlement, repository, collection"/>
        <xsl:value-of select="string-join(($locationParts), ', ')"/>
        <xsl:if test="not(ends-with($locationParts[last()], '.'))">
          <xsl:text>. </xsl:text>
        </xsl:if>
        <span class="label"> Shelfmark: </span>
        <xsl:value-of select="shelfmark"/>
      </td>
    </tr>
  </xsl:template>
  <xsl:template match="id">
    <span class="label">Repertorium identifier: </span>
    <xsl:value-of select="."/>
  </xsl:template>
  <xsl:template match="authors">
    <span class="label"> Author: </span>
    <xsl:value-of select="string-join(author, ', ')"/>
  </xsl:template>
  <xsl:template match="editors">
    <span class="label"> Editor: </span>
    <xsl:value-of select="string-join(editor, ', ')"/>
  </xsl:template>
  <xsl:template match="genres">
    <span class="label"> Genre: </span>
    <xsl:value-of select="string-join(genre, ', ')"/>
  </xsl:template>
  <xsl:template match="*">
    <tr>
      <th><xsl:value-of select="re:titleCase(local-name())"/></th>
      <td><xsl:value-of select="."/></td>
    </tr>
  </xsl:template>
</xsl:stylesheet>
<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns:xs="http://www.w3.org/2001/XMLSchema"
  xmlns:math="http://www.w3.org/2005/xpath-functions/math"
  xpath-default-namespace="http://repertorium.obdurodon.org/model"
  xmlns="http://www.w3.org/1999/xhtml" exclude-result-prefixes="#all" version="3.0">
  <xsl:template match="main">
    <main id="msDesc">
        <!-- ============================================================ -->
        <!-- En title is main, Bg invokes Ru as sibling                   -->
        <!-- ============================================================ -->
        <xsl:apply-templates select="enMsName, bgMsName"/>
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
  <xsl:template match="*">
    <p><xsl:apply-templates/></p>
  </xsl:template>
</xsl:stylesheet>
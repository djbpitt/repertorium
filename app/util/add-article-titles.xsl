<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:tei="http://www.tei-c.org/ns/1.0"
  xmlns:re="http://www.ilit.bas.bg/repertorium/ns/3.0" exclude-result-prefixes="#all" version="3.0">
  <xsl:output method="xml" indent="no"/>
  <xsl:mode on-no-match="shallow-copy"/>
  <xsl:variable name="title-mapping" as="document-node()" select="doc('../aux/titles.xml')"/>
  <xsl:key name="titleByBg" match="title" use="bg"/>
  <xsl:template match="/*">
    <xsl:copy>
      <xsl:copy-of select="@*"/>
      <xsl:attribute name="status" select="'transformed'"/>
      <xsl:apply-templates/>
    </xsl:copy>
  </xsl:template>
  <!-- ================================================================== -->
  <!-- Add English and Russian article titles to msItemStruct elements    -->
  <!-- Source XML has only Bulgarian article titles                       -->
  <!-- ================================================================== -->
  <xsl:template match="tei:msItemStruct/tei:title">
    <xsl:variable name="enTitle" as="element(en)" select="key('titleByBg', ., $title-mapping)/en"/>
    <xsl:variable name="ruTitle" as="element(ru)" select="key('titleByBg', ., $title-mapping)/ru"/>
    <xsl:copy-of select="."/>
    <tei:title xml:lang="en">
      <xsl:value-of select="$enTitle"/>
    </tei:title>
    <tei:title xml:lang="ru">
      <xsl:value-of select="$ruTitle"/>
    </tei:title>
  </xsl:template>
  <!-- ================================================================== -->
  <!-- Remove schema association because transformed files are not valid  -->
  <!-- ================================================================== -->
  <xsl:template match="processing-instruction()"/>
</xsl:stylesheet>

<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns:xs="http://www.w3.org/2001/XMLSchema" xpath-default-namespace="http://www.tei-c.org/ns/1.0"
  exclude-result-prefixes="xs" xmlns="http://www.w3.org/1999/xhtml" version="2.0">
  <xsl:output method="xhtml" indent="yes"/>
  <xsl:variable name="bibliography" select="doc('bib.xml')"/>
  <xsl:template match="/">
    <html>
      <head>
        <title>Bibliography test</title>
      </head>
      <body>
        <h2>Bibliography</h2>
        <ul>
          <xsl:apply-templates select="//ref[starts-with(@target,'bib:')]">
            <xsl:sort/>
          </xsl:apply-templates>
        </ul>
      </body>
    </html>
  </xsl:template>
  <xsl:template match="ref">
    <xsl:variable name="target" select="substring-after(@target,'bib:')"/>
    <li>
      <!--      <strong>
        <xsl:value-of select="$target"/>
      </strong>
      <xsl:text> </xsl:text>
-->
      <xsl:apply-templates select="$bibliography//biblStruct[@xml:id = $target]"/>
    </li>
  </xsl:template>
  <xsl:template match="monogr">
    <xsl:apply-templates select="author, title, imprint"/>
  </xsl:template>
  <xsl:template match="author">
    <xsl:value-of select="concat(surname,', ', forename,'. ')"/>
  </xsl:template>
  <xsl:template match="title">
    <cite>
      <xsl:apply-templates/>
    </cite>
  </xsl:template>
  <xsl:template match="imprint">
    <xsl:value-of select="concat(pubPlace,': ',publisher,'. ',date,'.')"/>
  </xsl:template>
</xsl:stylesheet>

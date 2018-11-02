<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns:xs="http://www.w3.org/2001/XMLSchema" exclude-result-prefixes="xs"
  xmlns="http://www.w3.org/1999/xhtml" version="2.0">
  <xsl:output method="xhtml" indent="yes"/>
  <xsl:template match="/">
    <html>
      <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
        <xsl:comment>#config timefmt="%Y-%m-%dT%X%z" </xsl:comment>
        <xsl:comment>#set var="title" value="Authority file: texts" </xsl:comment>
        <title><xsl:comment>#echo var="title" </xsl:comment></title>
        <xsl:comment>#include virtual="inc/repertorium-header.xml" </xsl:comment>
      </head>
      <body>
        <xsl:comment>#include virtual="inc/repertorium-boilerplate.xml" </xsl:comment>
          <table>
            <tr><th>Bulgarian</th><th>English</th><th>Russian</th></tr>
            <xsl:apply-templates select="//title">
              <xsl:sort select="bg"/>
            </xsl:apply-templates>
          </table>
      </body>
    </html>
  </xsl:template>
  <xsl:template match="title">
    <tr>
      <td><xsl:apply-templates select="bg"/></td>
      <td><xsl:apply-templates select="en"/></td>
      <td><xsl:apply-templates select="ru"/></td>
    </tr>
  </xsl:template>
  <xsl:template match="text()">
    <xsl:value-of select="normalize-space(.)"/>
  </xsl:template>
</xsl:stylesheet>

<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns="http://www.w3.org/1999/xhtml" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:xs="http://www.w3.org/2001/XMLSchema" exclude-result-prefixes="xs" version="2.0">
  <xsl:output method="xhtml" indent="yes"/>
  <xsl:template match="/">
   <html>
      <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
        <title>
                    <xsl:value-of select="titles/head"/>
                </title>
    </head>
    <body>
    <div data-template="templates:surround" data-template-with="$data-root/templates/datatable.html" data-template-at="datatable">
          <table class="table table-striped table-sm table-hover">
          <thead>
            <tr>
                                <th>Bulgarian</th>
                                <th>English</th>
                                <th>Russian</th>
                            </tr>
            <xsl:apply-templates select="//title">
              <xsl:sort select="bg"/>
            </xsl:apply-templates>
            </thead>
          </table>
          </div>
      </body>
      
    </html>
    </xsl:template>
    
     <xsl:template match="title">
    <tr>
      <td>
                <xsl:apply-templates select="bg"/>
            </td>
      <td>
                <xsl:apply-templates select="en"/>
            </td>
      <td>
                <xsl:apply-templates select="ru"/>
            </td>
    </tr>
  </xsl:template>
  <xsl:template match="text()">
    <xsl:value-of select="normalize-space(.)"/>
  </xsl:template>
</xsl:stylesheet>
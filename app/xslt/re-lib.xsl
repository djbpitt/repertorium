<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns:xs="http://www.w3.org/2001/XMLSchema"
  xmlns:math="http://www.w3.org/2005/xpath-functions/math"
  xmlns:re="http://www.ilit.bas.bg/repertorium/ns/3.0"
  xpath-default-namespace="http://repertorium.obdurodon.org/model"
  exclude-result-prefixes="#all"
  version="3.0">
  <xsl:function name="re:titleCase" as="xs:string">
    <xsl:param name="text" as="xs:string"/>
    <xsl:value-of select="upper-case(substring($text, 1, 1)) || substring($text, 2)"/>
  </xsl:function>
</xsl:stylesheet>
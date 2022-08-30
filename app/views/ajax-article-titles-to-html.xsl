<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    xmlns:math="http://www.w3.org/2005/xpath-functions/math"
    xpath-default-namespace="http://www.obdurodon.org/model"
    xmlns="http://www.w3.org/1999/xhtml"
    exclude-result-prefixes="#all" version="3.0">
    <xsl:output method="xml" indent="yes" encoding="UTF-16" byte-order-mark="no"/>
    <!--
    Returns sequence of <option> elements in HTML namespace
      to be inserted into <datalist>
      NB: Output is not well formed because it lacks a root
  -->
    <xsl:template match="options">
        <datalist>
            <xsl:apply-templates select="descendant::option"/>
        </datalist>
    </xsl:template>
    <xsl:template match="option">
        <option value="{.}">
            <xsl:value-of select="."/>
        </option>
    </xsl:template>
</xsl:stylesheet>
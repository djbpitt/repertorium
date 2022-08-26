<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    xmlns:math="http://www.w3.org/2005/xpath-functions/math"
    xmlns:m="http://www.obdurodon.org/model" xmlns:re="http://www.ilit.bas.bg/repertorium/ns/3.0"
    xmlns="http://www.w3.org/1999/xhtml" exclude-result-prefixes="#all" version="3.0">
    <!-- ================================================================== -->
    <!-- User-defined functions                                             -->
    <!-- ================================================================== -->
    <xsl:function name="re:title-case" as="xs:string">
        <xsl:param name="input" as="xs:string"/>
        <xsl:value-of select="concat(upper-case(substring($input, 1, 1)), substring($input, 2))"/>
    </xsl:function>
</xsl:stylesheet>

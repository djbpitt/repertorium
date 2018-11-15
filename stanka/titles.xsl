<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    xmlns:math="http://www.w3.org/2005/xpath-functions/math" exclude-result-prefixes="#all"
    version="3.0">
    <xsl:output method="xml" indent="yes"/>
    <xsl:template name="xsl:initial-template">
        <xsl:variable name="input" as="xs:string" select="unparsed-text('titles.txt')"/>
        <xsl:variable name="entries" select="tokenize($input, '\n\n')"/>
        <titles>
            <xsl:for-each select="$entries">
                <xsl:variable name="lines" as="xs:string+" select="tokenize(., '\n')"/>
                <title>
                <bg><xsl:value-of select="$lines[1]"/></bg>
                <en><xsl:value-of select="$lines[2]"/></en>
                <ru><xsl:value-of select="$lines[3]"/></ru>
            </title>
            </xsl:for-each>
        </titles>
    </xsl:template>
</xsl:stylesheet>

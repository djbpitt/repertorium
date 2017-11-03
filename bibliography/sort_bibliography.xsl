<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns="http://www.tei-c.org/ns/1.0"
    xpath-default-namespace="http://www.tei-c.org/ns/1.0"
    xmlns:xs="http://www.w3.org/2001/XMLSchema" exclude-result-prefixes="#all" version="2.0">
    <!-- Sorts biblStruct elements by @xml:id value -->
    <xsl:output method="xml" indent="yes"/>
    <xsl:template match="@* | node()">
        <xsl:copy>
            <xsl:apply-templates select="@* | node()"/>
        </xsl:copy>
    </xsl:template>
    <xsl:template match="listBibl">
        <listBibl>
            <xsl:apply-templates select="biblStruct">
                <xsl:sort select="@xml:id"/>
            </xsl:apply-templates>
        </listBibl>
    </xsl:template>
</xsl:stylesheet>

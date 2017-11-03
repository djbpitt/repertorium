<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    exclude-result-prefixes="xs" xpath-default-namespace="http://www.tei-c.org/ns/1.0"
    version="2.0">
    <!-- Run against MyZoteroLibrary.xml (new bibliography) to look for duplicates in bib.xml (old bibliography) -->
    <xsl:output method="text"/>
    <xsl:variable name="old" as="document-node()" select="document('bib.xml')"/>
    <xsl:key name="biblStructById" match="biblStruct" use="@xml:id"/>
    <xsl:template match="/">
        <xsl:for-each select="//biblStruct">
            <xsl:sort select="@xml:id"/>
            <xsl:if test="key('biblStructById',@xml:id,$old)">
                <xsl:value-of select="concat(@xml:id, ' is a duplicate.&#x0a;')"/>
            </xsl:if>
        </xsl:for-each>
    </xsl:template>
</xsl:stylesheet>
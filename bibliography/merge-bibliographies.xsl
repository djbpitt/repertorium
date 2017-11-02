<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema" exclude-result-prefixes="#all"
    xmlns="http://www.tei-c.org/ns/1.0" xpath-default-namespace="http://www.tei-c.org/ns/1.0"
    version="2.0">
    <!-- 
        Run against bib.xml to import non-duplicate records from MyZoteroLibrary.xml
        and write merged result to new output file
    -->
    <xsl:output method="xml" indent="yes"> </xsl:output>
    <xsl:variable name="new" as="document-node()" select="document('MyZoteroLibrary.xml')"/>
    <xsl:key name="biblStructById" match="biblStruct" use="@xml:id"/>
    <xsl:template match="@* | node()">
        <xsl:copy>
            <xsl:apply-templates select="@* | node()"/>
        </xsl:copy>
    </xsl:template>
    <xsl:template match="listBibl">
        <xsl:copy>
            <xsl:apply-templates select="@*"/>
            <xsl:variable name="records" as="element(biblStruct)+">
                <xsl:apply-templates select="$new//biblStruct"/>
                <xsl:apply-templates select="biblStruct[not(@xml:id = $new//biblStruct/@xml:id)]"/>
            </xsl:variable>
            <xsl:apply-templates select="$records">
                <xsl:sort select="@xml:id"/>
            </xsl:apply-templates>
        </xsl:copy>
    </xsl:template>
</xsl:stylesheet>

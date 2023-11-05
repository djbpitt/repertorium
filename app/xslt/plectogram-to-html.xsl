<xsl:stylesheet xmlns="http://www.w3.org/2000/svg" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema" xpath-default-namespace="http://www.w3.org/2000/svg"
    exclude-result-prefixes="#all" version="3.0">
    <xsl:output method="xml" indent="no" omit-xml-declaration="yes"/>
    <xsl:template match="node() | @*" mode="#all">
        <xsl:copy>
            <xsl:apply-templates select="node() | @*" mode="#current"/>
        </xsl:copy>
    </xsl:template>
    <xsl:template match="/">
        <main xmlns="http://www.w3.org/1999/xhtml" xml:id="main_svg">
            <h2>Visualize textual relationships</h2>
            <xsl:apply-templates/>
        </main>
    </xsl:template>
    <xsl:template match="g[@id eq 'main_svg']">
        <xsl:copy>
            <xsl:apply-templates select="@*"/>
            <xsl:apply-templates mode="columns"/>
            <xsl:apply-templates mode="lines"/>
        </xsl:copy>
    </xsl:template>
    <!-- create <g id="columns"> and copy everything except lines-->
    <xsl:template match="g[@id eq 'columns']" mode="columns">
        <xsl:copy>
            <xsl:apply-templates select="node() | @*" mode="#current"/>
        </xsl:copy>
    </xsl:template>
    <xsl:template match="g[@id eq 'columns']/g/g" mode="columns">
        <xsl:copy>
            <xsl:apply-templates select="@* | node() except line"/>
        </xsl:copy>
    </xsl:template>
    <!-- create <g id="lines"> and copy only lines -->
    <xsl:template match="g[@id eq 'columns']" mode="lines">
        <g id="lines">
            <xsl:copy-of select="descendant::line"/>
        </g>
    </xsl:template>
</xsl:stylesheet>

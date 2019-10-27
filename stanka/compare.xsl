<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns="http://www.w3.org/1999/xhtml" xmlns:xs="http://www.w3.org/2001/XMLSchema"
    xmlns:math="http://www.w3.org/2005/xpath-functions/math" exclude-result-prefixes="#all"
    xpath-default-namespace="http://www.tei-c.org/ns/1.0"
    xmlns:re="http://www.ilit.bas.bg/repertorium/ns/3.0" version="3.0">
    <xsl:output method="xml" indent="no"/>
    <xsl:variable name="drag" as="document-node()" select="doc('drag_test1-red-fin.xml')"/>
    <xsl:template match="/">
        <html>
            <head>
                <title>Stuff</title>
            </head>
            <body>
                <h1>Stuff</h1>
                <svg xmlns="http://www.w3.org/2000/svg" width="100%"
                    height="{(count($drag//msContents/msItemStruct) + 1) * 20}">
                    <g transform="translate(10)">
                        <xsl:for-each select="$drag//msContents/msItemStruct/title">
                            <text x="0" y="{position() * 20}">
                                <xsl:value-of select="position() || '. ' || ."/>
                            </text>
                        </xsl:for-each>
                    </g>
                </svg>
            </body>
        </html>
    </xsl:template>
</xsl:stylesheet>

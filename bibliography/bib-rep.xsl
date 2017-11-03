<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns="http://www.w3.org/1999/xhtml" xmlns:tei="http://www.tei-c.org/ns/1.0" version="2.0"
    exclude-result-prefixes="#all">
    <xsl:output method="xml" indent="yes" doctype-public="-//W3C//DTD XHTML 1.0 Strict//EN"
        doctype-system="http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd"/>
    <xsl:preserve-space elements="*"/>
    <xsl:template match="/">
        <html>
            <head>
                <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
                <xsl:comment>#config timefmt="%Y-%m-%dT%X%z" </xsl:comment>
                <xsl:comment>#set var="title" value="Repertorium bibliography (under development)" </xsl:comment>
                <title>
                    <xsl:comment>#echo var="title" </xsl:comment>
                </title>
                <xsl:comment>#include virtual="inc/repertorium-header.xml" </xsl:comment>
            </head>
            <body>
                <xsl:comment>#include virtual="inc/repertorium-boilerplate.xml" </xsl:comment>
                <xsl:apply-templates select="//tei:text/tei:body"/>
            </body>
        </html>
    </xsl:template>

    <xsl:template match="tei:listBibl">
        <ul class="bibl">
            <xsl:apply-templates select="tei:biblStruct"/>
        </ul>
    </xsl:template>

    <xsl:template match="tei:biblStruct">
        <li xml:id="{@xml:id}">
            <xsl:apply-templates/>
            <xsl:text> [</xsl:text>
            <xsl:value-of select="@xml:id"/>
            <xsl:text>]</xsl:text>
        </li>
    </xsl:template>

    <xsl:template match="tei:analytic|tei:monogr">
        <xsl:apply-templates select="tei:author, tei:editor, tei:title, tei:imprint"/>
    </xsl:template>



    <xsl:template match="tei:author|tei:editor">
        <span class="author">
            <xsl:value-of select="concat(tei:surname,', ', tei:forename,'. ')"/>

        </span>

        <xsl:choose>

            <!-- last name in a list -->

            <xsl:when test="self::tei:author and not(following-sibling::tei:author)">

                <xsl:text> </xsl:text>
            </xsl:when>
            <xsl:when test="self::tei:editor and not(following-sibling::tei:editor)">

                <xsl:text> (</xsl:text>
                <xsl:text>ed</xsl:text>
                <xsl:if test="preceding-sibling::tei:editor">s</xsl:if>
                <xsl:text>.</xsl:text>
                <xsl:text>) </xsl:text>
            </xsl:when>
        </xsl:choose>
    </xsl:template>

    <xsl:template match="tei:title">
        <xsl:if test="preceding-sibling::tei:title">
            <xsl:text> &#8212; </xsl:text>
        </xsl:if>

        <xsl:choose>
            <xsl:when test="@level='m' or @level='s' or @level='j'  or not(@level)">
                <em>
                    <xsl:apply-templates/>
                </em>
                <xsl:text>. </xsl:text>
            </xsl:when>
            <xsl:when test="@level='a'">
                <span class="a">

                    <xsl:apply-templates/>
                </span>

                <xsl:text>. </xsl:text>

            </xsl:when>
            <xsl:when test="@level='u'">
                <span class="u">
                    <xsl:apply-templates/>

                </span>

            </xsl:when>

        </xsl:choose>
    </xsl:template>

    <xsl:template match="tei:date">
        <xsl:apply-templates/>
        <xsl:text>. </xsl:text>

    </xsl:template>

    <xsl:template match="tei:series">
        <xsl:text>(</xsl:text>
        <xsl:value-of select="tei:title[@level='s']"/>
        <xsl:text> </xsl:text>
        <xsl:value-of select="tei:biblScope[@type='vol']"/>
        <xsl:text>). </xsl:text>
    </xsl:template>

    <xsl:template match="tei:pubPlace">
        <xsl:choose>
            <xsl:when test="following-sibling::tei:pubPlace">
                <xsl:apply-templates/>
                <xsl:text>, </xsl:text>
            </xsl:when>
            <xsl:when test="following-sibling::tei:publisher">
                <xsl:apply-templates/>
                <xsl:text>: </xsl:text>
            </xsl:when>
            <xsl:otherwise>
                <xsl:apply-templates/>
                <xsl:text>. </xsl:text>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>

    <xsl:template match="tei:publisher">
        <span class="publisher">
            <xsl:apply-templates/>
            <xsl:text>. </xsl:text>
        </span>
    </xsl:template>



    <xsl:template match="tei:imprint">
        <xsl:choose>
            <xsl:when test="ancestor::tei:biblStruct">

                <xsl:apply-templates select="tei:pubPlace"/>
                <xsl:apply-templates select="tei:publisher"/>
                <xsl:apply-templates select="tei:date"/>
                <xsl:apply-templates select="tei:biblScope"/>
                <xsl:apply-templates select="tei:note"/>
            </xsl:when>
            <xsl:otherwise>
                <xsl:apply-templates/>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>

    <xsl:template match="tei:biblScope">
        <xsl:choose>

            <xsl:when test="@type='vol'">

                <xsl:text>vol. </xsl:text>

                <xsl:apply-templates/>
                <xsl:text>. </xsl:text>
            </xsl:when>
            <xsl:when test="@type='chap'">
                <xsl:text>chapter </xsl:text>
                <xsl:apply-templates/>
            </xsl:when>
            <xsl:when test="@type='issue'">
                <xsl:text> (</xsl:text>
                <xsl:apply-templates/>
                <xsl:text>) </xsl:text>
            </xsl:when>
            <xsl:when test="@type='pp'">
                <xsl:choose>
                    <xsl:when test="contains(.,'-')">
                        <xsl:text>pp. </xsl:text>
                    </xsl:when>
                    <xsl:when test="contains(.,'ff')">
                        <xsl:text>ff. </xsl:text>
                    </xsl:when>
                    <xsl:when test="contains(.,' ')">
                        <xsl:text>pp. </xsl:text>
                    </xsl:when>
                    <xsl:otherwise>
                        <xsl:text>p. </xsl:text>
                    </xsl:otherwise>
                </xsl:choose>
                <xsl:apply-templates/>
            </xsl:when>
            <xsl:otherwise>
                <xsl:apply-templates/>
            </xsl:otherwise>
        </xsl:choose>

        <xsl:choose>
            <xsl:when
                test="@type='vol' and
                following-sibling::tei:biblScope[@type='issue']">
                <xsl:text> </xsl:text>
            </xsl:when>
            <xsl:when test="@type='vol' and following-sibling::tei:biblScope">
                <xsl:text> </xsl:text>
            </xsl:when>
            <xsl:when test="following-sibling::tei:biblScope">
                <xsl:text> </xsl:text>
            </xsl:when>
            <xsl:when test="ancestor::tei:biblStruct">
                <xsl:text>. </xsl:text>
            </xsl:when>
        </xsl:choose>
    </xsl:template>

    <xsl:template match="tei:note">
        <span class="note"> (<xsl:apply-templates/>) </span>
    </xsl:template>


</xsl:stylesheet>

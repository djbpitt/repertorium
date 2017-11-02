<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xpath-default-namespace="http://www.tei-c.org/ns/1.0"
    xmlns:exist="http://exist.sourceforge.net/NS/exist" xmlns:djb="http://www.obdurodon.org"
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:xs="http://www.w3.org/2001/XMLSchema"
    exclude-result-prefixes="#all" version="2.0">
    <xsl:strip-space elements="*"/>
    <xsl:output method="xhtml" indent="yes" omit-xml-declaration="yes"/>
    <xsl:param name="highlight" as="xs:string" select="'null'"/>
    <xsl:function name="djb:highlight">
        <xsl:param name="haystack" as="xs:string"/>
        <xsl:param name="needle" as="xs:string"/>
        <xsl:analyze-string select="$haystack" regex="{$needle}" flags="i">
            <xsl:matching-substring>
                <span class="target">
                    <xsl:value-of select="."/>
                </span>
            </xsl:matching-substring>
            <xsl:non-matching-substring>
                <xsl:value-of select="."/>
            </xsl:non-matching-substring>
        </xsl:analyze-string>
    </xsl:function>
    <xsl:template match="/">
        <xsl:apply-templates select="//biblStruct">
            <xsl:sort select="(.//author/surname)[1]"/>
            <xsl:sort select="(.//author/surname)[2]"/>
            <xsl:sort select="(.//date)[1]"/>
        </xsl:apply-templates>
    </xsl:template>
    <xsl:template match="biblStruct">
        <li>
            <xsl:choose>
                <xsl:when test="@type eq 'book'">
                    <xsl:choose>
                        <xsl:when test=".//author">
                            <xsl:apply-templates select=".//author"/>
                        </xsl:when>
                        <xsl:when test="not(.//author)">
                            <xsl:apply-templates select=".//editor"/>
                            <xsl:text>, ed</xsl:text>
                            <xsl:if test="count(.//editor) gt 1">
                                <xsl:text>s</xsl:text>
                            </xsl:if>
                            <xsl:text>. </xsl:text>
                        </xsl:when>
                    </xsl:choose>
                    <xsl:apply-templates select=".//date"/>
                    <xsl:apply-templates select="monogr/title"/>
                    <xsl:if test=".//author and .//editor">
                        <xsl:apply-templates select=".//editor"/>
                        <xsl:text>, ed</xsl:text>
                        <xsl:if test="count(.//editor) gt 1">
                            <xsl:text>s</xsl:text>
                        </xsl:if>
                        <xsl:text>.</xsl:text>
                    </xsl:if>
                    <xsl:apply-templates select=".//imprint/biblScope[@type='vol']"/>
                    <xsl:apply-templates select="edition"/>
                    <xsl:apply-templates select="series"/>
                    <xsl:apply-templates select=".//imprint"/>
                    <xsl:apply-templates select="idno"/>
                </xsl:when>
                <xsl:when test="@type eq 'bookSection'">
                    <xsl:apply-templates select="analytic/author"/>
                    <xsl:apply-templates select=".//date"/>
                    <xsl:apply-templates select="analytic/title"/>
                    <xsl:apply-templates select="monogr/editor"/>
                    <xsl:text>. </xsl:text>
                    <xsl:apply-templates select="monogr/title"/>
                    <xsl:apply-templates select=".//imprint/biblScope[@type='vol']"/>
                    <xsl:apply-templates select=".//imprint"/>
                    <xsl:apply-templates select=".//biblScope[@type='pp']"/>
                </xsl:when>
                <xsl:when test="@type eq 'manuscript'">
                    <xsl:apply-templates select=".//author"/>
                    <xsl:apply-templates select=".//imprint/date"/>
                    <xsl:apply-templates select=".//title"/>
                    <xsl:apply-templates select=".//imprint"/>
                </xsl:when>
                <xsl:when test="@type eq 'thesis'">
                    <xsl:apply-templates select=".//author"/>
                    <xsl:apply-templates select=".//date"/>
                    <xsl:apply-templates select=".//title"/>
                    <xsl:apply-templates select=".//note[@type='thesisType']"/>
                    <xsl:apply-templates select=".//imprint"/>
                </xsl:when>
                <xsl:when test="@type eq 'journalArticle'">
                    <xsl:apply-templates select=".//author"/>
                    <xsl:apply-templates select=".//date"/>
                    <xsl:apply-templates select="analytic/title"/>
                    <xsl:apply-templates select="monogr/title"/>
                    <xsl:apply-templates select=".//imprint"/>
                </xsl:when>
                <xsl:otherwise>
                    <strong>Unmatched: </strong>
                    <xsl:value-of select="@type"/>
                </xsl:otherwise>
            </xsl:choose>
        </li>
    </xsl:template>
    <xsl:template match="author | editor">
        <xsl:choose>
            <xsl:when test="position() = 1">
                <xsl:apply-templates select="surname"/>
                <xsl:text>, </xsl:text>
                <xsl:apply-templates select="forename"/>
            </xsl:when>
            <xsl:otherwise>
                <xsl:text>, </xsl:text>
                <xsl:apply-templates select="forename"/>
                <xsl:text> </xsl:text>
                <xsl:apply-templates select="surname"/>
            </xsl:otherwise>
        </xsl:choose>
        <xsl:if test="position() = last() and self::author">
            <xsl:text>. </xsl:text>
        </xsl:if>
    </xsl:template>
    <xsl:template match="date">
        <xsl:apply-templates/>
        <xsl:text>. </xsl:text>
    </xsl:template>
    <xsl:template match="title[@level='m']">
        <xsl:variable name="tempTitle" select="normalize-space(.)"/>
        <cite>
            <xsl:sequence
                select="if ($highlight) then djb:highlight($tempTitle,$highlight) else $tempTitle"/>
            <xsl:if test="matches(substring($tempTitle,string-length($tempTitle)),'[^\.\?]')">
                <xsl:text>. </xsl:text>
            </xsl:if>
        </cite>
        <xsl:text> </xsl:text>
    </xsl:template>
    <xsl:template match="title[@level='s']">
        <cite>
            <xsl:apply-templates/>
            <xsl:if test="not(following-sibling::*)">
                <xsl:text>.</xsl:text>
            </xsl:if>
        </cite>
    </xsl:template>
    <xsl:template match="title[@level='a']">
        <xsl:variable name="tempTitle" select="normalize-space(.)"/>
        <q>
            <xsl:sequence
                select="if ($highlight) then djb:highlight($tempTitle,$highlight) else $tempTitle"/>
            <xsl:if test="matches(substring($tempTitle,string-length($tempTitle)),'[^\.\?]')">
                <xsl:text>.</xsl:text>
            </xsl:if>
        </q>
        <xsl:text> </xsl:text>
    </xsl:template>
    <xsl:template match="imprint">
        <xsl:apply-templates select="pubPlace"/>
        <xsl:if test="pubPlace and publisher">
            <xsl:text>: </xsl:text>
        </xsl:if>
        <xsl:apply-templates select="publisher"/>
        <xsl:text>. </xsl:text>
    </xsl:template>
    <xsl:template match="biblStruct[@type='journalArticle']//imprint">
        <xsl:apply-templates select="biblScope"/>
    </xsl:template>
    <xsl:template match="series">
        <xsl:text>(</xsl:text>
        <xsl:apply-templates/>
        <xsl:text>) </xsl:text>
    </xsl:template>
    <xsl:template match="series/biblScope">
        <xsl:text> </xsl:text>
        <xsl:value-of select="@type"/>
        <xsl:text> </xsl:text>
        <xsl:apply-templates/>
        <xsl:text>.</xsl:text>
    </xsl:template>
    <xsl:template match="imprint/biblScope">
        <xsl:value-of select="@type"/>
        <xsl:text> </xsl:text>
        <xsl:apply-templates/>
        <xsl:text>. </xsl:text>
    </xsl:template>
    <xsl:template match="edition">
        <xsl:if test="matches(.,'\d+')">
            <xsl:text>Edition </xsl:text>
        </xsl:if>
        <xsl:apply-templates/>
        <xsl:text>. </xsl:text>
    </xsl:template>
    <xsl:template match="idno">
        <xsl:value-of select="@type"/>
        <xsl:text> </xsl:text>
        <xsl:apply-templates/>
    </xsl:template>
    <xsl:template match="note[@type='thesisType']">
        <xsl:apply-templates/>
        <xsl:text> thesis. </xsl:text>
    </xsl:template>
    <xsl:template match="exist:match">
        <span style="color: red;">
            <xsl:apply-templates/>
        </span>
    </xsl:template>
    <xsl:template match="text()">
        <xsl:choose>
            <xsl:when test="$highlight">
                <xsl:analyze-string select="." regex="{string-join(tokenize($highlight,'\s+'),'|')}" flags="i">
                    <xsl:matching-substring>
                        <span class="target">
                            <xsl:value-of select="."/>
                        </span>
                    </xsl:matching-substring>
                    <xsl:non-matching-substring>
                        <xsl:value-of select="."/>
                    </xsl:non-matching-substring>
                </xsl:analyze-string>
            </xsl:when>
            <xsl:otherwise>
                <xsl:value-of select="."/>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>
</xsl:stylesheet>

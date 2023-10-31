<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns:xs="http://www.w3.org/2001/XMLSchema"
  xmlns:math="http://www.w3.org/2005/xpath-functions/math"
  xpath-default-namespace="http://repertorium.obdurodon.org/model"
  xmlns:re="http://www.ilit.bas.bg/repertorium/ns/3.0" xmlns:tei="http://www.tei-c.org/ns/1.0"
  xmlns="http://www.w3.org/1999/xhtml" exclude-result-prefixes="#all" version="3.0">
  <xsl:output indent="yes"/>
  <xsl:import href="re-lib.xsl"/>
  <xsl:strip-space elements="bibl"/>
  <xsl:template match="main">
    <!-- ================================================================ -->
    <!-- Main                                                             -->
    <!-- ================================================================ -->
    <main id="titles">
      <!-- ============================================================ -->
      <!-- En title is main, Bg invokes Ru as sibling                   -->
      <!-- ============================================================ -->
      <h2>
        <xsl:apply-templates select="enMsName, bgMsName, ruMsName"/>
      </h2>
      <h3>
        <xsl:apply-templates select="location"/>
      </h3>
      <xsl:apply-templates select="msContents"/>
      <hr/>
      <footer>
        <xsl:apply-templates select="id, authors, editors, genres"/>
      </footer>
    </main>
  </xsl:template>
  <!-- ================================================================== -->
  <!-- Manuscript names in three languages                                -->
  <!-- ================================================================== -->
  <xsl:template match="enMsName | bgMsName | ruMsName">
    <span>
      <xsl:attribute name="class">
        <xsl:variable name="lg" as="xs:string" select="substring(local-name(), 1, 2)"/>
        <xsl:value-of select="$lg"/>
        <xsl:if test="$lg ne ../name"> hide</xsl:if>
      </xsl:attribute>
      <xsl:apply-templates/>
    </span>
  </xsl:template>
  <!-- ================================================================== -->
  <!-- Location elements                                                  -->
  <!-- ================================================================== -->
  <xsl:template match="location">
    <h3>
      <xsl:apply-templates/>
    </h3>
  </xsl:template>
  <xsl:template match="country | settlement | repository">
    <a href="search?{local-name()}={.}">
      <xsl:value-of select="."/>
    </a>
    <xsl:if test="following-sibling::*">
      <xsl:text>, </xsl:text>
    </xsl:if>
  </xsl:template>
  <xsl:template match="collection | shelfmark">
    <xsl:value-of select="."/>
    <xsl:if test="following-sibling::*">
      <xsl:text>, </xsl:text>
    </xsl:if>
  </xsl:template>

  <xsl:template match="sup">
    <!-- ================================================================ -->
    <!-- Used in sampleText                                               -->
    <!-- ================================================================ -->
    <xsl:element name="{local-name()}">
      <xsl:apply-templates/>
    </xsl:element>
  </xsl:template>
  <!-- ================================================================== -->
  <!-- Elements for msContents (all in m: namespace)                      -->
  <!--                                                                    -->
  <!-- add, author, bibl, colophon, damage, date, decoNote, del, div,     -->
  <!-- edition, emph, epigraph, explicit, extent, filiation, finalRubric, -->
  <!-- foreign, gap, geogName, head, hi, incipit, item, label, lb, list,  -->
  <!-- listBibl, locus, locusGrp, milestone, msItemStruct, name, note,    -->
  <!-- num, p, pb, persName, phr, q, quote, ref, rs, rubric, sampleText,  -->
  <!-- seg, sic, soCalled, summary, supplied, textLang, title, titlePage, -->
  <!-- unclear                                                            -->
  <!-- ================================================================== -->
  <xsl:template match="msContents">
    <h4>Contents</h4>
    <div id="titlesWrapper">
      <xsl:apply-templates select="msItemStruct"/>
    </div>
  </xsl:template>
  <xsl:template match="msItemStruct">
    <div class="text">
      <xsl:apply-templates select="title, sampleText"/>
      <xsl:apply-templates select="msItemStruct"/>
    </div>
  </xsl:template>
  <xsl:template match="locus">
    <xsl:text> [</xsl:text>
    <xsl:apply-templates/>
    <xsl:text>] </xsl:text>
  </xsl:template>
  <xsl:template match="title">
    <span>
      <xsl:attribute name="class">
        <xsl:value-of select="@xml:lang"/>
        <xsl:if test="@xml:lang ne /main/lg">
          <xsl:value-of select="hide"/>
        </xsl:if>
      </xsl:attribute>
      <xsl:apply-templates/>
    </span>
    <xsl:if test="not(following-sibling::title)">
      <xsl:apply-templates select="../locus"/>
    </xsl:if>
  </xsl:template>
  <xsl:template match="sampleText">
    <div class="samples">
      <xsl:apply-templates/>
    </div>
  </xsl:template>
  <xsl:template match="head | rubric | incipit | sampleText/p | explicit | finalRubric">
    <xsl:variable name="outName" as="xs:string">
      <xsl:choose>
        <xsl:when test="self::p and parent::sampleText">sample</xsl:when>
        <xsl:otherwise>
          <xsl:value-of select="local-name(), ' os'"/>
        </xsl:otherwise>
      </xsl:choose>
    </xsl:variable>
    <span class="{$outName}">
      <xsl:apply-templates/>
    </span>
  </xsl:template>
  <xsl:template match="note">
    <span class="note">
      <xsl:apply-templates/>
    </span>
  </xsl:template>
  <xsl:template match="seg[@rend eq 'sup']">
    <sup>
      <xsl:apply-templates/>
    </sup>
  </xsl:template>
  <xsl:template match="ref">
    <!-- TODO: Create hover reference -->
    <ref>
      <xsl:apply-templates/>
    </ref>
  </xsl:template>
  <xsl:template match="bibl">
    <span class="bibl">
      <xsl:choose>
        <xsl:when test="*">
          <xsl:apply-templates mode="bibl_inline"/>
        </xsl:when>
        <xsl:otherwise>
          <xsl:apply-templates/>
        </xsl:otherwise>
      </xsl:choose>
    </span>
  </xsl:template>
  <xsl:template match="ref[@type eq 'bibl']">
    <span class="bibl">
      <xsl:apply-templates/>
    </span>
  </xsl:template>
  <xsl:template match="sic | unclear | add | del | supplied">
    <span class="{local-name()}">
      <xsl:apply-templates/>
    </span>
  </xsl:template>
  <xsl:template match="foreign[@xml:lang eq 'cu']">
    <span class="os">
      <xsl:apply-templates/>
    </span>
  </xsl:template>
  <xsl:template match="gap">
    <span class="gap">
      <xsl:if test="empty(node())">
        <xsl:text>…</xsl:text>
      </xsl:if>
    </span>
  </xsl:template>
  <xsl:template match="damage">
    <xsl:apply-templates/>
  </xsl:template>
  <xsl:template match="foreign">
    <!-- Temporary workaround: default to os for <foreign> elements that lack @xml:lang -->
    <span class="{(@xml:lang, 'os')[1]}">
      <xsl:apply-templates/>
    </span>
  </xsl:template>
  <!-- ================================================================== -->
  <!-- Mode bibl_inline: structured <bibl> inside msItemStruct            -->
  <!-- ================================================================== -->
  <xsl:template match="bibl" mode="bibl_inline">
    <xsl:apply-templates mode="bibl_inline"/>
  </xsl:template>
  <xsl:template match="bibl/*" mode="bibl_inline">
    <xsl:apply-templates mode="bibl_inline"/>
    <xsl:if test="following-sibling::*">
      <xsl:text>, </xsl:text>
    </xsl:if>
  </xsl:template>
  <!-- ================================================================== -->
  <!-- Elements for footer                                                -->
  <!-- ================================================================== -->
  <xsl:template match="id">
    <span class="label">Repertorium identifier: </span>
    <xsl:value-of select="."/>
    <xsl:value-of select="'; '"/>
  </xsl:template>
  <xsl:template match="authors">
    <span class="label">Author: </span>
    <xsl:value-of select="string-join(author, ', ')"/>
    <xsl:value-of select="'; '"/>
  </xsl:template>
  <xsl:template match="editors">
    <span class="label">Editor: </span>
    <xsl:value-of select="string-join(editor, ', ')"/>
    <xsl:value-of select="'; '"/>
  </xsl:template>
  <xsl:template match="genres">
    <span class="label"> Genre: </span>
    <xsl:value-of select="string-join(genre, ', ')"/>
  </xsl:template>
</xsl:stylesheet>

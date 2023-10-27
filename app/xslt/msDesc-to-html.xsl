<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns:xs="http://www.w3.org/2001/XMLSchema"
  xmlns:math="http://www.w3.org/2005/xpath-functions/math"
  xpath-default-namespace="http://repertorium.obdurodon.org/model"
  xmlns:re="http://www.ilit.bas.bg/repertorium/ns/3.0"
  xmlns:tei="http://www.tei-c.org/ns/1.0"
  xmlns="http://www.w3.org/1999/xhtml" exclude-result-prefixes="#all" version="3.0">
  <xsl:import href="re-lib.xsl"/>
  <xsl:template match="main">
    <!-- ================================================================ -->
    <!-- Main                                                             -->
    <!-- ================================================================ -->
    <main id="msDesc">
        <!-- ============================================================ -->
        <!-- En title is main, Bg invokes Ru as sibling                   -->
        <!-- ============================================================ -->
        <xsl:apply-templates select="enMsName, bgMsName"/>
        <table id="msDescTable">
            <xsl:apply-templates select="(
              location, date, material, extent, foliation, collation, watermarks, 
              layout, binding, condition, msContents
            )"/>
        </table>
        <hr/>
        <footer>
          <xsl:apply-templates select="id, authors, editors, genres"/>
        </footer>
    </main>
  </xsl:template>
  <!-- ================================================================== -->
  <!-- Manuscript names in three languages                                -->
  <!-- ================================================================== -->
  <xsl:template match="enMsName">
    <h2>
        <xsl:apply-templates/>
    </h2>
  </xsl:template>
  <xsl:template match="bgMsName">
    <p>
        <span class="label">Bg: </span>
        <xsl:value-of select="."/>
        <xsl:value-of select="'; '"/>
        <span class="label">Ru: </span>
        <xsl:value-of select="../ruMsName"/>
    </p>
  </xsl:template>
  <!-- ================================================================== -->
  <!-- Contents of table (except msContents; see below)                   -->
  <!-- ================================================================== -->
  <xsl:template match="location">
    <tr>
      <th>Location</th>
      <td>
        <xsl:variable name="locationParts" as="xs:string+" select="country, settlement, repository, collection"/>
        <xsl:value-of select="string-join(($locationParts), ', ')"/>
        <xsl:if test="not(ends-with($locationParts[last()], '.'))">
          <xsl:text>. </xsl:text>
        </xsl:if>
        <span class="label"> Shelfmark: </span>
        <xsl:value-of select="shelfmark"/>
      </td>
    </tr>
  </xsl:template>
  <xsl:template match="watermarks">
    <th>Watermarks</th>
    <td><xsl:apply-templates/></td>
  </xsl:template>
  <xsl:template match="watermark">
    <xsl:apply-templates/>
    <xsl:if test="following-sibling::watermark">
      <br/>
    </xsl:if>
  </xsl:template>
  <xsl:template match="collation">
    <tr>
      <th>Collation</th>
      <td><xsl:apply-templates/></td>
    </tr>
  </xsl:template>
  <xsl:template match="sup">
    <!-- ================================================================ -->
    <!-- Used in collation formulae                                       -->
    <!-- ================================================================ -->
    <xsl:element name="{local-name()}"><xsl:apply-templates/></xsl:element>
  </xsl:template>
  <!-- ================================================================== -->
  <!-- Parts of collation description                                     -->
  <!-- ================================================================== -->
  <xsl:template match="pricking | formula | gregoryRule | ruling | signatures | catchwords">
    <xsl:variable name="outName" as="xs:string">
      <xsl:choose>
        <xsl:when test="local-name() eq 'gregoryRule'">Gregory rule</xsl:when>
        <xsl:otherwise><xsl:value-of select="local-name()"/></xsl:otherwise>
      </xsl:choose>
    </xsl:variable>
    <span class="label"><xsl:value-of select="re:titleCase($outName) || ': '"/></span>
    <xsl:apply-templates/>
  </xsl:template>
  <!-- ================================================================== -->
  <!-- For most table rows just label and copy text                       -->
  <!-- ================================================================== -->
  <xsl:template match="*">
    <tr>
      <th><xsl:value-of select="re:titleCase(local-name())"/></th>
      <td><xsl:value-of select="."/></td>
    </tr>
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
    <tr>
      <th>Contents</th>
      <td id="msDescContents">
        <xsl:apply-templates select="msItemStruct"/>
      </td>
    </tr>
  </xsl:template>
  <xsl:template match="msItemStruct">
    <!-- ================================================================ -->
    <!-- Control order to put notes last                                  -->
    <!-- <locus> is processed as part of <title>                          -->
    <!-- ================================================================ -->
    <div class="text">
      <xsl:apply-templates select="title, sampleText, note, msItemStruct"/>
    </div>
  </xsl:template>
  <xsl:template match="locus">
    <xsl:text>(</xsl:text>
    <xsl:apply-templates/>
    <xsl:text>) </xsl:text>
  </xsl:template>
  <xsl:template match="title">
    <xsl:apply-templates select="preceding-sibling::locus"/>
    <xsl:apply-templates/>
    <br/>
  </xsl:template>
  <xsl:template match="sampleText">
    <div class="samples">
      <xsl:apply-templates/>
    </div>
  </xsl:template>
  <xsl:template match="head | rubric | incipit | sampleText/p | explicit | finalRubric">
    <xsl:variable name="outName" as="xs:string">
      <xsl:choose>
        <xsl:when test="self::p and parent::sampleText">Sample</xsl:when>
        <xsl:otherwise>
          <xsl:value-of select="local-name() ! re:titleCase(.)"/>
        </xsl:otherwise>
      </xsl:choose>
    </xsl:variable>
    <span class="{$outName}"><xsl:apply-templates/></span>
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
<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns:xs="http://www.w3.org/2001/XMLSchema"
  xmlns:math="http://www.w3.org/2005/xpath-functions/math"
  xpath-default-namespace="http://www.obdurodon.org/model" xmlns="http://www.w3.org/1999/xhtml"
  exclude-result-prefixes="#all" version="3.0">
  <xsl:template match="/">
    <!-- ================================================================ -->
    <!-- Root element                                                     -->
    <!-- ================================================================ -->
    <section>
      <img class="folio" title="Codex Zographensis" alt="[Codex Zographensis]"
        src="resources/images/zog.jpg"/>
      <section>
        <h2>About the project</h2>
        <p>The Repertorium of Old Bulgarian Literature and Letters was conceived as an archival
          repository capable of encoding and preserving in SGML (and, subsequently, XML) format
          archeographic, paleographic, codicological, textological, and literary-historical data
          concerning original and translated medieval texts represented in Balkan and other Slavic
          manuscripts. The files are intended to serve both as documentation (fulfilling the goals
          of traditional manuscript catalogues) and as direct input for computer-assisted
          philological research. The present site was designed and implemented by David J. Birnbaum,
          Andrej Bojadžiev, Anisava Miltenova, and Diljana Radoslavova.</p>
      </section>
      <section>
        <h2>Manuscripts</h2>
        <ul>
          <li>
            <a href="browse">Browse the collection</a>
          </li>
          <li>Search the collection <ul>
              <li><a href="search">By location, full text of title, etc.</a></li>
              <li><label for="searchTitlesFree">Case-insensitive substring search in text title </label>
                <input id="searchTitlesFree" type="text" size="25"
                  placeholder="press [enter] to search"/></li>
            </ul>
          </li>
          <li>Dendrogram overviews of the corpus (<a href="dendrogram?type=complete">complete</a>,
              <a href="dendrogram?type=ward">Ward’s</a>, and <a
              href="http://repertorium.obdurodon.org/dendrogram?type=colored">Ward’s with color
              coding</a> linkage)</li>
        </ul>
        <p>Manuscript descriptions from the related Slovo-ASO project can be found at <a
            href="http://aso.obdurodon.org">http://aso.obdurodon.org</a>.</p>
      </section>
      <section>
        <h2>Bibliography</h2>
        <p>Bibliographic references in the manuscript descriptions are maintained in a separate
          bibliographic database file, which can be browsed or searched. It is under development and
          does not yet contain all bibliographic references that appear in the full description
          files. The search field takes one or more complete words (it is not case-sensitive) and
          returns bibliographic records containing any of those words.</p>
        <ul>
          <li><a href="bibl">Browse</a> the bibliography (<a href="bibl"><img
                src="resources/images/xml.svg" alt="[XML]"/></a>)</li>
          <li>Search the bibliography <ul>
              <li><label>Any field <input id="input" type="text" size="25"
                    placeholder="press [enter] to search"/></label>
              </li>
              <li><label>Keyword <input id="keyword" type="text" size="25"
                    placeholder="press [enter] to search"/></label>
              </li>
              <li><label>Surname <input id="surname" type="text" size="25"
                    placeholder="press [enter] to search"/></label>
              </li>
              <li><label>Publication place<input id="pubPlace" type="text" size="25"
                    placeholder="press [enter] to search"/></label>
              </li>
            </ul></li>
        </ul>
      </section>
      <section>
        <h2>For developers</h2>
        <ul>
          <li>
            <a href="summary.php">Summary report about the corpus</a>
          </li>
          <li>
            <label for="searchFree">Case-insensitive substring search in full descriptions </label>
            <input id="searchFree" type="text" size="25" placeholder="press [enter] to search"/>
          </li>
          <li>Encoding guidelines and schema files<ul>
              <li><a href="resources/pdf/Bojadziev_Scripta_11.pdf">Guidelines to Repertorium
                  Initiative XML model for manuscript descriptions <img
                    src="resources/images/pdf.gif" alt="[pdf]"/></a> (Andrej Bojadžiev,
                  <cite>Scripta &amp; e-Scripta</cite> 10–11 (2012): 9–103)</li>
              <li><a href="encoding-policies-updates">Recent additions and changes to encoding
                  policies and guidelines</a></li>
              <li><a href="data/schema/tei_ms_repertorium.html">Schema documentation</a> (generated
                from ODD with TEI stylesheets)</li>
              <li>Schema: <a href="data/schema/tei_ms_repertorium.odd">TEI ODD</a>, <a
                  href="data/schema/tei_ms_repertorium.rnc">Relax NG compact syntax</a>, <a
                  href="data/schema/tei_ms_repertorium.rng">Relax NG XML syntax</a>
              </li>
              <li>Schematron: <a href="tei_ms_repertorium.sch">Schematron</a> and <a
                  href="data/schema/tei_ms_repertorium_supplement.sch">Schematron
                supplement</a></li>
            </ul></li>
          <li>Authority files<ul>
              <li><a href="">Text titles in Bulgarian, English, and Russian</a> (<a
                  href="data/aux/titles_cyrillic.xml"><img src="resources/images/xml.svg"
                    alt="[XML]"/></a>)</li>
              <li><a href="resources/pdf/hagio_ind.pdf">Standard English spelling of saints and
                  other hagiographic terms <img src="resources/images/pdf.gif" alt="[pdf]"
                /></a></li>
              <li><a href="">XML table of general and specific genres for use in
                    <code>&lt;msName&gt;</code></a>(<a href="data/aux/genres.xml"><img
                    src="resources/images/xml.svg" alt="[XML]"/></a>)</li>
            </ul></li>
          <li>Data dumps<ul class="three-column">
              <li><a href="http://obdurodon.org:8080/exist/rest/db/repertorium/xquery/additions.xql"
                  >Additions</a></li>
              <li><a
                  href="http://obdurodon.org:8080/exist/rest/db/repertorium/xquery/article-authors.xql"
                  >Authors (of texts, pulled from XML files)</a></li>
              <li><a href="list_of_authors_en.xhtml">Authors (of texts, authority file)</a></li>
              <li><a
                  href="http://obdurodon.org:8080/exist/rest/db/repertorium/xquery/authors_editors.xql"
                  >Authors and editors (modern)</a></li>
              <li><a href="http://obdurodon.org:8080/exist/rest/db/repertorium/xquery/bib_refs.xql"
                  >Bibliographic pointers</a></li>
              <li><a href="http://obdurodon.org:8080/exist/rest/db/repertorium/xquery/collation.xql"
                  >Collation</a></li>
              <li><a
                  href="http://obdurodon.org:8080/exist/rest/db/repertorium/xquery/mssByOrigDate.xql"
                  >Date</a></li>
              <li><a href="dendrograms/dendrogram-samples.xhtml">Dendrograms</a></li>
              <li><a
                  href="http://obdurodon.org:8080/exist/rest/db/repertorium/xquery/bad-identifiers.xql"
                  >Identifiers</a></li>
              <li><a
                  href="http://obdurodon.org:8080/exist/rest/db/repertorium/xquery/itemTitles.xql"
                  >Item titles</a></li>
              <li><a href="http://obdurodon.org:8080/exist/rest/db/repertorium/xquery/layout.xql"
                  >Layout</a></li>
              <li><a href="participants.php">Participants</a></li>
              <li><a href="http://obdurodon.org:8080/exist/rest/db/repertorium/xquery/scribe.xql"
                  >Scribes</a></li>
              <li><a href="http://repertorium.obdurodon.org/titleCheck.php">Titles (of
                articles)</a></li>
              <li><a
                  href="http://obdurodon.org:8080/exist/rest/db/repertorium/xquery/watermarks.xql"
                  >Watermarks</a></li>
            </ul>
          </li>
          <li>Finding errors<ul>
              <li><a
                  href="http://obdurodon.org:8080/exist/rest/db/repertorium/xquery/msDesc_consistency.xql"
                  >Inconsistencies or errors in <code>&lt;msName&gt;</code> elements or in
                    <code>&lt;physDesc&gt;</code></a></li>
              <li><a
                  href="http://obdurodon.org:8080/exist/rest/db/repertorium/xquery/missing-titles.xql"
                  >Text titles not in master list and files missing text titles</a></li>
              <li>Unicode issues: <a href="http://repertorium.obdurodon.org/pua-test.php">PUA</a> |
                  <a href="http://repertorium.obdurodon.org/superscript-test.php">superscript</a> |
                  <a href="http://repertorium.obdurodon.org/unicode-test.php">PUA and
                  superscript</a></li>
              <li><a
                  href="http://obdurodon.org:8080/exist/rest/db/repertorium/xquery/highlightLatin.xql"
                  >Latin characters in sample texts</a></li>
            </ul></li>
          <li>
            <!--                
                    <a
                    href="http://obdurodon.org:8080/exist/rest/db/repertorium/xquery/plectogram_physiologus.xql"
                    >Sample plectogram (Physiologus)</a>
                -->
            <a href="dev/test.xhtml">Sample plectogram (Physiologus)</a>
          </li>
          <li>External resources <ul>
              <li><a
                  href="http://kb.osu.edu/dspace/bitstream/handle/1811/51969/HIL_POLATA_17-18_GEURTS_ETAL.pdf?sequence=3"
                    ><q>Codicography and computer,</q>
                  <img src="resources/images/pdf.gif" alt="[pdf]"/></a> (Geurts, A. J., A. Gruijs,
                J. van Krieken, and W. R. Veder, <cite>Polata knigopisnaia</cite> 17–18 (December
                1987): 4–29)</li>
              <li><a href="http://repertorium.cl.bas.bg/descriptions/MSLIST.html"><cite>Cyrillic
                    manuscripts at the British Library: Electronic descriptions and digital
                    collection</cite></a> (authentication required)</li>
              <li><a href="http://www.tei-c.org/release/doc/tei-p5-doc/en/html/index.html">TEI
                  P5</a> Guidelines for electronic text encoding and interchange</li>
            </ul>
          </li>
        </ul>
      </section>
      <section>
        <h2>The Repertorium toolkit</h2>
        <p>The Repetorium Initiative uses the following tools and resources:</p>
        <ul class="two-column">
          <li><a href="http://eXist-db.org">eXist-db</a> XML database</li>
          <li><a href="http://www.oxygen.com">&lt;oXygen/&gt;</a> XML editor and IDE</li>
          <li><a href="https://sourceforge.net/projects/saxon/files/Saxon-HE/">Saxon</a> XSLT and
            XQuery processor</li>
          <li><a href="http://www.xmlsh.org/">xmlsh</a> command-line shell for XML</li>
          <li><a href="http://xmlstar.sourceforge.net/">XMLStarlet</a> command-line XML
            utilities</li>
          <li><a href="https://www.jetbrains.com/phpstorm/">PhpStorm</a> web technologies editor and
            IDE</li>
          <li><a href="https://www.continuum.io/downloads">Anaconda</a> Python 3 platform</li>
          <li><a href="https://www.jetbrains.com/pycharm/">PyCharm</a> Python editor and IDE</li>
          <li><a href="https://www.r-project.org/">R</a> project for statistical computing</li>
          <li><a href="https://www.rstudio.com/">RStudio</a> R IDE</li>
          <li><a href="http://kodeks.uni-bamberg.de/aksl/schrift/BukyVede.htm">Bukyvede</a> Slavic
            Cyrillic font from <a href="http://www.maccampus.de/">MacCampus</a> (production)</li>
          <li><a href="http://www.quivira-font.com/index.php">Quivera</a> broad-spectrum Unicode
            font (development)</li>
          <li><a href="https://fontforge.github.io/en-US/">FontForge</a> font editor</li>
          <li><a href="https://github.com/briangonzalez/fontprep">FontPrep</a> web-font
            generator</li>
          <li><a href="http://earthlingsoft.net/UnicodeChecker/index.html">UnicodeChecker</a> to
            explore and convert Unicode</li>
          <li><a href="http://r12a.github.io/apps/conversion/">Unicode code converter</a> online
            utility</li>
          <li><a href="http://r12a.github.io/uniview/">UniView</a> online utility</li>
          <li><a href=" https://cloudconvert.com">Cloudconvert</a> online <q>convert anything</q>
            utility</li>
        </ul>
      </section>
    </section>
  </xsl:template>
  <!--<xsl:template match="ms">
    <li>
      <a href="read?code={code}">
        <xsl:value-of select="concat(name, ' (', code, ')')"/>
      </a>
      <xsl:text> (</xsl:text>
      <a href="{string-join(('data', uri), '/')}">
        <img src="resources/images/xml.svg"/>
      </a>
      <xsl:text>)</xsl:text>
    </li>
  </xsl:template>-->
  <!--<xsl:template match="ms" mode="compare">
    <li>
      <label>
        <input value="{code}" type="checkbox" name="codes[]"/>
        <xsl:value-of select="concat('&#xa0;', name, '&#xa0;(', code, ')')"/>
      </label>
    </li>
  </xsl:template>-->
</xsl:stylesheet>

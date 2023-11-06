xquery version "3.1";

declare namespace m = "http://repertorium.obdurodon.org/model";

declare namespace output = "http://www.w3.org/2010/xslt-xquery-serialization";
declare option output:method "xml";
declare option output:indent "no";

<m:main>
  <m:header>
    <m:title>Repertorium</m:title>
    <m:image
      url="resources/images/zog.jpg"/>
  </m:header>
  <m:body>
    <m:section>
      <m:title>About the project</m:title>
      <m:p>The Repertorium of Old Bulgarian Literature and Letters was conceived as an archival
        repository capable of encoding and preserving in SGML (and, subsequently, XML) format
        archeographic, paleographic, codicological, textological, and literary-historical data
        concerning original and translated medieval texts represented in Balkan and other Slavic
        manuscripts. The files are intended to serve both as documentation (fulfilling the goals
        of traditional manuscript catalogues) and as direct input for computer-assisted philological
        research. The present site was designed and implemented by David J. Birnbaum, Andrej
        Bojadžiev, Anisava Miltenova, and Diljana Radoslavova.</m:p>
    </m:section>
    <m:section>
      <m:title>For users</m:title>
      <m:ul>
        <m:li><m:a
            url="search">Explore the manuscripts</m:a></m:li>
        <!--<m:li><m:a url="dendrogram">Dendrogram</m:a> overview of corpus</m:li>-->
        <m:li><m:a
            url="bib-search">Explore the bibliography</m:a></m:li>
      </m:ul>
    </m:section>
    <!--
    <m:section>
      <m:title>For developers</m:title>
      <m:ul>
        <m:li>
          <m:a
            url="summary">Summary report about the corpus</m:a>
        </m:li>
        <m:li><m:label
            for="searchFree">Case-insensitive substring search in full descriptions </m:label>
          <m:input
            id="searchFree"
            type="text"
            size="25"
            placeholder="press [enter] to search"
          /></m:li>
        <m:li>Encoding guidelines and schema files<m:ul>
            <m:li><m:a
                url="guidelines">Guidelines to Repertorium Initiative XML
                model for manuscript descriptions</m:a> (version 3.5, last modified 2023-10-18)</m:li>
            <m:li>Schema (version 3.5, 2023-10-18): <m:a
                url="resources/schemas/tei_ms_repertorium.odd">TEI
                ODD</m:a>, <m:a
                url="resources/schemas/tei_ms_repertorium.rnc">Relax NG compact syntax</m:a>,
              <m:a
                url="resources/schemas/tei_ms_repertorium.rng">Relax NG XML syntax</m:a>
            </m:li>
            <m:li>Schematron: <m:a
                url="resources/schemas/tei_ms_repertorium.sch">main Schematron file</m:a> (also
              used by Zograph project), <m:a
                url="resources/schemas/tei_ms_repertorium_supplement.sch"
              >Repertorium supplement</m:a></m:li>
          </m:ul></m:li>
        <m:li>Authority files<m:ul>
            <m:li><m:a
                url="titles">Text titles in Bulgarian, English, and
                Russian</m:a> (<m:a
                url="aux/titles.xml"
              ><m:svg
                  src="resources/images/xml.svg"
                  alt="[XML]"/></m:a>)</m:li>
            <m:li><m:a
                url="saints">Standard English spelling of saints and other
                hagiographic terms</m:a> (<m:a
                url="aux/saints.xml"
              ><m:svg
                  src="resources/images/xml.svg"
                  alt="[XML]"/></m:a>)</m:li>
            <m:li><m:a
                url="genres">General and specific genres for use in
                <m:code>&lt;msName&gt;</m:code></m:a> (<m:a
                url="aux/genres.xml"
              ><m:svg
                  src="resources/images/xml.svg"
                  alt="[XML]"/></m:a>)</m:li>
          </m:ul></m:li>
        <m:li>Data dumps<m:ul
            class="three-column">
            <m:li><m:a
                url="additions"
              >Additions</m:a></m:li>
            <m:li><m:a
                url="authors"
              >Authors (of texts, pulled from XML files)</m:a></m:li>
            <m:li><m:a
                url="authors-authority">Authors (of texts, authority
                file)</m:a></m:li>
            <m:li><m:a
                url="authors-modern"
              >Authors and editors (modern)</m:a></m:li>
            <m:li><m:a
                url="bib_refs"
              >Bibliographic pointers</m:a></m:li>
            <m:li><m:a
                url="collation"
              >Collation</m:a></m:li>
            <m:li><m:a
                url="mssByOrigDate"
              >Date</m:a></m:li>
            <m:li><m:a
                url="bad-identifiers"
              >Identifiers</m:a></m:li>
            <m:li><m:a
                url="itemTitles"
              >Item titles</m:a></m:li>
            <m:li><m:a
                url="layout"
              >Layout</m:a></m:li>
            <m:li><m:a
                url="participants">Participants</m:a></m:li>
            <m:li><m:a
                url="scribes"
              >Scribes</m:a></m:li>
            <m:li><m:a
                url="titles">Titles (of
                articles)</m:a></m:li>
            <m:li><m:a
                url="watermarks"
              >Watermarks</m:a></m:li>
          </m:ul>
        </m:li>
        <m:li>Finding errors<m:ul>
            <m:li><m:a
                url="msDesc_consistency.xql"
              >Inconsistencies or errors in <m:code>&lt;msName&gt;</m:code> elements or in
                <m:code>&lt;physDesc&gt;</m:code></m:a></m:li>
            <m:li><m:a
                url="missing-titles.xql"
              >Text titles not in master list and files missing text titles</m:a></m:li>
            <m:li>Unicode issues: <m:a
                url="pua-test.php"
              >PUA</m:a> | <m:a
                url="superscript-test.php"
              >superscript</m:a> | <m:a
                url="unicode-test.php">PUA and
                superscript</m:a></m:li>
            <m:li><m:a
                url="highlightLatin.xql"
              >Latin characters in sample texts</m:a></m:li>
          </m:ul></m:li>
        <m:li>External resources <m:ul>
            <m:li><m:a
                url="http://kb.osu.edu/dspace/bitstream/handle/1811/51969/HIL_POLATA_17-18_GEURTS_ETAL.pdf?sequence=3"
              ><m:q>Codicography and computer,</m:q>
                <m:img
                  src="resources/images/pdf.gif"
                  alt="[pdf]"
                /></m:a>
              (Geurts, A. J., A. Gruijs, J. van Krieken, and W. R. Veder, <m:cite>Polata
                knigopisnaia</m:cite> 17–18 (December 1987): 4–29)</m:li>
            <m:li><m:a url="http://repertorium.cl.bas.bg/descriptions/MSLIST.html"<m:cite>Cyrillic manuscripts at the British Library: Electronic
        descriptions and digital collection</m:cite></m:a> (authentication
      required)</m:li>
            <m:li><m:a
                url="http://www.tei-c.org/release/doc/tei-p5-doc/en/html/index.html">TEI
                P5</m:a> Guidelines for electronic text encoding and interchange</m:li>
          </m:ul>
        </m:li>
      </m:ul>
    </m:section>
    --><m:section>
      <m:title>The Repertorium toolkit</m:title>
      <m:p>The Repetorium Initiative uses the following tools and resources:</m:p>
      <m:ul
        class="two-column">
        <m:li><m:a
            url="http://eXist-db.org">eXist-db</m:a> XML document database and application server</m:li>
        <m:li><m:a
            url="https://github.com/eXist-db/xst">XST</m:a> command-line interface for eXist-db</m:li>
        <m:li><m:a
            url="http://www.oxygen.com">&lt;oXygen/&gt;</m:a> XML editor and IDE</m:li>
        <m:li><m:a
            url="https://code.visualstudio.com/">Visual Studio Code</m:a> programming editor and IDE</m:li>
        <m:li><m:a
            url="https://marketplace.visualstudio.com/items?itemName=eXist-db.existdb-vscode">existdb-vscode</m:a>
          Visual Studio Code extension for eXist-db</m:li>
        <m:li><m:a
            url="https://basex.org/">BaseX</m:a> XQuery database and devlopment environment</m:li>
        <m:li><m:a
            url="https://saxonica.com">Saxon</m:a> XSLT and XQuery processor</m:li>
        <m:li>Saxon <m:a
            url="https://www.saxonica.com/documentation12/index.html#!gizmo">Gizmo</m:a> utility
          for command-line interaction with XML documents</m:li>
        <m:li><m:a
            url="http://kodeks.uni-bamberg.de/aksl/schrift/BukyVede.htm">Bukyvede</m:a> Slavic
          Cyrillic font from <m:a
            url="http://www.maccampus.de/">MacCampus</m:a> (production)</m:li>
        <m:li><m:a
            url="https://gitlab.com/ralessi/oldstandard">Old Standard</m:a> broad-spectrum Unicode font (production)</m:li>
        <m:li><m:a
            url="http://www.quivira-font.com/index.php">Quivira</m:a> broad-spectrum Unicode
          font (development)</m:li>
        <m:li><m:a
            url="https://github.com/matthewgonzalez/fontplop">FontPlop</m:a> webfont converter</m:li>
        <m:li><m:a
            url="http://earthlingsoft.net/UnicodeChecker/index.html">UnicodeChecker</m:a> to
          explore Unicode</m:li>
        <m:li><m:a
            url="https://r12a.github.io/app-conversion/">Unicode code converter</m:a> online
          utility</m:li>
        <m:li><m:a
            url="http://r12a.github.io/uniview/">UniView</m:a> online utility</m:li>
        <m:li><m:a
            url=" https://cloudconvert.com">Cloudconvert</m:a> online <m:q>convert anything</m:q>
          utility</m:li>
      </m:ul>
    </m:section>
  </m:body>
</m:main>
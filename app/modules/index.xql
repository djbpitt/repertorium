xquery version "3.1";
declare default function namespace "http://www.w3.org/2005/xpath-functions";
declare default element namespace "http://www.w3.org/1999/xhtml";
declare namespace xi = "http://www.w3.org/2001/XInclude";
declare namespace output = "http://www.w3.org/2010/xslt-xquery-serialization";
declare option output:method "xml";
declare option output:media-type "application/xhtml+xml";
declare option output:omit-xml-declaration "no";
declare option output:indent "no";
declare option output:doctype-system "about:legacy-compat";
declare variable $title as xs:string := "Repertorium of Old Bulgarian Literature and Letters";
declare variable $exist:root as xs:string := request:get-parameter("exist:root", ());
declare variable $exist:prefix as xs:string := request:get-parameter("exist:prefix", ());
declare variable $exist:controller as xs:string := request:get-parameter("exist:controller", ());
(:declare variable $exist:path as xs:string := request:get-parameter("exist:path", ());:)
(:declare variable $exist:resource as xs:string := request:get-parameter("exist:resource", ());:)
(:declare variable $uri as xs:string := request:get-parameter("uri", ());:)
declare variable $context as xs:string := request:get-parameter("context", ());
declare variable $fqcontroller as xs:string := concat($context, $exist:prefix, $exist:controller, '/');

<html
    xmlns="http://www.w3.org/1999/xhtml">
    <xi:include
        href="{
                concat(
                $exist:root,
                $exist:controller,
                '/includes/header.xql?title=',
                encode-for-uri($title),
                '&amp;fqcontroller=',
                $fqcontroller
                )
            }"/>
    <body>
        <h1><a
                href="http://repertorium.obdurodon.org"
                class="logo">&lt;rep&gt;</a>
            <cite>Repertorium of Old Bulgarian Literature and Letters</cite></h1>
        <hr/>
        <p>
            <img
                class="folio"
                title="Codex Zographensis"
                alt="[Codex Zographensis]"
                src="{concat($fqcontroller, 'resources/images/zog.jpg')}"/>
        </p>
        <p
            class="boilerplate">
            <span><strong>Maintained by:</strong> David J. Birnbaum (<a
                    href="mailto:djbpitt@gmail.com">djbpitt@gmail.com</a>) <a
                    href="http://creativecommons.org/licenses/by-nc-sa/4.0/"
                    style="outline: none;">
                    <img
                        src="{concat($fqcontroller, 'resources/images/cc-by-nc-sa-80x15.png')}"
                        alt="[Creative Commons BY-NC-SA 4.0 International License]"
                        title="Creative Commons BY-NC-SA 4.0 International License"
                        style="height: 1em; vertical-align: text-bottom;"/>
                </a>
            </span>
            <span>
                <strong>Last modified:</strong>
                {current-dateTime()}</span>
        </p>
        <hr/>
        <h2>About the project</h2>
        <p>The Repertorium of Old Bulgarian Literature and Letters was conceived as an archival
            repository capable of encoding and preserving in SGML (and, subsequently, XML) format
            archeographic, paleographic, codicological, textological, and literary-historical data
            concerning original and translated medieval texts represented in Balkan and other Slavic
            manuscripts. The files are intended to serve both as documentation (fulfilling the goals
            of traditional manuscript catalogues) and as direct input for computer-assisted
            philological research. The present site was designed and implemented by David J.
            Birnbaum, Andrej Bojadžiev, Anisava Miltenova, and Diljana Radoslavova.</p>
        <h2>Manuscripts</h2>
        <ul>
            <li>
                <a
                    href="browse">Browse the collection</a>
            </li>
            <li>Search the collection <ul>
                    <li><a
                            href="search.php">By location, full text of title, etc.</a></li>
                    <li><label
                            for="searchTitlesFree">Case-insensitive substring search in text
                            title </label>
                        <input
                            id="searchTitlesFree"
                            type="text"
                            size="25"
                            placeholder="press [enter] to search"/></li>
                </ul>
            </li>
            <li>Dendrogram overviews of the corpus (<a
                    href="dendrogram-complete.xhtml"
                >complete</a>, <a
                    href="dendrogram-ward.xhtml">Ward’s</a>, and <a
                    href="http://repertorium.obdurodon.org/dendrogram-colored.xhtml">Ward’s with
                    color coding</a> linkage)</li>
        </ul>
        <p>Manuscript descriptions from the related Slovo-ASO project can be found at <a
                href="http://aso.obdurodon.org">http://aso.obdurodon.org</a>.</p>
        <h2>Bibliography</h2>
        <p>Bibliographic references in the manuscript descriptions are maintained in a separate
            bibliographic database file, which can be browsed or searched. It is under development
            and does not yet contain all bibliographic references that appear in the full
            description files. The search field takes one or more complete words (it is not
            case-sensitive) and returns bibliographic records containing any of those words.</p>
        <ul>
            <li><a
                    href="fullBibl.php">Browse</a> the bibliography (<a
                    href="{concat($fqcontroller, 'aux/bib.xml')}"><img
                        src="{concat($fqcontroller, 'resources/images/xml.gif')}"
                        alt="[XML]"/></a>)</li>
            <li>Search the bibliography (case-insensitive, full words only)<ul>
                    <li><label
                            for="input">Any field </label>
                        <input
                            id="input"
                            type="text"
                            size="25"
                            placeholder="press [enter] to search"/></li>
                    <li><label
                            for="keyword">Keyword </label>
                        <input
                            id="keyword"
                            type="text"
                            size="25"
                            placeholder="press [enter] to search"/></li>
                    <li><label
                            for="surname">Surname </label>
                        <input
                            id="surname"
                            type="text"
                            size="25"
                            placeholder="press [enter] to search"/></li>
                    <li><label
                            for="pubPlace">Publication place</label>
                        <input
                            id="pubPlace"
                            type="text"
                            size="25"
                            placeholder="press [enter] to search"/></li>
                </ul></li>
        </ul>
        <h2>For developers</h2>
        <ul>
            <li>
                <a
                    href="summary.php">Summary report about the corpus</a>
            </li>
            <li><label
                    for="searchFree">Case-insensitive substring search in full descriptions </label>
                <input
                    id="searchFree"
                    type="text"
                    size="25"
                    placeholder="press [enter] to search"
                /></li>
            <li>Encoding guidelines and schema files<ul>
                    <li><a
                            href="{concat($fqcontroller, 'resources/pdf/Bojadziev_Scripta_11.pdf')}">Guidelines to Repertorium Initiative XML
                            model for manuscript descriptions
                            <img
                                src="{concat($fqcontroller, 'resources/images/pdf.gif')}"
                                alt="[pdf]"
                            /></a> (Andrej Bojadžiev, <cite>Scripta &amp; e-Scripta</cite> 10–11
                        (2012): 9–103)</li>
                    <li><a
                            href="{concat($fqcontroller, 'encoding-policies-updates')}">Recent additions and changes to
                            encoding policies and guidelines</a></li>
                    <li>Schema: <a
                            href="tei_ms_repertorium.odd">TEI ODD</a>, <a
                            href="tei_ms_repertorium.rnc">Relax NG compact syntax</a>, <a
                            href="tei_ms_repertorium.rng">Relax NG XML syntax</a>, <a
                            href="tei_ms_repertorium.dtd">DTD</a>
                    </li>
                    <li>Schematron: <a
                            href="tei_ms_repertorium.sch">Schematron</a></li>
                </ul></li>
            <li>Authority files<ul>
                    <li><a
                            href="titles_cyrillic.xhtml">Text titles in Bulgarian, English, and
                            Russian</a> (<a
                            href="http://obdurodon.org:8080/exist/rest/db/repertorium/aux/titles_cyrillic.xml"
                        ><img
                                src="{concat($fqcontroller, 'resources/images/xml.gif')}"
                                alt="[XML]"/></a>)</li>
                    <li><a
                            href="{concat($fqcontroller, 'resources/pdf/hagio_ind.pdf')}">Standard English spelling of saints and other
                            hagiographic terms <img
                                src="{concat($fqcontroller, 'resources/images/pdf.gif')}"
                                alt="[pdf]"/></a></li>
                    <li><a
                            href="genres.xml">XML table of general and specific genres for use in
                            <code>&lt;msName&gt;</code></a></li>
                </ul></li>
            <li>Data dumps<ul
                    class="three-column">
                    <li><a
                            href="http://obdurodon.org:8080/exist/rest/db/repertorium/xquery/additions.xql"
                        >Additions</a></li>
                    <li><a
                            href="http://obdurodon.org:8080/exist/rest/db/repertorium/xquery/article-authors.xql"
                        >Authors (of texts, pulled from XML files)</a></li>
                    <li><a
                            href="list_of_authors_en.xhtml">Authors (of texts, authority
                            file)</a></li>
                    <li><a
                            href="http://obdurodon.org:8080/exist/rest/db/repertorium/xquery/authors_editors.xql"
                        >Authors and editors (modern)</a></li>
                    <li><a
                            href="http://obdurodon.org:8080/exist/rest/db/repertorium/xquery/bib_refs.xql"
                        >Bibliographic pointers</a></li>
                    <li><a
                            href="http://obdurodon.org:8080/exist/rest/db/repertorium/xquery/collation.xql"
                        >Collation</a></li>
                    <li><a
                            href="http://obdurodon.org:8080/exist/rest/db/repertorium/xquery/mssByOrigDate.xql"
                        >Date</a></li>
                    <li><a
                            href="dendrograms/dendrogram-samples.xhtml">Dendrograms</a></li>
                    <li><a
                            href="http://obdurodon.org:8080/exist/rest/db/repertorium/xquery/bad-identifiers.xql"
                        >Identifiers</a></li>
                    <li><a
                            href="http://obdurodon.org:8080/exist/rest/db/repertorium/xquery/itemTitles.xql"
                        >Item titles</a></li>
                    <li><a
                            href="http://obdurodon.org:8080/exist/rest/db/repertorium/xquery/layout.xql"
                        >Layout</a></li>
                    <li><a
                            href="participants.php">Participants</a></li>
                    <li><a
                            href="http://obdurodon.org:8080/exist/rest/db/repertorium/xquery/scribe.xql"
                        >Scribes</a></li>
                    <li><a
                            href="http://repertorium.obdurodon.org/titleCheck.php">Titles (of
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
                    <li>Unicode issues: <a
                            href="http://repertorium.obdurodon.org/pua-test.php"
                        >PUA</a> | <a
                            href="http://repertorium.obdurodon.org/superscript-test.php"
                        >superscript</a> | <a
                            href="http://repertorium.obdurodon.org/unicode-test.php">PUA and
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
                <a
                    href="dev/test.xhtml">Sample plectogram (Physiologus)</a>
            </li>
            <li>External resources <ul>
                    <li><a
                            href="http://kb.osu.edu/dspace/bitstream/handle/1811/51969/HIL_POLATA_17-18_GEURTS_ETAL.pdf?sequence=3"
                        ><q>Codicography and computer,</q>
                            <img
                                src="{concat($fqcontroller, 'resources/images/pdf.gif')}"
                                alt="[pdf]"
                            /></a>
                        (Geurts, A. J., A. Gruijs, J. van Krieken, and W. R. Veder, <cite>Polata
                            knigopisnaia</cite> 17–18 (December 1987): 4–29)</li>
                    <li><a
                            href="http://repertorium.cl.bas.bg/descriptions/MSLIST.html"
                        ><cite>Cyrillic manuscripts at the British Library: Electronic
                                descriptions and digital collection</cite></a> (authentication
                        required)</li>
                    <li><a
                            href="http://www.tei-c.org/release/doc/tei-p5-doc/en/html/index.html">TEI
                            P5</a> Guidelines for electronic text encoding and interchange</li>
                </ul>
            </li>
        </ul>
        <h2>The Repertorium toolkit</h2>
        <p>The Repetorium Initiative uses the following tools and resources:</p>
        <ul
            class="two-column">
            <li><a
                    href="http://eXist-db.org">eXist-db</a> XML database</li>
            <li><a
                    href="http://www.oxygen.com">&lt;oXygen/&gt;</a> XML editor and IDE</li>
            <li><a
                    href="https://sourceforge.net/projects/saxon/files/Saxon-HE/">Saxon</a> XSLT and
                XQuery processor</li>
            <li><a
                    href="http://www.xmlsh.org/">xmlsh</a> command-line shell for XML</li>
            <li><a
                    href="http://xmlstar.sourceforge.net/">XMLStarlet</a> command-line XML
                utilities</li>
            <li><a
                    href="https://www.jetbrains.com/phpstorm/">PhpStorm</a> web technologies editor
                and IDE</li>
            <li><a
                    href="https://www.continuum.io/downloads">Anaconda</a> Python 3 platform</li>
            <li><a
                    href="https://www.jetbrains.com/pycharm/">PyCharm</a> Python editor and IDE</li>
            <li><a
                    href="https://www.r-project.org/">R</a> project for statistical computing</li>
            <li><a
                    href="https://www.rstudio.com/">RStudio</a> R IDE</li>
            <li><a
                    href="http://kodeks.uni-bamberg.de/aksl/schrift/BukyVede.htm">Bukyvede</a> Slavic
                Cyrillic font from <a
                    href="http://www.maccampus.de/">MacCampus</a>
                (production)</li>
            <li><a
                    href="http://www.quivira-font.com/index.php">Quivera</a> broad-spectrum Unicode
                font (development)</li>
            <li><a
                    href="https://fontforge.github.io/en-US/">FontForge</a> font editor</li>
            <li><a
                    href="https://github.com/briangonzalez/fontprep">FontPrep</a> web-font
                generator</li>
            <li><a
                    href="http://earthlingsoft.net/UnicodeChecker/index.html">UnicodeChecker</a> to
                explore and convert Unicode</li>
            <li><a
                    href="http://r12a.github.io/apps/conversion/">Unicode code converter</a> online
                utility</li>
            <li><a
                    href="http://r12a.github.io/uniview/">UniView</a> online utility</li>
            <li><a
                    href=" https://cloudconvert.com">Cloudconvert</a> online <q>convert anything</q>
                utility</li>
        </ul>
    </body>
</html>
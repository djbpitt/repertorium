xquery version "3.1";
declare default function namespace "http://www.w3.org/2005/xpath-functions";
declare default element namespace "http://www.w3.org/1999/xhtml";
declare namespace xi="http://www.w3.org/2001/XInclude";
declare namespace output = "http://www.w3.org/2010/xslt-xquery-serialization";
declare option output:method "xml";
declare option output:media-type "application/xhtml+xml";
declare option output:omit-xml-declaration "no";
declare option output:indent "no";
declare variable $title as xs:string := "Repertorium of Old Bulgarian Literature and Letters";
declare variable $exist:root as xs:string := request:get-parameter("exist:root", ());
declare variable $exist:prefix as xs:string := request:get-parameter("exist:prefix", ());
declare variable $exist:controller as xs:string := request:get-parameter("exist:controller", ());
(:declare variable $exist:path as xs:string := request:get-parameter("exist:path", ());:)
(:declare variable $exist:resource as xs:string := request:get-parameter("exist:resource", ());:)
(:declare variable $uri as xs:string := request:get-parameter("uri", ());:)
declare variable $context as xs:string := request:get-parameter("context", ());
declare variable $fqcontroller as xs:string := concat($context, $exist:prefix, $exist:controller, '/');

<html xmlns="http://www.w3.org/1999/xhtml" xmlns:html="http://www.w3.org/1999/xhtml">
    <xi:include href="{concat(
        $exist:root, 
        $exist:controller, 
        '/includes/header.xql?title=', 
        encode-for-uri($title),
        '&amp;fqcontroller=',
        $fqcontroller
    )}"/>
  <body>
    <style type="text/css">
    section {{
         border-top: 1px gray solid;
         margin-top: 1em;
    }}</style>
    <xi:include href="{concat(
            $exist:root,
            $exist:controller,
            '/includes/boilerplate.xql?title=',
            encode-for-uri($title),
            '&amp;fqcontroller=',
            $fqcontroller
        )}"
    />
    <nav style="column-count: 3;">
      <ul>
        <li>
          <a href="#author_caps">Anonymous and unknown authors</a>
        </li>
        <li>
          <a href="#availability">Availability</a>
        </li>
        <li>
          <a href="#bibl">Bibliographic references</a>
        </li>
        <li>
          <a href="#binding"><code>&lt;binding&gt;</code> element</a>
        </li>
        <li>
          <a href="#certainty">Certainty</a>
        </li>
        <li>
          <a href="#colophon"><code>&lt;colophon&gt;</code> element</a>
        </li>
        <li><a href="#damage">Damaged or otherwise unclear text</a> (<code>&lt;gap&gt;</code>,
            <code>&lt;unclear&gt;</code>, <code>&lt;supplied&gt;</code>)</li>
        <li>
          <a href="#date">Dates</a>
        </li>
        <li>
          <a href="#default"><code>@default</code> attribute</a>
        </li>
        <li>
          <a href="#defective">Defective information</a>
        </li>
        <li>
          <a href="#dimensions"><code>&lt;dimensions&gt;</code> element</a>
        </li>
        <li>
          <a href="#folio_count">Folio count</a>
        </li>
        <li>
          <a href="#keywords"><code>&lt;keywords&gt;</code> element</a>
        </li>
        <li>
          <a href="#langUsage"><code>&lt;langUsage&gt;</code> element</a>
        </li>
        <li>
          <a href="#list"><code>&lt;list&gt;</code> element</a>
        </li>
        <li>
          <a href="#locus"><code>&lt;locus&gt;</code> element</a>
        </li>
        <li>
          <a href="#lost">Lost or destroyed manuscripts</a>
        </li>
        <li>
          <a href="#msName"><code>&lt;msName&gt;</code> element</a>
        </li>
        <li>
          <a href="#name"><code>&lt;name&gt;</code> element</a>
        </li>
        <li>
          <a href="#note"><code>&lt;note&gt;</code> element</a>
        </li>
        <li>
          <a href="#orthography"><code>&lt;orthography&gt;</code> element</a>
        </li>
        <li>
          <a href="#quire"><code>&lt;quire&gt;</code> element</a>
        </li>
        <li>
          <a href="#revisionDesc"><code>&lt;revisionDesc&gt;</code> element</a>
        </li>
        <li><a href="#romanization">Romanization</a> (transliteration of Cyrillic into Latin
          characters)</li>
        <li>
          <a href="#scribeDesc"><code>&lt;scribeDesc&gt;</code> element</a>
        </li>
        <li>
          <a href="#scribeLang"><code>&lt;scribeLang&gt;</code> element</a>
        </li>
        <li>
          <a href="#scriptDesc"><code>&lt;scriptDesc&gt;</code> element</a>
        </li>
        <li>
          <a href="#sourceDesc"><code>&lt;sourceDesc&gt;</code> element</a>
        </li>
        <li>
          <a href="#status"><code>@status</code> attribute</a>
        </li>
        <li>
          <a href="#superscript">Superscription</a>
        </li>
        <li>
          <a href="#supportDesc"><code>&lt;supportDesc&gt;</code> element</a>
        </li>
        <li>
          <a href="#teiHeaderType"><code>&lt;teiHeader&gt; @type</code> attribute</a>
        </li>
        <li>
          <a href="#textClass"><code>&lt;textClass&gt;</code> element</a>
        </li>
        <li>
          <a href="#book_types">Types of books</a>
        </li>
        <li>
          <a href="#watermarks">Watermarks</a>
        </li>
        <li>
          <a href="#saints">When should a holy person be labeled as a saint?</a>
        </li>
        <li>
          <a href="#writtenLines"><code>@writtenLines</code> attribute</a>
        </li>
      </ul>
    </nav>

    <section id="author_caps">
      <h3>Anonymous and unknown authors</h3>
      <p>In the case of anonymous authors, the value of the <code>msItemStruct/author</code> element
        must be <q>anonymous</q> (lower case, no punctuation). In the case of unknown authors of
        unknown antigraphs, we leave out the <code>&lt;author&gt;</code> element entirely; we don’t
        use the value <q>unknown</q>.</p>
    </section>

    <section id="availability">
      <h3>Availability</h3>
      <p>The <code>&lt;availability&gt;</code> element must have a <code>@status</code> attribute
        (typically with the value <q>free</q>), and it must not have a <code>@default</code>
        attribute.</p>
    </section>

    <section id="bibl">
      <h3>Bibliographic references</h3>
      <p>The TEI does not permit bibliographic references under <code>&lt;sourceDesc&gt;</code> to
        be expressed as a <code>&lt;ref&gt;</code> child of <code>&lt;sourceDesc&gt;</code>, and the
        same is true of bibliographic references inside the Repertorium <code>&lt;scribe&gt;</code>
        element. Instead, the <code>&lt;ref&gt;</code> must be wrapped in a
          <code>&lt;bibl&gt;</code> element. For example, instead of:</p>
      <pre class="bad_code">&lt;ref type="bibl" target="bib:Милтенова1986c"&gt;Милтенова 1986: 114-125&lt;/ref&gt;</pre>
      <p>the markup must read:</p>
      <pre>&lt;bibl&gt;&lt;ref target="bib:Милтенова1986c"&gt;Милтенова 1986: 114-125&lt;/ref&gt;&lt;/bibl&gt;</pre>
      <p>Note that when the <code>&lt;ref&gt;</code> is a child of <code>&lt;bibl&gt;</code>, we
        remove the <code>type="bibl"</code> attribute specification.</p>
    </section>

    <section id="binding">
      <h3><code>&lt;binding&gt;</code> element</h3>
      <p>The <code>@contemporary</code> attribute on the <code>&lt;binding&gt;</code> element takes
        one of the following three values: <q>true</q> (binding is contemporary with the
        manuscript), <q>false</q>, and <q>unknown</q> (typically when the date of either the
        manuscript or the binding cannot be discerned).</p>
    </section>

    <section id="certainty">
      <h3>Certainty</h3>
      <ul>
        <li>
          <p>If we are uncertain about a proposed scientific title for an
              <code>&lt;msItemStruct&gt;</code>, we include an empty <code>&lt;certainty&gt;</code>
            element after the title, just before the <code>&lt;/title&gt;</code> end tag, with a
              <code>@locus</code> equal to <q>value</q> (that is, we are uncertain about the content
            of the element) and a <code>@degree</code> attribute of <q>low</q> (that is, our degree
            of certainty is low). No other values may be used for these two attributes, and the
              <code>&lt;certainty&gt;</code> element must be an empty element that follows the title
            (i.e., it must not contain the title). For example:</p>
          <pre>&lt;title&gt;Разказ за пророк Самуил&lt;certainty locus="value" degree="low"/&gt;&lt;/title&gt;</pre>
        </li>
        <li>
          <p>More generally (that is, not only with respect to scientific titles), question marks
            are never to be used to represent low certainty. The only correct way to represent low
            certainty is by including <code>&lt;certainty locus="value" degree="low"&gt;</code>
            inside the uncertain element, e.g.:</p>
          <pre>&lt;name&gt;Nikifor from Rila Monastery&lt;certainty locus="value" degree="low"&gt;&lt;/certainty&gt;&lt;/name&gt;</pre>
        </li>
      </ul>
    </section>

    <section id="colophon">
      <h3><code>&lt;colophon&gt;</code> element</h3>
      <p>The TEI <code>&lt;colophon&gt;</code> element is phrase-like. Ours is div-like, which means
        that it contains one or more instances of <code>&lt;p&gt;</code>, optionally preceded by a
        single instance of <code>&lt;head&gt;</code>.</p>
    </section>

    <section id="damage">
      <h3>Damaged or otherwise unclear text</h3>
      <p>Damaged or otherwise unclear text in incipita, etc. in the early Repertorium files was
        sometimes represented incorrectly with pseudo-markup, by surrounding the text in square
        brackets, e.g., <q class="os">п[салти]рь</q> (where the text can be read, although with
        difficulty) or <q class="os">п[.....]рь</q> (where the encoder can discern or guess the
        number of letters, but cannot identify what they are intended to represent). The only
        correct way of encoding unclear or damaged text is with the <code>&lt;gap&gt;</code>,
          <code>&lt;unclear&gt;</code>, and <code>&lt;supplied&gt;</code> elements, as described
        below. As with parentheses and slashes, square brackets are never to be used in incipita and
        other transcribed text, whether to represent unclear or damaged text or for other purposes.
        The only raw text that may appear in these transcription elements is text that occurs
        literally in the manuscript, and all editorial annotation must be represented with
        markup.</p>
      <p>Text that is <em>physically missing or entirely illegible</em> must be encoded as an empty
          <code>&lt;gap&gt;</code> element, e.g.:</p>
      <pre style="line-height: 1.4em;">&lt;explicit defective="false"&gt;<span class="os">и сь риданїемь вѣлико</span>&lt;seg rend="sup"&gt;<span class="os">м</span>&lt;/seg&gt; <span class="os">ѕело 
г҃лаше</span> <span class="pre-highlight">&lt;gap/&gt;</span> <span class="os">ѣда умру видехь бо Іѡсифа че</span>&lt;seg rend="sup"&gt;<span class="os">д</span>&lt;/seg&gt;<span class="os">ѡ мое сладкое 
за Х҃а б҃а прославлень сь о҃це</span>&lt;seg rend="sup"&gt;<span class="os">м</span>&lt;/seg&gt; <span class="os">и с҃нѡ</span>&lt;seg rend="sup"&gt;<span class="os">м</span>&lt;/seg&gt; 
<span class="os">и стымъ д҃хѡ</span>&lt;seg rend="sup"&gt;<span class="os">м</span>&lt;/seg&gt;<span class="os"> н҃нѣ и пр</span>&lt;seg rend="sup"&gt;<span class="os">с</span>&lt;/seg&gt;<span class="os">но и 
вь вѣки вѣкѡ</span>&lt;seg rend="sup"&gt;<span class="os">м</span>&lt;/seg&gt; <span class="os">аминъ.</span>&lt;/explicit&gt;</pre>
      <p>If the extent of the gap can be identified, it may be represented with the
          <code>@quantity</code> and <code>@unit</code> attributes. e.g.:</p>
      <pre>&lt;gap quantity="6" unit="character"/&gt;</pre>
      <p>The <code>&lt;gap&gt;</code> element is also to be used where text has been <em>omitted
          deliberately</em> during transcription, and in that case the <code>&lt;gap&gt;</code>
        element must be accompanied by a <code>@resp</code> attribute that identifies the editor
        responsible for the deletion (<code>&lt;gap&gt;</code> elements without a <code>@resp</code>
        attribute are assumed to represent physical lacunae in the manuscript). The
          <code>@resp</code> attribute must be a pointer to an <code>@xml:id</code> attribute in our
          <a href="participants.php">participant list</a>, e.g.:</p>
      <pre style="line-height: 1.4em;">&lt;explicit&gt;<span class="os">и рѣче ѿ искони прѣбивае</span>&lt;seg rend="sup"&gt;<span class="os">т</span>&lt;/seg&gt; <span class="os">вь веки аминь. ꙗко 
 том</span>&lt;seg rend="sup"&gt;<span class="os">у</span>&lt;/seg&gt; <span class="os">по</span>&lt;seg rend="sup"&gt;<span class="os">д</span>&lt;/seg&gt;<span class="os">бае</span>&lt;seg rend="sup"&gt;<span class="os">т</span>&lt;/seg&gt;
<span class="pre-highlight">&lt;gap hand="#AA"/&gt;</span><span class="os"> амн҃</span>&lt;/explicit&gt;</pre>
      <p>Text that is <em>partially legible</em> must be represented by an
          <code>&lt;unclear&gt;</code> element, e.g.:</p>
      <pre style="line-height: 1.4em">&lt;incipit&gt;<span class="os">Ег</span>&lt;seg rend="sup"&gt;<span class="os">д</span>&lt;/seg&gt;<span class="os">а посла г҃ь ах҃рла Михаила кь Авраамоу г҃лю. прииди вь домь
Авраамобь. сь радостию и</span> &lt;sic&gt;<span class="os">лубовною</span>&lt;/sic&gt; <span class="os">приими д҃хь вьзлюбленнаго госта моего Авраама.
арх҃гль сьниде вь по</span>&lt;seg rend="sup"&gt;<span class="os">д</span>&lt;/seg&gt;<span class="os">горие. и сѣ</span>&lt;seg rend="sup"&gt;<span class="os">д</span>&lt;/seg&gt; <span class="os">ꙗко еднь
поутни</span>&lt;seg rend="sup"&gt;<span class="os">к</span>&lt;/seg&gt; <span class="os">иде</span>&lt;seg rend="sup"&gt;<span class="os">ж</span>&lt;/seg&gt; <span class="os">бѣше Авраамь оу</span>
<span class="pre-highlight">&lt;unclear&gt;<span class="os">в</span>&lt;/unclear&gt;</span><span class="os">ра</span>&lt;seg rend="sup"&gt;<span class="os">т</span>&lt;/seg&gt;<span class="os">и свои</span>&lt;seg rend="sup"&gt;<span class="os">х</span>&lt;/seg&gt;<span class="os">.</span>&lt;/incipit&gt;</pre>
      <!--<head>Повѣ<seg rend="sup">с</seg> ѡ сь<unclear>.....</unclear> проувѣ<seg rend="sup">д</seg>ни и  ѡ вьс<unclear>......</unclear> на и до съз<seg rend="sup">д</seg>аному Адам<unclear>...</unclear></head>-->
      <p>Where the editor supplies text to restore a missing or completely illegible reading, the
          <em>restored text</em> must be tagged as <code>&lt;supplied&gt;</code>, e.g.:</p>
      <pre style="line-height: 1.4em;">&lt;head&gt;<span class="os">О планитох</span>&lt;/head&gt;
&lt;incipit&gt;<span class="os">ззьвѣзди ѹбо</span>&lt;/incipit&gt;
&lt;explicit&gt;<span class="os">кь</span> <span class="pre-highlight">&lt;supplied&gt;<span class="os">з</span>&lt;/supplied&gt;</span><span class="os">апад</span>&lt;/explicit&gt;</pre>
    </section>

    <section id="date">
      <h3>Dates</h3>
      <p>Dates in the attributes <code>@when</code>, <code>@notBefore</code>, and
          <code>@notAfter</code> must be in ISO format. This means that dates that consist of just a
        year must be expressed with exactly four digits (using a leading zero for years before
        1000). Year plus month must be formatted as <code>YYYY-MM</code>. Month plus date (for
        example, in the church calendar) require two leading hyphens, i.e., <code>--MM-DD</code>.
        For more information see <a href="https://en.wikipedia.org/wiki/ISO_8601"
          >https://en.wikipedia.org/wiki/ISO_8601</a>.</p>
      <p>References to dates in the church calendar should be encoded as <code>&lt;date
          type="churchCal"&gt;</code>, and the <code xmlns="">&lt;date></code> element should be a
        child of <code xmlns="">&lt;msItemStruct></code> (that is, not wrapped in a <code xmlns=""
          >&lt;note></code> element). The following example is from MP408G.xml:</p>
      <pre>&lt;msItemStruct xml:id="ACD3" type="translation"&gt;
    &lt;locus n="3"&gt;39r-58r&lt;/locus&gt;
    &lt;title xml:lang="bg"&gt;Житие на св. Текла&lt;/title&gt;
    <span class="pre-highlight">&lt;date type="churchCal" when="--09-24"&gt;24. September&lt;/date&gt;</span>
    &lt;filiation type="protograph"&gt;Bulgarian&lt;/filiation&gt;
    &lt;filiation type="antigraph"&gt;Middle Bulgarian&lt;/filiation&gt;
    &lt;re:sampleText xml:lang="cu"&gt;
        &lt;explicit&gt;<span class="os">И погребоше тѣло ѥе вь, бь нѥмже паметь творимь м҃сца Септембрѣ кд҃ д҃нь</span>&lt;/explicit&gt;
    &lt;/re:sampleText&gt;
&lt;/msItemStruct&gt;</pre>
    </section>

    <section id="default">
      <h3><code>@default</code> attribute</h3>
      <p>The <code>@default</code> attribute is not to be used (e.g., on the <a href="#availability"
            ><code>&lt;availability&gt;</code></a>, <a href="#bibl"><code>&lt;bibl&gt;</code></a>,
          <a href="#langUsage"><code>&lt;langUsage&gt;</code></a>, <a href="#sourceDesc"
            ><code>&lt;sourceDesc&gt;</code></a>, and <a href="#textClass"
            ><code>&lt;textClass&gt;</code></a> elements).</p>
    </section>
    <section id="defective">
      <h3>Defective information</h3>
      <p>Textual excerpts such as incipita and explicita are to be tagged as <code>&lt;incipit
          defective="true"&gt;</code> only when the value is <q>true</q>. The
          <code>@defective</code> attribute is never to appear with the value <q>false</q>; in those
        situations it must be omitted entirely from the markup.</p>
    </section>
    <section id="dimensions">
      <h3><code>&lt;dimensions&gt;</code> element</h3>
      <p>The folios to which a <code>&lt;dimensions&gt;</code> specification applies should be
        specified with the <code>@extent</code> attribute. Using the <code>@scope</code> attribute
        is an error.</p>
    </section>

    <section id="folio_count">
      <h3>Folio count</h3>
      <p>The folio count must be given inside <code>supportDesc/extent/measure</code>, and the
          <code>&lt;measure&gt;</code> element itself must contain nothing but digits (Arabic and
        Roman) and plus signs, e.g., <q>123</q>, <q>iii+25+ii</q>. No plain text is ever to go
        inside the <code>&lt;measure&gt;</code> element, and the number of folios or bifolios must
        be wrapped in <code>&lt;measure&gt;</code> and must not appear as plain text inside the
          <code>&lt;extent&gt;</code> element. The <code>&lt;measure&gt;</code> element must also
        contain a <code>@unit</code> attribute, the value of which typically is <q>folia</q> (at
        present <q>bifolio</q> also occurs once in the corpus). For example:</p>
      <pre>&lt;measure unit="folia"&gt;II+243+III&lt;/measure&gt;</pre>
      <p>See also <a href="#locus"><code>&lt;locus&gt;</code></a>.</p>
    </section>

    <section id="keywords">
      <h3><code>&lt;keywords&gt;</code> element</h3>
      <p>The <code>&lt;keywords&gt;</code> element must include a <code>@scheme</code> attribute
        with the value <q>Repertorium</q>, e.g.:</p>
      <pre>&lt;keywords scheme="Repertorium"&gt;</pre>
    </section>
    <section id="langUsage">
      <h3><code>&lt;langUsage&gt;</code> element</h3>
      <p>The <code>&lt;langUsage&gt;</code> element must not have a <code>@default</code>
        attribute.</p>
    </section>

    <section id="list">
      <h3><code>&lt;list&gt;</code> element</h3>
      <p>A simple list must be encoded just as <code>&lt;list&gt;</code>, with no <code>@type</code>
        attribute. That is, instead of:</p>
      <pre class="bad_code">&lt;list type="simple"&gt;</pre>
      <p>the markup must read just:</p>
      <pre>&lt;list&gt;</pre>
    </section>

    <section id="locus">
      <h3><code>&lt;locus&gt;</code> element</h3>
      <p>Locations within a manuscript must be tagged with the <code>&lt;locus&gt;</code> element
        without attributes. Because TEI P5 does not support a <code>@unit</code> attribute on the
          <code>&lt;locus&gt;</code> element, the unit (<q>f.</q>, <q>ff.</q>, <q>p.</q>, or
          <q>pp.</q>, followed by a period and a space) must be included inside the element content,
        e.g.,</p>
      <pre>&lt;locus&gt;ff. 1r–24r&lt;/locus&gt;</pre>
      <p>Note that in the case of folios, the side (lower-case <q>r</q> or <q>v</q>) or column
        (lower-case <q>a</q>, <q>b</q>, <q>c</q>, or <q>d</q>) must be given with the number. Where
        there is a range, the separator must be an en-dash (–), and not a hyphen (-).</p>
    </section>

    <section id="lost">
      <h3>Lost or destroyed manuscripts</h3>
      <p>Manuscripts that have been lost or destroyed must normally contain the same full
          <code>&lt;msIdentifier&gt;</code> elements as extant manuscripts, including
          <code>&lt;country&gt;</code>, <code>&lt;settlement&gt;</code>,
          <code>&lt;repository&gt;</code>, and <code>&lt;idno&gt;</code>. The information that a
        manuscript has been lost may be encoded outside the <code>&lt;msIdentifier&gt;</code>
        element in two places that are part of the standard TEI manuscript description module, as
        follows:</p>
      <ul>
        <li>
          <p><code>msDesc/additional/adminInfo/availability/p</code> This element is required for
            lost or destroyed manuscripts. When reports are generated that include information drawn
            from the <code>&lt;msIdentifier&gt;</code> section of the description, the contents of
            this <code>&lt;availability&gt;</code> element will be rendered in parentheses next to
            that information. The encoding must therefore contain the text exactly as it should
            appear in the final-form output. For lost manuscripts, we recommend the string
              <q>lost</q> (lower-case, no punctuation, no spaces), but encoders may use any string
            they consider appropriate. For example, in the case of the Apocryphal Miscellany NB
            Belgrade, 305, which was destroyed in the 1941 German bombing of Belgrade, this entry
            would read:</p>
          <pre>&lt;availability&gt;
    &lt;p&gt;lost&lt;/p&gt;
&lt;/availability&gt;</pre>
          <p>When generating a list of manuscripts in the corpus, this entry will be rendered as
              <q>Serbia, Belgrade, National Library, 305 (lost)</q>.</p>
        </li>
        <li>
          <p><code>msDesc/history/summary</code> This element is optional, and it contains a longer
            prose description of the circumstances surrounding the loss or destruction of the
            manuscript. The contents of this element will be rendered as a paragraph when a full
            manuscript description is generated for output, and encoders must therefore enter the
            text as they would like it to appear. In the case of the Apocryphal Miscellany NB
            Belgrade, 305, mentioned above, this entry would read:</p>
          <pre>&lt;history&gt;
    &lt;summary&gt;Lost in the destruction of the National Library of Serbia during the German bombing in April 1941.&lt;/summary&gt;
&lt;/history&gt;</pre>
          <p>When generating a reading view of this manuscript description, the contents of the
            history element will be rendered as <q>Lost in the destruction of the National Library
              of Serbia during the German bombing in April 1941.</q></p>
        </li>
      </ul>
    </section>

    <section id="msName">
      <h3><code>&lt;msName&gt;</code> element</h3>
      <p>The <code>&lt;msName&gt;</code> element records a name by which a manuscript is known or
        the genre to which it belongs. It must include an <code>@xml:lang</code> attribute plus a
          <code>@type</code> attribute with one of the following three values:</p>
      <ul>
        <li><code>&lt;msName type="general"&gt;</code> identifies the genre of the manuscript in a
          general way, e.g., <q>miscellany</q>. This is the only <code>&lt;msName&gt;</code> that is
          required for all manuscript description files, and it must be given only in English. The
          Bulgarian and Russian names will be retrieved later from a list, which means that if the
          name isn’t in the list, it will need to be added (notify David). General names do not have
          subtypes.</li>
        <li><code>&lt;msName type="specific"&gt;</code>identifies the genre of the manuscript in a
          specific way, e.g., <q>apocryphal miscellany</q>. This name is optional, but if it is
          present, it must be given only in English, and is subject to the same look-up treatment as
          general names, described above. Specific names do not have subtypes.</li>
        <li><code>&lt;msName type="individual"&gt;</code> identifies the individual name(s) by which
          the manuscript is known, e.g., <q>Loveč miscellany</q>. This name is optional and
          repeatable, but if it is given, it must be given in all three languages. To encode a
          former individual manuscript name, add the <code>@subtype</code> attribute with the value
            <q>old</q>; <q>old</q> is the only legal value of <code>@subtype</code> here, and in the
          absence of a <code>@subtype</code> attribute the name is assumed to be current.</li>
      </ul>
      <p>The only words that are to be capitalized in names are those that are always capitalized in
        their respective languages, e.g., proper nouns in all three languages and proper adjectives
        in English. Do not capitalize the first word of a name unless it must always be capitalized
        in the language of the element.</p>
      <h4>Example of the use of <code>&lt;msName&gt;</code> (from <a
          href="rawFile.php?filename=AA36NBB.xml">AA36NBB</a>):</h4>
      <pre>&lt;msName type="general" xml:lang="en"&gt;miscellany&lt;/msName&gt;
&lt;msName type="specific" xml:lang="en"&gt;apocryphal miscellany&lt;/msName&gt;      
&lt;msName type="individual" xml:lang="bg"&gt;Призренски апокрифен сборник&lt;/msName&gt;
&lt;msName type="individual" xml:lang="en"&gt;Prizren apocryphal miscellany&lt;/msName&gt;
&lt;msName type="individual" xml:lang="ru"&gt;Призренский апокрифический сборник&lt;/msName&gt;</pre>
      <p>In rendered lists of manuscript names and in codicological descriptions on the site, a
        manuscript will be represented by its individual names, if any exist. If not, a specific
        name will be used. If that doesn’t exist, a generic name will be used. At that time
        appropriate capitalization will be introduced automatically.</p>
    </section>

    <section id="name">
      <h3><code>&lt;name&gt;</code> element</h3>
      <p>The <code>&lt;name&gt;</code> must never have a <code>@full</code> attribute. That is,
        instead of:</p>
      <pre class="bad_code">&lt;respStmt&gt;&lt;name full="yes"&gt;</pre>
      <p>the markup should read:</p>
      <pre>&lt;respStmt&gt;&lt;name&gt;</pre>
    </section>

    <section id="note">
      <h3><code>&lt;note&gt;</code> element</h3>
      <p>The <code>&lt;note&gt;</code> element must not have a <code>@place</code> attribute. That
        is, instead of:</p>
      <pre class="bad_code">&lt;note place="inline"&gt;</pre>
      <p>the markup should read:</p>
      <pre>&lt;note&gt;</pre>
    </section>

    <section id="orthography">
      <h3><code>&lt;orthography&gt;</code> element</h3>
      <p>In some earlier version of the Repertorium files, the <code>&lt;orthography&gt;</code>
        element contained plain text or mixed content. This type of content requires a
          <code>&lt;p&gt;</code> wrapper. As an alternative to paragraphs or paragraph-like
        elements, the <code>&lt;orthography&gt;</code> element may instead contain an optional
          <code>&lt;summary&gt;</code> followed by one or more <code>&lt;orthNote&gt;</code>
        elements.</p>
    </section>

    <section id="quire">
      <h3><code>&lt;quire&gt;</code> element</h3>
      <p>The <code>&lt;quire&gt;</code> element has an optional <code>@status</code> attribute, the
        legal values of which are <q>original</q>, <q>added</q>, and <q>missing</q>.</p>
    </section>

    <section id="revisionDesc">
      <h3><code>&lt;revisionDesc&gt;</code> element</h3>
      <p>The <code>&lt;revisionDesc&gt;</code> element must not have a <code>@status</code>
        attribute. That is, instead of:</p>
      <pre class="bad_code">&lt;revisionDesc status="draft"&gt;</pre>
      <p>the markup must read just:</p>
      <pre>&lt;revisionDesc&gt;</pre>
    </section>

    <section id="romanization">
      <h3>Romanization</h3>
      <p>Romanization (the transliteration of Cyrillic into Latin characters) follows the
          <q>international scientific</q> system, documented at <a href="transliteration.xhtml"
          >http://repertorium.obdurodon.org/transliteration.xhtml</a> (mirrored from <a
          href="http://en.wikipedia.org/wiki/Scientific_transliteration_of_Cyrillic"
          >http://en.wikipedia.org/wiki/Scientific_transliteration_of_Cyrillic</a>).</p>
    </section>

    <section id="scribeDesc">
      <h3><code>&lt;scribeDesc&gt;</code> element</h3>
      <ul>
        <li>If there is more than one scribe, the <code>&lt;scribe&gt;</code> element must have an
            <code>@n</code> attribute that assigns a sequential number to the scribe, so that, for
          example, the first scribe would be <code>&lt;scribe n="1"&gt;</code>. Scribes must be
          numbered with consecutive Arabic numerals (not letters), and if there is only one scribe,
          the <code>@n</code> attribute must be omitted.</li>
        <li>When one and the same scribe wrote in several places in the manuscript, use a single
            <code>&lt;scribe&gt;</code> element that contains a <code>&lt;locusGrp&gt;</code> with
          several <code>&lt;locus&gt;</code> child elements.</li>
        <li>If the name of the scribe is unknown, write
            <code>&lt;name&gt;anonymous&lt;/name&gt;</code> (lower case). Do not write
            <q>unknown</q> or anything else other than <q>anonymous</q> as the value of the
            <code>&lt;name&gt;</code> element.</li>
      </ul>
    </section>

    <section id="scribeLang">
      <h3><code>&lt;scribeLang&gt;</code> element</h3>
      <ul>
        <li>
          <p>Prose observations about orthography must be enclosed in an
              <code>&lt;orthography&gt;</code> child of the <code>&lt;scribeLang&gt;</code> element,
            e.g.:</p>
          <pre>&lt;scribeLang&gt;
    &lt;orthography&gt;Here goes some information&lt;/orthography&gt;
&lt;/scribeLang&gt;</pre>
        </li>
        <li>
          <p>Nonsystematic prose observations must be enclosed in a <code>&lt;p&gt;</code> element,
            e.g.:</p>
          <pre>&lt;scribeLang&gt;
    &lt;p&gt;Here goes some information&lt;/p&gt;
&lt;/scribeLang&gt;</pre>
        </li>
        <li>Systematic information must be represented by <code>&lt;orthNote&gt;</code> child
          elements of the <code>&lt;orthography&gt;</code> element. See <a
            href="http://repertorium.obdurodon.org/rawFile.php?filename=MDManoil.xml">MDManoil</a>
          for an example.</li>
      </ul>
    </section>

    <section id="scriptDesc">
      <h3><code>&lt;scriptDesc&gt;</code> element</h3>
      <ul>
        <li>The <code>&lt;scriptDesc&gt;</code> element has an obligatory <code>@script</code>
          attribute with two possible values, <q>cyrs</q> for Cyrillic and <q>glag</q> for
          Glagolitic.</li>
        <li>An optional <code>@type</code> attribute can specify the subtype of the script, e.g.,
            <q>semiuncial</q>.</li>
        <li>
          <p>If addition information is available about the writing, it must be specified in a
              <code>&lt;p&gt;</code> child element of <code>&lt;scriptDesc&gt;</code>, e.g.:</p>
          <pre>&lt;scriptDesc script="cyrs" type="semiuncial"&gt;
    &lt;p&gt;Semiuncial with with cursives elements.&lt;/p&gt;
&lt;/scriptDesc&gt;</pre>
          <p>Do not use a <code>&lt;p&gt;</code> child element for simple descriptions that do not
            contain additional information. For example, do not write:</p>
          <pre class="bad_code">&lt;scriptDesc script="cyrs" type="semiuncial"&gt;
    &lt;p&gt;Semiuncial&gt;
&lt;/scriptDesc&gt;</pre>
        </li>
        <li>
          <p>The <code>&lt;respStmt&gt;</code> element and its children are to be used inside the
              <code>&lt;scribeDesc&gt;</code> element only in situations where the responsibility
            belongs to the encoder (compiler) of the electronic description. For example:</p>
          <pre>&lt;respStmt&gt;
    &lt;name ref="#AM"&gt;A. Miltenova&lt;/name&gt;
    &lt;resp&gt;de visu&lt;/resp&gt;
&lt;/respStmt&gt;</pre>
          <p>(Note that the name is not inverted.) In situations where the identification or
            description comes from a publication, though, instead of <code>&lt;respStmt&gt;</code>
            we must use a note and bibliographic pointer, e.g., instead of:</p>
          <pre class="bad_code">&lt;respStmt&gt;
    &lt;name full="yes"&gt;Райков, Б., Хр. Кодов, Б. Христова&lt;/name&gt;
    &lt;resp&gt;Славянски ръкописи в Рилския манастир&lt;/resp&gt;
&lt;/respStmt&gt;</pre>
          <p>we should write:</p>
          <pre>&lt;note&gt;
      &lt;ref type="bibl" target="bib:Райков1986"&gt;Райков, Кодов, Христова 1986: 69–71, № 32&lt;/ref&gt;
  &lt;/note&gt;</pre>
        </li>
        <li>Usage examples within <code>&lt;scriptDesc&gt;</code> must be tagged as
            <code>&lt;foreign xml:lang="cu"&gt;</code>. The elements <code>&lt;w&gt;</code>,
            <code>&lt;c&gt;</code>, <code>&lt;seg&gt;</code> are not to be used here.</li>
      </ul>
    </section>

    <section id="sourceDesc">
      <h3>
        <code>&lt;sourceDesc&gt; element</code>
      </h3>
      <p>The <code>&lt;sourceDesc&gt;</code> element must not have a <code>@default</code>
        attribute.</p>
    </section>

    <section id="status">
      <h3><code>@status</code> attribute</h3>
      <p>The <code>@status</code> attribute is to be used only when the status is something other
        than <q>draft</q>. That is</p>
      <pre><code>&lt;availability status="free"&gt;</code></pre>
      <p>is okay, but no element can never have a <code>@status</code> attribute with the value
          <q>draft</q>.</p>
    </section>

    <section id="superscript">
      <h3>Superscription</h3>
      <p>Superscription in the early Repertorium files was encoded in at least four different ways,
        two using markup (the <code>&lt;c&gt;</code> and <code>&lt;seg&gt;</code> elements) and two
        using pseudo-markup (surrounding the superscript character with slashes or parentheses,
        e.g., <q class="os">е/с/</q> or <q class="os">е(с)</q> for <span class="os"
          >е<sup>с</sup></span>. The only correct way of encoding superscription is with
          <code>&lt;seg rend="sup"&gt;</code>, e.g., as <q><code><span class="os">е</span>&lt;seg
              rend="sup"&gt;<span class="os">с</span>&lt;/seg&gt;</code></q>. That is, use
          <code>&lt;seg&gt;</code>, and not <code>&lt;c&gt;</code>, to mark up a superscript
        character. Parentheses and slashes are never to be used in incipita and other transcribed
        text, whether to represent superscription or for other purposes. The only raw text that can
        appear in these transcription elements is text that occurs literally in the manuscript, and
        all editorial annotation must be represented with markup.</p>
    </section>

    <section id="supportDesc">
      <h3><code>&lt;supportDesc&gt;</code> element</h3>
      <p>The value of the <code>@material</code> attribute on the <code>&lt;supportDesc&gt;</code>
        element cannot contain white space. Manuscripts written on a combination of parchment and
        paper should specify this value as <q>mixed</q> (not as <q>parchment and paper</q>).</p>
    </section>

    <section id="teiHeaderType">
      <h3><code>&lt;teiHeader&gt; @type</code> attribute</h3>
      <p>The <code>&lt;teiHeader&gt;</code> must not have a <code>@type</code> attribute. (In
        earlier files had a <code>@type</code> atttribute with values like <q>text</q> and
          <q>sbornik</q>, and those have now been removed.)</p>
    </section>
    <section id="textClass">
      <h3><code>&lt;textClass&gt;</code> element</h3>
      <p>The <code>&lt;textClass&gt;</code> element must not have a <code>@default</code>
        attribute.</p>
    </section>
    <section id="book_types">
      <h3>Types of books</h3>
      <p>Use the terms in bold below to represent the types of books described beside them. We
        follow the usage of the <cite>Oxford dictionary of Byzantium</cite> where possible, which,
        among other things, means that we favor Greek spellings (e.g., Praxapostol<em>os</em>) over
        Latinized ones (Praxapostol<em>us</em>).</p>
      <ul>
        <li><strong>Gospel book</strong> instead of <em>tetraevangelion</em></li>
        <li><strong>Lectionary</strong> instead of <em>aprakos gospel</em></li>
        <li>
          <strong>Praxapostolos</strong>
          <em>instead of lectionary Acts and Epistles</em>
        </li>
      </ul>
    </section>
    <section id="watermarks">
      <h3>Watermarks</h3>
      <p>Information about watermarks must be written inside the element
          <code>&lt;watermark&gt;</code> with the following structure:</p>
      <ol>
        <li>If there are no watermarks in the manuscript, the contents of the
            <code>&lt;watermark&gt;</code> element must be the bare text <q>None</q>.</li>
        <li>If there are watermarks in the manuscript, there must be exactly
            <code>&lt;motif&gt;</code> element as the first child of <code>&lt;watermark&gt;</code>
          (except when it is preceded by <code>&lt;locus&gt;</code>; see below). We do not
          distinguish among basic, supplemental, and additional parts of the
            <code>&lt;motif&gt;</code>. The <code>&lt;motif&gt;</code> element is the only required
          child of <code>&lt;watermark&gt;</code>.</li>
        <li>If there is a <code>&lt;countermark&gt;</code> element, it must be the first following
          sibling of <code>&lt;motif&gt;</code>. A <code>&lt;countermark&gt;</code> element must
          have a single <code>&lt;motif&gt;</code> child element; <code>&lt;countermark&gt;</code>
          is not allowed to contain plain text.</li>
        <li>The third part of the watermark information (but see the discussion of <q>similar to</q>
          below) is a pointer to a watermark album. The reference itself is encoded as a
            <code>&lt;ref&gt;</code> element with a <code>@target</code> attribute, the value of
          which is a bibliographic pointer in the form <q>FamilynameYear</q>. The
            <code>&lt;ref&gt;</code> element has two obligatory children: <code>&lt;num&gt;</code>
          (the number of an tracing in the album) and <code>&lt;date&gt;</code>, containing the year
          or range of years recorded in the album for that tracing. In the case of multiple examples
          of the same motif from the same album, there may be more than one <code>&lt;num&gt;</code>
          and <code>&lt;date&gt;</code> pair, but each <code>&lt;num&gt;</code> must have its own
            <code>&lt;date&gt;</code>, even when the date is the same as the date of the preceding
          item.</li>
      </ol>
      <p>Names of motifs are to be given in English according to the usage preferred in the <a
          href="http://www.memoryofpaper.eu/products/watermark_terms_en.pdf">Memory of paper</a>
        project.</p>
      <p>For example:</p>
      <pre>&lt;watermark&gt;
  &lt;motif&gt;Anchor in circle with star&lt;/motif&gt;
  &lt;countermark&gt;
    &lt;motif&gt;AB&lt;/motif&gt;
  &lt;/countermark&gt;
  &lt;ref target="bib:Moshin1973"&gt;
    &lt;num&gt;1393&lt;/num&gt;
    &lt;date&gt;1560/75&lt;/date&gt;
  &lt;/ref&gt;
&lt;/watermark&gt;</pre>
      <p>This will be rendered on line as:</p>
      <p class="pre-colored">Anchor in circle with star and AB countermark. Moshin 1973: 1393
        (1560/75).</p>
      <p>If there is more than one watermark in the manuscript and the description distinguishes
        them by location, the element <code>&lt;locus&gt;</code> is used as the first child of
          <code>&lt;watermark&gt;</code>, before <code>&lt;motif&gt;</code>. For example:</p>
      <pre>&lt;watermark&gt;
  &lt;locus&gt;ff. 132-140&lt;/locus&gt;
  &lt;motif&gt;Two circles with a cross&lt;/motif&gt;
  &lt;ref target="bib:Moshin1973"&gt;
    &lt;num&gt;2025&lt;/num&gt;
    &lt;date&gt;1336&lt;/date&gt;
  &lt;/ref&gt;
&lt;/watermark&gt;</pre>
      <p>If the tracing is similar to, but not the same equal as, the watermark being described, a
          <code>&lt;term&gt;</code> element with the textual content <q>similar to</q> to appear
        before the <code>&lt;ref&gt;</code> element. For example:</p>
      <pre>&lt;watermark&gt;
  &lt;locus&gt;ff. 50, 256&lt;/locus&gt;
  &lt;motif&gt;axe&lt;/motif&gt;
  &lt;term&gt;similar to&lt;/term&gt; 
  &lt;ref target="bib:Piekosinski1893"&gt;
    &lt;num&gt;413&lt;/num&gt;
    &lt;date&gt;1395&lt;/date&gt;
  &lt;/ref&gt;
&lt;/watermark&gt;</pre>
    </section>
    <section id="saints">
      <h3>When should a holy person be labeled as a saint?</h3>
      <p>Holy persons are <em>not</em> labeled as saints when their names appear as authors of
        texts. For example, the authoritative title for Clement of Ohrid’s <q>Sermon before
          receiving holy communion</q> is <q>Поучение преди причастие от Климент Охридски</q> (not
          <q>… от св. Климент …</q>).</p>
      <p>Holy persons <em>are</em> labeled as saints when they appear otherwise than as authors. For
        example, the authoritative title of the <q>Akathist hymn in honor of St. John the
          Baptist</q> is <q>Акатист за св. Йоан Кръстител</q> (not <q>Акатист за Йоан …</q>, without
        the <q>св.</q>). The only exception is that the word <q>Богородица</q> is never preceded by
          <q>св.</q>.</p>
      <p>The label for a saint is never repeated in texts dedicated to multiple saints. For example,
          <q>Служба за св. Пров, Тарах и Андроник и Козма Маюмски</q> uses <q>св.</q> just once,
        before the first saint mentioned, and does not repeat it.</p>
      <p>Where possible, we follow the <cite>Oxford Dictionary of Byzantium</cite> for names of
        persons, so <q>Gregory of Nazianzos</q> rather than <q>Gregory the Theologian</q>. The
        Apostles are referred to as <q>St. Paul the Apostle</q>. <q>Pseudo</q> names put the
          <q>pseudo</q> last in parentheses, so <q>Basil the Great (Pseudo)</q>.</p>
    </section>
    <section id="writtenLines">
      <h3><code>@writtenLines</code> attribute</h3>
      <p>The <code>@writtenLines</code> attribute on the <code>&lt;layout&gt;</code> element takes a
        value of one integer or two white-space-separated integers. A single integer means that all
        pages have the same number of written lines; two integers defines the low and high values of
        the range of line counts. Where there are two values, they must be separated by white space;
        separating them with a hyphen or en dash is invalid.</p>
    </section>
  </body>
</html>

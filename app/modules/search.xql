xquery version "3.1";
import module namespace re = 'http://www.ilit.bas.bg/repertorium/ns/3.0' at "re-lib.xqm";
declare namespace tei = "http://www.tei-c.org/ns/1.0";
declare namespace m = "http://www.obdurodon.org/model";
declare variable $title as xs:string := "Browse the collection";
declare variable $exist:root as xs:string := request:get-parameter("exist:root", "xmldb:exist:///db/apps");
declare variable $exist:controller as xs:string := request:get-parameter("exist:controller", "/repertorium");
declare variable $path-to-data as xs:string := concat($exist:root, $exist:controller, '/data');

declare variable $mss as document-node()+ := collection(concat($path-to-data, '/mss'));
declare variable $genres as element(genre)+ := doc(concat($path-to-data, '/aux/genres.xml'))/genres/genre;
declare variable $titles as element(title)+ := doc(concat($path-to-data, '/aux/titles_cyrillic.xml'))/descendant::title;

declare variable $countries as xs:string* := request:get-parameter('countries[]', ());
declare variable $settlements as xs:string* := request:get-parameter('settlements[]', ());
declare variable $repositories as xs:string* := request:get-parameter('repositories[]', ());

declare variable $texts := distinct-values($mss/descendant::tei:msItemStruct/tei:title[@xml:lang = 'bg']);
declare variable $authors := distinct-values($mss/descendant::tei:msItemStruct/tei:author[. ne 'anonymous']);

declare variable $query-options as map(*) :=
map {
    "facets": map {
        "country": $countries,
        "settlement": $settlements,
        "repository": $repositories
    }
};

declare variable $hits as element(tei:TEI)* := $mss/tei:TEI[ft:query(., (), $query-options)];
declare variable $country-facets as map(*) := ft:facets($hits, "country");
declare variable $settlement-facets as map(*) := ft:facets($hits, "settlement");
declare variable $repository-facets as map(*) := ft:facets($hits, "repository");

<m:results>
    <m:countries>{re:serialize-facets($country-facets)}</m:countries>
    <m:settlements>{re:serialize-facets($settlement-facets)}</m:settlements>
    <m:repositories>{re:serialize-facets($repository-facets)}</m:repositories>
    <m:mss>{
            for $ms in $hits
            let $bg-title-individual as element(tei:msName)* :=
            $ms/descendant::tei:msIdentifier/tei:msName[@xml:lang eq 'bg' and @type eq 'individual']
            let $bg-title-specific as element(bg)* :=
            $genres/en[. = $ms/descendant::tei:msIdentifier/tei:msName[@type eq 'specific']]/../bg
            let $bg-title-general as element(bg)* :=
            $genres/en[. = $ms/descendant::tei:msIdentifier/tei:msName[@type eq 'general']]/../bg
            let $bg-title as xs:string :=
            ($bg-title-individual, $bg-title-specific, $bg-title-general)[1]
            ! normalize-space()
            let $en-title-individual as element(tei:msName)* :=
            $ms/descendant::tei:msIdentifier/tei:msName[@xml:lang eq 'en' and @type eq 'individual']
            let $en-title-specific as element(en)* :=
            $genres/en[. = $ms/descendant::tei:msIdentifier/tei:msName[@type eq 'specific']]
            let $en-title-general as element(en)* :=
            $genres/en[. = $ms/descendant::tei:msIdentifier/tei:msName[@type eq 'general']]
            let $en-title as xs:string :=
            ($en-title-individual, $en-title-specific, $en-title-general)[1]
            ! normalize-space()
            let $ru-title-individual as element(tei:msName)* :=
            $ms/descendant::tei:msIdentifier/tei:msName[@xml:lang eq 'ru' and @type eq 'individual']
            let $ru-title-specific as element(ru)* :=
            $genres/en[. = $ms/descendant::tei:msIdentifier/tei:msName[@type eq 'specific']]/../ru
            let $ru-title-general as element(ru)* :=
            $genres/en[. = $ms/descendant::tei:msIdentifier/tei:msName[@type eq 'general']]/../ru
            let $ru-title as xs:string :=
            ($ru-title-individual, $ru-title-specific, $ru-title-general)[1]
            ! normalize-space()
            let $country as element(tei:country)? := $ms/descendant::tei:msIdentifier/tei:country
            let $settlement as element(tei:settlement)* := $ms/descendant::tei:msIdentifier/tei:settlement
            let $repository as element(tei:repository)* := $ms/descendant::tei:msIdentifier/tei:repository
            let $idno as element(tei:idno)? := $ms/descendant::tei:msIdentifier/tei:idno
            [@type = "shelfmark"][not(@rend = 'old')]
            let $orig-date as element(tei:origDate)* := $ms/descendant::tei:origDate
            let $id as attribute(xml:id) := $ms/@xml:id
                order by $country[1],
                    $settlement[1],
                    $repository[1],
                    $idno[1]
            return
                <m:ms>
                    <m:country>{$country ! normalize-space()}</m:country>
                    <m:settlement>{$settlement ! normalize-space()}</m:settlement>
                    <m:repository>{$repository ! normalize-space()}</m:repository>
                    <m:idno>{$idno ! normalize-space()}</m:idno>
                    <m:orig-date>{$orig-date ! normalize-space()}</m:orig-date>
                    <m:id>{$id ! string()}</m:id>
                    <m:title
                        xml:lang="bg">{$bg-title ! string()}</m:title>
                    <m:title
                        xml:lang="en">{$en-title ! string()}</m:title>
                    <m:title
                        xml:lang="ru">{$ru-title ! string()}</m:title>
                </m:ms>
        }</m:mss>
</m:results>
(:let $query :=
(<hr/>,
<h3>Find manuscripts</h3>,
<form
    action="runSearch-checkbox.php"
    method="get">
    <p><label
            for="country">Country</label>
        <select
            id="country"
            name="country">{
                <option
                    value="all">All countries ({count($countries)})</option>,
                for $country in $countries
                    order by $country
                return
                    <option
                        value="{$country}">{$country} ({count($mss//tei:msIdentifier[tei:country = $country])})</option>
            }</select>
    </p>
    <p>
        <label
            for="settlement">Settlement</label>
        <select
            id="settlement"
            name="settlement">{
                <option
                    value="all">All settlements ({count($settlements)})</option>,
                for $settlement in $settlements
                    order by $settlement
                return
                    <option
                        value="{$settlement}">{$settlement} ({count($mss//tei:msIdentifier[tei:settlement = $settlement])})</option>
            }</select>
    </p>
    <p>
        <label
            for="repository">Repository</label>
        <select
            id="repository"
            name="repository">{
                <option
                    value="all">All repositories ({count($repositories)})</option>,
                for $repository in $repositories
                    order by $repository
                return
                    <option
                        value="{$repository}">{$repository} ({count($mss//tei:msIdentifier[tei:repository = $repository])})</option>
            }</select>
    </p>
    <p>
        <label
            for="author">Authors</label>
        <select
            id="author"
            name="author">{
                <option
                    value="all">All authors ({count($authors)})</option>,
                for $author in $authors
                    order by $author
                return
                    <option
                        value="{$author}">{$author} ({count($mss//tei:msItemStruct[tei:author = $author])})</option>
            }</select>
    </p>
    <p
        class="select bg {if ($lg eq 'bg') then ' lg' else ' hide'}">
        <label
            for="bgTexts">Texts</label>
        <select
            id="bgTexts"
            name="bgTexts">{
                <option
                    value="all">Всички текстове ({$realTextCount})</option>,
                for $text in $bgTexts
                    order by lower-case($text)
                return
                    <option
                        value="{$text}">{$text} ({count($mss//tei:msItemStruct[tei:title = $text])})</option>
            }</select>
    </p>
    <p
        class="select en {if ($lg eq 'en') then ' lg' else ' hide'}">
        <label
            for="enTexts">Texts</label>
        <select
            id="enTexts"
            name="enTexts">{
                <option
                    value="all">All texts ({$realTextCount})</option>,
                for $enText in $enTexts
                (\: $bgEquiv is faster than a nested predicate :\)
                let $bgEquiv := $enText/preceding-sibling::Q{}bg
                    order by lower-case($enText)
                return
                    <option
                        value="{$bgEquiv}">{$enText} ({count($mss//tei:msItemStruct[tei:title = $bgEquiv])})</option>
            }</select>
    </p>
    <p
        class="select ru {if ($lg eq 'ru') then ' lg' else ' hide'}">
        <label
            for="ruTexts">Texts</label>
        <select
            id="ruTexts"
            name="ruTexts">{
                <option
                    value="all">Все тексты ({$realTextCount})</option>,
                for $ruText in $ruTexts
                let $bgEquiv := $ruText/preceding-sibling::bg
                    order by lower-case($ruText)
                return
                    <option
                        value="{$bgEquiv}">{$ruText} ({count($mss//tei:msItemStruct[tei:title = $bgEquiv])})</option>
            }</select>
    </p>
    <p><input
            type="submit"
            value="Submit"
            id="submit"/></p>
</form>
)
return:)
(:    <html>
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
            <style
                type="text/css">
                label {{padding-right: 0.25em;}}
                svg {{display: inline-block; padding: 0 .1em;}}</style>
            <xi:include
                href="{
                        concat(
                        $exist:root,
                        $exist:controller,
                        '/includes/boilerplate.xql?title=',
                        encode-for-uri($title),
                        '&amp;fqcontroller=',
                        $fqcontroller,
                        '&amp;resource=',
                        $exist:resource
                        )
                    }"
            />
            {$query}</body>
    </html>:)
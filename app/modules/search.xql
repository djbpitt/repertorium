xquery version "3.1";
declare default function namespace "http://www.w3.org/2005/xpath-functions";
declare default element namespace "http://www.w3.org/1999/xhtml";
declare namespace xi = "http://www.w3.org/2001/XInclude";
declare namespace tei = "http://www.tei-c.org/ns/1.0";
import module namespace re = 'http://www.ilit.bas.bg/repertorium/ns/3.0' at "re-lib.xqm";
declare namespace output = "http://www.w3.org/2010/xslt-xquery-serialization";
declare option output:method "xml";
declare option output:media-type "application/xhtml+xml";
declare option output:omit-xml-declaration "no";
declare option output:doctype-system "about:legacy-compat";
declare option output:indent "no";
declare variable $title as xs:string := "Search the collection";
declare variable $exist:root as xs:string := request:get-parameter("exist:root", ());
declare variable $exist:prefix as xs:string := request:get-parameter("exist:prefix", ());
declare variable $exist:controller as xs:string := request:get-parameter("exist:controller", ());
declare variable $exist:path as xs:string := request:get-parameter("exist:path", ());
declare variable $exist:resource as xs:string := request:get-parameter("exist:resource", ());
declare variable $uri as xs:string := request:get-parameter("uri", ());
declare variable $context as xs:string := request:get-parameter("context", ());
declare variable $fqcontroller as xs:string := concat($context, $exist:prefix, $exist:controller, '/');

declare variable $mss as document-node()+ := collection(concat($exist:root, $exist:controller, '/mss'))[ends-with(base-uri(.), 'xml')];
declare variable $countries := distinct-values($mss//tei:msIdentifier/tei:country);
declare variable $settlements := distinct-values($mss//tei:msIdentifier/tei:settlement);
declare variable $repositories := distinct-values($mss//tei:msIdentifier/tei:repository);
declare variable $allTitles as element(Q{}title)+ := doc(concat($exist:root, $exist:controller, '/aux/titles_cyrillic.xml'))//Q{}title;
declare variable $texts := distinct-values($mss//tei:msItemStruct/tei:title[@xml:lang = 'bg']);
declare variable $bgTexts as element(Q{}bg)+ := $allTitles[Q{}bg = $texts]/Q{}bg;
declare variable $enTexts as element(Q{}en)+ := $allTitles[Q{}bg = $texts]/Q{}en;
declare variable $ruTexts as element(Q{}ru)+ := $allTitles[Q{}bg = $texts]/Q{}ru;
declare variable $realTextCount as xs:integer := count($bgTexts);
declare variable $genres as element(Q{}genre)+ := doc(concat($exist:root, $exist:controller, '/aux/genres.xml'))//Q{}genre;
declare variable $authors := distinct-values($mss//tei:msItemStruct/tei:author[. ne 'anonymous']);

declare variable $lg as xs:string := request:get-parameter('lg', 'bg');

let $query :=
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
                (: $bgEquiv is faster than a nested predicate :)
                let $bgEquiv := $enText/preceding-sibling::bg
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
return
    <html>
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
    </html>
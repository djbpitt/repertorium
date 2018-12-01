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
declare variable $title as xs:string := "Browse the collection";
declare variable $exist:root as xs:string := request:get-parameter("exist:root", ());
declare variable $exist:prefix as xs:string := request:get-parameter("exist:prefix", ());
declare variable $exist:controller as xs:string := request:get-parameter("exist:controller", ());
declare variable $exist:path as xs:string := request:get-parameter("exist:path", ());
declare variable $exist:resource as xs:string := request:get-parameter("exist:resource", ());
declare variable $uri as xs:string := request:get-parameter("uri", ());
declare variable $context as xs:string := request:get-parameter("context", ());
declare variable $fqcontroller as xs:string := concat($context, $exist:prefix, $exist:controller, '/');

declare variable $mss := collection(concat($exist:root, $exist:controller, '/mss'))[ends-with(base-uri(.), 'xml')];
declare variable $genres := doc(concat($exist:root, $exist:controller, '/aux/genres.xml'))//Q{}genre;
declare variable $lg := request:get-parameter('lg', 'bg');

let $query :=
for $ms in $mss
let $bgTitle := (
$ms//tei:msIdentifier/tei:msName[@xml:lang eq 'bg' and @type eq 'individual'],
$genres[Q{}en = $ms//tei:msIdentifier/tei:msName[@type eq 'specific']]/Q{}bg,
$genres[Q{}en = $ms//tei:msIdentifier/tei:msName[@type eq 'general']]/Q{}bg)[1]
let $enTitle := (
$ms//tei:msIdentifier/tei:msName[@xml:lang eq 'en' and @type eq 'individual'],
for $i in $ms//tei:msIdentifier/tei:msName[@xml:lang eq 'en' and @type eq 'specific'][1]
return
    $i,
$ms//tei:msIdentifier/tei:msName[@xml:lang eq 'en' and @type eq 'general'])[1]
let $ruTitle := (
$ms//tei:msIdentifier/tei:msName[@xml:lang eq 'ru' and @type eq 'individual'],
$genres[en = $ms//tei:msIdentifier/tei:msName[@tpe eq 'specific']]/ru,
$genres[en = $ms//tei:msIdentifier/tei:msName[@type eq 'general']]/ru)[1]
let $country := $ms//tei:msIdentifier/tei:country
let $settlement := $ms//tei:msIdentifier/tei:settlement
let $repository := $ms//tei:msIdentifier/tei:repository
let $idno := $ms//tei:msIdentifier/tei:idno[@type = "shelfmark"][not(@rend = 'old')]
let $origDate := $ms//tei:origDate
let $uri := tokenize(base-uri($ms), '/')[last()]
let $availability := $ms//tei:adminInfo/tei:availability
    order by $country[1],
        $settlement[1],
        $repository[1],
        $idno[1]
return
    <li>
        <input
            type="checkbox"
            name="mss[]"
            value="{substring-before($uri, ".xml")}"/>
        {
            if ($country) then
                (<a
                    href="/runSearch-checkbox.php?country={$country}&amp;settlement=all&amp;repository=all&amp;author=all&amp;bgTexts=all&amp;enTexts=all&amp;ruTexts=all">{string($country[1])}</a>, ', ',
                <a
                    href="/runSearch-checkbox.php?country=all&amp;settlement={$settlement[1]}&amp;repository=all&amp;author=all&amp;bgTexts=all&amp;enTexts=all&amp;ruTexts=all">{string($settlement[1])}</a>, ', ',
                <a
                    href="/runSearch-checkbox.php?country=all&amp;settlement=all&amp;repository={$repository}&amp;author=all&amp;bgTexts=all&amp;enTexts=all&amp;ruTexts=all">{string($repository[1])}</a>, ', ',
                if ($idno) then
                    string($idno[1])
                else
                    ())
            else
                '[Multiple repositories]'
        }
        ({
            if (count($origDate) gt 1) then
                'Composite: '
            else
                (),
            string-join($origDate, '; ')
        }) [{substring-before($uri, ".xml")}]
        {
            if ($availability) then
                concat(' (', $availability, ')')
            else
                ()
        }
        <br/>
        <span
            class="msName bg {
                    if ($lg eq 'bg') then
                        'lg'
                    else
                        ('hide')
                }"
            style="{
                    if ($lg eq 'bg') then
                        'display:inline;'
                    else
                        'display:none'
                }">{
                if ($bgTitle) then
                    string-join($bgTitle/re:titleCase(.), ', ')
                else
                    '[no Bulgarian title]'
            }</span>
        <span
            class="msName en {
                    if ($lg eq 'en') then
                        'lg'
                    else
                        ('hide')
                }"
            style="{
                    if ($lg eq 'en') then
                        'display:inline;'
                    else
                        'display:none'
                }">{
                if ($enTitle) then
                    string-join($enTitle/re:titleCase(.), ', ')
                else
                    '[no English title]'
            }</span>
        <span
            class="msName ru {
                    if ($lg eq 'ru') then
                        'lg'
                    else
                        ('hide')
                }"
            style="{
                    if ($lg eq 'ru') then
                        'display:inline;'
                    else
                        'display:none'
                }">{
                if ($ruTitle) then
                    string-join($ruTitle/re:titleCase(.), ', ')
                else
                    '[no Russian title]'
            }</span>
        <a><xi:include
                href="{concat($exist:root, $exist:controller, '/resources/images/codicology.svg')}"/></a>
        <a><xi:include
                href="{concat($exist:root, $exist:controller, '/resources/images/texts.svg')}"/></a>
        <a><xi:include
                href="{concat($exist:root, $exist:controller, '/resources/images/xml.svg')}"/></a>
    </li>
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
                ul {{padding-left: 0;
                list-style: none;
                text-indent: -1.5em;
                margin-left: 1.5em;
                }};
                .msName {{font-size: smaller; padding-left: 2em;}}
                svg {{display: inline-block; padding: 0 .1em;}}</style>
            <xi:include
                href="{
                        concat(
                        $exist:root,
                        $exist:controller,
                        '/includes/boilerplate.xql?title=',
                        encode-for-uri($title),
                        '&amp;fqcontroller=',
                        $fqcontroller
                        )
                    }"
            />
            <ul>{$query}</ul></body>
    </html>
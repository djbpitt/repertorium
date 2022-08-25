xquery version "3.1";
declare namespace tei = "http://www.tei-c.org/ns/1.0";
import module namespace re = 'http://www.ilit.bas.bg/repertorium/ns/3.0' at "re-lib.xqm";
declare namespace m ="http://www.obdurodon.org/model";
declare variable $title as xs:string := "Browse the collection";
declare variable $exist:root as xs:string := request:get-parameter("exist:root", "xmldb:exist:///db/apps");
declare variable $exist:controller as xs:string := request:get-parameter("exist:controller", "/repertorium");
declare variable $path-to-data as xs:string := concat($exist:root, $exist:controller, '/data');

declare variable $mss as element(tei:TEI)+ := collection(concat($path-to-data, '/mss'))/*;
declare variable $genres as element(genre)+ := doc(concat($path-to-data, '/aux/genres.xml'))/genres/genre;
declare variable $lg := request:get-parameter('lg', 'bg');
<m:results>{
for $ms in $mss
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

(: let $en-title as xs:string := (
$ms/descendant::tei:msIdentifier/tei:msName[@xml:lang eq 'en' and @type eq 'individual'],
$ms/descendant::tei:msIdentifier/tei:msName[@xml:lang eq 'en' and @type eq 'specific'],
$ms/descendant::tei:msIdentifier/tei:msName[@xml:lang eq 'en' and @type eq 'general'])[1] ! normalize-space() :)
(: let $ru-title as xs:string := (
$ms/descendant::tei:msIdentifier/tei:msName[@xml:lang eq 'ru' and @type eq 'individual'],
$genres/en[. = $ms/descendant::tei:msIdentifier/tei:msName[@tpe eq 'specific']]/../ru,
$genres/en[. = $ms/descendant::tei:msIdentifier/tei:msName[@type eq 'general']]/../ru)[1] ! normalize-space() :)
(:let $country := $ms//tei:msIdentifier/tei:country
let $settlement := $ms//tei:msIdentifier/tei:settlement
let $repository := $ms//tei:msIdentifier/tei:repository
let $idno := $ms//tei:msIdentifier/tei:idno[@type = "shelfmark"][not(@rend = 'old')]
let $origDate := $ms//tei:origDate
let $uri := tokenize(base-uri($ms), '/')[last()]
let $availability := $ms//tei:adminInfo/tei:availability
    order by $country[1],
        $settlement[1],
        $repository[1],
        $idno[1]:)
return 
<m:ms>
    <m:bg-title>{$bg-title}</m:bg-title>
    <m:en-title>{$en-title}</m:en-title>
    <m:ru-title>{$ru-title}</m:ru-title>
</m:ms>
}</m:results>
(:return
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
    </li>:)
(:return
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
                        $fqcontroller,
                        '&amp;resource=',
                        $exist:resource
                        )
                    }"
            />
            <ul>{$query}</ul></body>
    </html>:)
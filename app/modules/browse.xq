xquery version "3.1";

declare namespace tei = "http://www.tei-c.org/ns/1.0";
declare namespace m="http://repertorium.obdurodon.org/model";

import module namespace re = 'http://www.ilit.bas.bg/repertorium/ns/3.0' at "re-lib.xqm";
declare namespace output = "http://www.w3.org/2010/xslt-xquery-serialization";
declare option output:method "xml";
declare option output:indent "no";
declare variable $exist:root as xs:string := 
    request:get-parameter("exist:root", "xmldb:exist:///db/apps");
declare variable $exist:controller as xs:string := 
    request:get-parameter("exist:controller", "/repertorium");

declare variable $mss as document-node()+ := 
    collection(concat($exist:root, $exist:controller, '/mss'))[ends-with(base-uri(.), 'xml')];
declare variable $genres as element(genre)+ := 
    doc(concat($exist:root, $exist:controller, '/aux/genres.xml'))/descendant::genre;
declare variable $lg as xs:string := request:get-parameter('lg', 'bg');
<m:main>
<m:h2>Browse the collection</m:h2>
<m:ul>{
for $ms in $mss
(: bg and ru titles can be bg, ru, or tei:msName :)
let $bgTitle as element() := (
    $ms/descendant::tei:msIdentifier/tei:msName[lang('bg') and @type eq 'individual'],  
    $genres[en = $ms/descendant::tei:msIdentifier/tei:msName[@type eq 'specific']]/bg,
    $genres[en = $ms/descendant::tei:msIdentifier/tei:msName[@type eq 'general']]/bg)[1]
let $enTitle as element(tei:msName) := (
    $ms/descendant::tei:msIdentifier/tei:msName[lang('en') and @type eq 'individual'],
    $ms/descendant::tei:msIdentifier/tei:msName[@type eq 'specific'],
    $ms/descendant::tei:msIdentifier/tei:msName[@type eq 'general'])[1]
let $ruTitle as element() := (
    $ms/descendant::tei:msIdentifier/tei:msName[lang('ru') and @type eq 'individual'],
    $genres[en = $ms/descendant::tei:msIdentifier/tei:msName[@tpe eq 'specific']]/ru,
    $genres[en = $ms/descendant::tei:msIdentifier/tei:msName[@type eq 'general']]/ru)[1]
(: Fragmented mss don’t have a principal country:)
let $country as element(tei:country)? := $ms/descendant::tei:msIdentifier/tei:country
let $settlement as element(tei:settlement)* := $ms/descendant::tei:msIdentifier/tei:settlement
let $repository as element(tei:repository)* := $ms/descendant::tei:msIdentifier/tei:repository
let $idno as element(tei:idno)? := $ms/descendant::tei:msIdentifier/tei:idno[@type = "shelfmark"][not(@rend = 'old')]
let $origDate as element(tei:origDate)* := $ms/descendant::tei:origDate
let $uri as xs:string := tokenize(base-uri($ms), '/')[last()] ! substring-before(., ".xml")
let $availability as element(tei:availability)? := $ms/descendant::tei:adminInfo/tei:availability
    order by $country[1],
        $settlement[1],
        $repository[1],
        $idno[1]
return
(:
    <m:li>
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
    </m:li>
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
                        $fqcontroller,
                        '&amp;resource=',
                        $exist:resource
                        )
                    }"
            />
            <ul>{$query}</ul></body>
    </html>
    :)
<m:li>
    { (: Allow empty country to support special handling of fragmented mss :) }
    <m:country>{$country ! normalize-space()}</m:country>
    {$settlement ! <m:settlement>{normalize-space(.)}</m:settlement>}
    {$repository ! <m:repository>{normalize-space(.)}</m:repository>}
    <m:idno>{$idno ! normalize-space()}</m:idno>
    <m:origDate>{$origDate ! normalize-space(.)}</m:origDate>
    <m:bg>{$bgTitle ! normalize-space() ! re:titleCase(.)}</m:bg>
    <m:en>{$enTitle ! normalize-space() ! re:titleCase(.)}</m:en>
    <m:ru>{$ruTitle ! normalize-space() ! re:titleCase(.)}</m:ru>
    <m:uri>{$uri}</m:uri>
    {$availability ! <m:availability>{normalize-space(.)}</m:availability>}
</m:li>
}</m:ul>
<m:lg>{$lg}</m:lg>
</m:main>
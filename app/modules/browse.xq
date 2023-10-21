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
declare variable $lg as xs:string := (request:get-cookie-value('lg'), 'bg')[1];
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
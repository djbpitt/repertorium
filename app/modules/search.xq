xquery version "3.1";

declare namespace tei = "http://www.tei-c.org/ns/1.0";
declare namespace m="http://repertorium.obdurodon.org/model";

import module namespace re = 'http://www.ilit.bas.bg/repertorium/ns/3.0' at "re-lib.xqm";
declare namespace output = "http://www.w3.org/2010/xslt-xquery-serialization";
declare option output:method "xml";
declare option output:indent "no";
declare variable $exist:root as xs:string := 
    (request:get-attribute("$exist:root"), "xmldb:exist:///db/apps")[1];
declare variable $exist:controller as xs:string := 
    (request:get-attribute("$exist:controller"), "/repertorium")[1];
declare variable $pathToMss as xs:string := 
    concat($exist:root, $exist:controller, '/mss');
declare variable $all-mss as document-node()+ := 
    collection($pathToMss)[ends-with(base-uri(.), 'xml')];
declare variable $mss as element(tei:TEI)* :=
    $all-mss/tei:TEI[ft:query(., ())];
declare variable $country-facets as map(*) := ft:facets($mss, "country");
declare variable $genres as element(genre)+ := 
    doc(concat($exist:root, $exist:controller, '/aux/genres.xml'))/descendant::genre;
declare variable $lg as xs:string := (request:get-cookie-value('lg'), 'bg')[1];
<m:main>
<m:h2>Search the collection</m:h2>
<m:ul>{
for $ms in $mss
(: bg and ru titles can be bg, ru, or tei:msName :)
let $bgTitle as xs:string := re:bgMsName($ms)
let $enTitle as xs:string := re:enMsName($ms)
let $ruTitle as xs:string := re:ruMsName($ms)
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
<m:facets>
    <m:countries>{
        let $country-elements :=
            map:for-each($country-facets, function($label, $count) {
                    <m:country>
                        <m:label>{$label}</m:label>
                        <m:count>{$count}</m:count>
                </m:country>})
        for $country-element in $country-elements
        order by $country-element/m:label
         return $country-element
    }</m:countries>
</m:facets>
<m:lg>{$lg}</m:lg>
</m:main>
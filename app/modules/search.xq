xquery version "3.1";

declare namespace tei = "http://www.tei-c.org/ns/1.0";
declare namespace m="http://repertorium.obdurodon.org/model";

import module namespace re = 'http://www.ilit.bas.bg/repertorium/ns/3.0' at "re-lib.xqm";
declare namespace output = "http://www.w3.org/2010/xslt-xquery-serialization";
declare option output:method "xml";
declare option output:indent "no";

(: Housekeeping :)
declare variable $exist:root as xs:string := 
    (request:get-attribute("$exist:root"), "xmldb:exist:///db/apps")[1];
declare variable $exist:controller as xs:string := 
    (request:get-attribute("$exist:controller"), "/repertorium")[1];
declare variable $pathToMss as xs:string := 
    concat($exist:root, $exist:controller, '/mss');

(: Receive and pre-process query parameters :)
declare variable $country-input := request:get-parameter("country", ());
declare variable $settlement-input := request:get-parameter("settlement", ());
declare variable $repository-input := request:get-parameter("repository", ());
declare variable $options as map(*) :=
    map {
        "facets": map:merge ((
            map:entry("country", $country-input),
            map:entry("settlement", $settlement-input),
            map:entry("repository", $repository-input)
        ))
    };
declare variable $titleWords := request:get-parameter("titleWords", ());
declare variable $authorWords := request:get-parameter("authorWords", ());
declare variable $exactTitle := request:get-parameter("exactTitle", ());
(: Parameter is always submitted so no value means empty string, not empty sequence
Use effective Boolean value to return empty sequence if no query words :)
declare variable $allWords := normalize-space(string-join(($titleWords, $authorWords), " "))[.];

(: Retrieve mss and facet values :)
declare variable $all-mss as document-node()+ := 
    collection($pathToMss)[ends-with(base-uri(.), 'xml')];
declare variable $exactTitleMss as document-node()* := 
  if ($exactTitle) then $all-mss[descendant::tei:msItemStruct/tei:title = $exactTitle] else $all-mss;
declare variable $mss as element(tei:TEI)* :=
    $exactTitleMss/tei:TEI[ft:query(., $allWords, $options)];
declare variable $country-facets as map(*) := ft:facets($mss, "country");
declare variable $settlement-facets as map(*) := ft:facets($mss, "settlement");
declare variable $repository-facets as map(*) := ft:facets($mss, "repository");
declare variable $genres as element(genre)+ := 
    doc(concat($exist:root, $exist:controller, '/aux/genres.xml'))/descendant::genre;
declare variable $lg as xs:string := (request:get-cookie-value('lg'), 'bg')[1];
declare function local:facets-to-xml($name as xs:string, $input as map(*)) {
    element {concat('m:', $name, '-facets')} {
        let $elements :=
            map:for-each($input, function($label, $count) {
                element {concat('m:', $name)} {
                    <m:label>{$label}</m:label>,
                    <m:count>{$count}</m:count>
                }
            })
        for $element in $elements
        order by $element/m:label
        return $element
    }
};
<m:main>
<m:h2>Search the collection</m:h2>
<m:titleWords>{$titleWords}</m:titleWords>
<m:authorWords>{$titleWords}</m:authorWords>
<m:both>{string-join(($titleWords, $authorWords), " ")}</m:both>
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
<m:facets>{
    local:facets-to-xml("country", $country-facets),
    local:facets-to-xml("settlement", $settlement-facets),
    local:facets-to-xml("repository", $repository-facets)
}</m:facets>
<m:inputs>{
let $m as map(*) := map {
    "country" : $country-input,
    "settlement" : $settlement-input,
    "repository": $repository-input,
    "titleWords": $titleWords,
    "authorWords": $authorWords,
    "allWords" : $allWords
}
return map:for-each($m, function 
    ($k, $v) {if ($v) then <m:input k="{$k}">{$v}</m:input> else ()}
)}</m:inputs>
<m:lg>{$lg}</m:lg>
</m:main>
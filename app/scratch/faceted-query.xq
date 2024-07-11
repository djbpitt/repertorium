xquery version "3.1";
declare namespace re="http://www.ilit.bas.bg/repertorium/ns/3.0";
declare namespace tei="http://www.tei-c.org/ns/1.0";
declare variable $mss as document-node()+ := collection("/db/apps/repertorium/mss");
declare variable $country_input as xs:string? := "Bulgaria";
declare variable $settlement_input as xs:string? := ();
declare variable $repository_input as xs:string? := "National Library";
let $options as map(*) :=
    map { "facets" : map {
            "country" : $country_input,
            "settlement" : $settlement_input,
            "repository" : $repository_input
        }}
let $all as element(tei:TEI)* := 
    $mss/tei:TEI[ft:query(., (), $options)]
let $title_hits as element(tei:TEI)* :=
    $mss/tei:TEI[ft:query(descendant::tei:title, "Поучение", $options)]

return ($title_hits)/descendant::tei:repository

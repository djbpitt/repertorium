xquery version "3.1";
(:
Summary: Looks up partial titles (ngram match) in user's chosen language

Parameters:
    $lg-cookie as xs:string : chosen language, defaults to 'bg'
    $query-string as xs:string? := ngram to search

Returns:
    <m:options> with zero or more <m:option> children
    Options are full article titles in the chosen language and
        followed by a count of occurrences in corpus    NB:

Notes:
    Used for real-time updates of selection list
    ngram index is case-insensitive

Workflow:
    Input is matched against titles in the correct language in the master list
    Matches are translated into Bulgarian (only language used in description files)
    Bg matches are searched with ft:query() using keyword index (each entire title
        is a single token, so only full, exact matches)
    Indexes all title elements, so need to restrict context in query
    Counts are retrieved with ft:facets()
:)

declare namespace m = "http://www.obdurodon.org/model";
declare namespace tei = "http://www.tei-c.org/ns/1.0";
declare variable $exist:root as xs:string := request:get-parameter("exist:root", "xmldb:exist:///db/apps");
declare variable $exist:controller as xs:string := request:get-parameter("exist:controller", "/repertorium");
declare variable $path-to-data as xs:string := $exist:root || $exist:controller || '/data';
declare variable $all-titles as document-node() := doc($path-to-data || '/aux/titles_cyrillic.xml');
declare variable $lg-cookie as xs:string? := request:get-cookie-value('lg');
declare variable $titles-to-check as element()+ :=
    switch ($lg-cookie)
        case "en"
            return
                $all-titles/descendant::en
        case "ru"
            return
                $all-titles/descendant::ru
        default return
            $all-titles/descendant::bg;
declare variable $query-string as xs:string? := request:get-parameter('query-string', ());
declare variable $matches-in-user-lg as element()* := $titles-to-check[ngram:contains(., $query-string)];
declare variable $all-bg-titles as element(tei:title)* := collection($path-to-data)/descendant::tei:msItemStruct/tei:title[ft:query(., ())];
declare variable $title-facets as map(*) := ft:facets($all-bg-titles, "title");
<m:options>{
    for $title in $matches-in-user-lg
    let $bg-title as element(bg) := $title/../bg
    let $count as xs:integer? := $title-facets($bg-title)
    order by $title ! lower-case(.)
    return
        <m:option>{concat($title, ' (', $count, ')')}</m:option>
}</m:options>

xquery version "3.1";
(: Import functions :)
import module namespace re = 'http://www.ilit.bas.bg/repertorium/ns/3.0' at "re-lib.xqm";
(: Declare namespaces :)
declare namespace tei = "http://www.tei-c.org/ns/1.0";
declare namespace m = "http://www.obdurodon.org/model";
(: Constant :)
declare variable $title as xs:string := "Browse the collection";
(: Controller variables and derived paths :)
declare variable $exist:root as xs:string := request:get-parameter("exist:root", "xmldb:exist:///db/apps");
declare variable $exist:controller as xs:string := request:get-parameter("exist:controller", "/repertorium");
declare variable $path-to-data as xs:string := concat($exist:root, $exist:controller, '/data');
declare variable $mss as document-node()+ := collection(concat($path-to-data, '/mss'));
declare variable $genres as element(genre)+ := doc(concat($path-to-data, '/aux/genres.xml'))/genres/genre;
declare variable $titles as element(title)+ := doc(concat($path-to-data, '/aux/titles_cyrillic.xml'))/descendant::title;
(: Input parameters :)
declare variable $country as xs:string? := request:get-parameter('country', ());
declare variable $settlement as xs:string* := request:get-parameter('settlement', ());
declare variable $repository as xs:string? := request:get-parameter('repository', ());
declare variable $query-string as xs:string := request:get-parameter('query-string', '');
declare variable $lg-cookie as xs:string? := request:get-cookie-value('lg');
(: Find titles to search in correct language, based on $lg-cookie:)
declare variable $all-titles as document-node() := doc($path-to-data || '/aux/titles_cyrillic.xml');
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

declare variable $query-options as map(*) :=
map {
    "facets": map {
        "country": $country,
        "settlement": $settlement,
        "repository": $repository
    }
};

declare variable $bg-query-value as element(query)? := (: null and empty string should be () :)
if (string-length($query-string) ne 0) then
    <query>
        <term>{$titles-to-check[. eq replace($query-string, ' \(\d+\)$', '')]/../bg ! string()}</term>
    </query>
else
    ();
declare variable $bg-title-hits as element(tei:title)* :=
$mss/descendant::tei:title[ft:query(., $bg-query-value)];
(: If no hits, return facets for all mss :)
declare variable $bg-title-mss as element(tei:TEI)* :=
$bg-title-hits/ancestor::tei:TEI[ft:query(., (), $query-options)];

declare variable $country-facets as map(*) := ft:facets($bg-title-mss, "country");
declare variable $settlement-facets as map(*) := ft:facets($bg-title-mss, "settlement");
declare variable $repository-facets as map(*) := ft:facets($bg-title-mss, "repository");

<m:results>
    <m:lg-cookie>{$lg-cookie}</m:lg-cookie>
    <m:query-string>{$query-string}</m:query-string>
    <m:bg-query-value>{$bg-query-value}</m:bg-query-value>
    <m:bg-title-hits>{$bg-title-hits => count()}</m:bg-title-hits>
    <m:bg-title-mss>{$bg-title-mss => count()}</m:bg-title-mss>
    <m:country>{$country}</m:country>
    <m:settlement>{$settlement}</m:settlement>
    <m:repository>{$repository}</m:repository>
    <m:query-options>{serialize($query-options, map {"method": "json"})}</m:query-options>
    <m:countries>{re:serialize-facets($country-facets, $country)}</m:countries>
    <m:settlements>{re:serialize-facets($settlement-facets, $settlement)}</m:settlements>
    <m:repositories>{re:serialize-facets($repository-facets, $repository)}</m:repositories>
    <m:mss>{
            for $ms in $bg-title-mss
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
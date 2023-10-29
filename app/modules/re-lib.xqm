xquery version "3.1";
module namespace re = "http://www.ilit.bas.bg/repertorium/ns/3.0";
declare namespace tei = "http://www.tei-c.org/ns/1.0";
declare namespace m = "http://repertorium.obdurodon.org/model";

(: Awaiting fix of https://github.com/eXist-db/exist/issues/5103 
   Currently using let declarations inside functions instead of 
     prolog variable :)
(: declare %private variable $re:root-collection as xs:string := 
    replace(system:get-module-load-path(), "xmldb:exist://embedded-eXist-server/", "/")
    ! substring-before(., "/modules");
declare %private variable $re:genres as element(genre)+ :=
    doc(concat($re:root-collection, "/aux/genres.xml"))/descendant::genre; :)
(: Compute msName to display (individual, specific, general) in three languages :)
(: declare variable $re:genres as element(genre)+ := 
    doc('/db/apps/repertorium/aux/genres.xml')/descendant::genre; :)
declare function re:bgMsName($ms as element(tei:TEI)) as xs:string {
    (: eXist-db can optimize FLWOR but not monolithic XPath :)
    (: let $re:genres as element(genre)+ := doc(concat(
        request:get-attribute("$exist:root"), request:get-attribute("$exist:controller"), "/aux/genres.xml"
    ))/descendant::genre :)
    let $re:genres as element(genre)+ := 
        doc("/db/apps/repertorium/aux/genres.xml")/descendant::genre
    let $individual as element(tei:msName)* := $ms/descendant::tei:msIdentifier/tei:msName[lang('bg')][@type eq 'individual']  
    let $specific as element(bg)* :=
        let $specificNames as element(tei:msName)* := $ms/descendant::tei:msIdentifier/tei:msName[@type eq 'specific']
        let $en as element(en)* := $re:genres/en[. = $specificNames]
        return $en/../bg
    let $general as element(bg)* :=
        let $generalNames as element(tei:msName)* := $ms/descendant::tei:msIdentifier/tei:msName[@type eq 'general']
        let $en as element(en)* := $re:genres/en[. = $generalNames]
        return $en/../bg
    return ($individual, $specific, $general)[1] ! normalize-space(.) ! re:titleCase(.)
};

declare function re:enMsName($ms as element(tei:TEI)) as xs:string {
    let $individual as element(tei:msName)* := $ms/descendant::tei:msIdentifier/tei:msName[lang('en')][@type eq 'individual']
    let $specific as element(tei:msName)* := $ms/descendant::tei:msIdentifier/tei:msName[@type eq 'specific']
    let $general as element(tei:msName)* := $ms/descendant::tei:msIdentifier/tei:msName[@type eq 'general']
    return ($individual, $specific, $general)[1] ! normalize-space(.) ! re:titleCase(.)
};

declare function re:ruMsName($ms as element(tei:TEI)) as xs:string {
    (: let $re:genres as element(genre)+ := doc(concat(
        request:get-attribute("$exist:root"), request:get-attribute("$exist:controller"), "/aux/genres.xml"
    ))/descendant::genre :)
    let $re:genres as element(genre)+ := 
        doc("/db/apps/repertorium/aux/genres.xml")/descendant::genre
    let $individual as element(tei:msName)* := $ms/descendant::tei:msIdentifier/tei:msName[lang('ru')][@type eq 'individual']
    let $specific as element(ru)* := 
        let $specificNames as element(tei:msName)* := $ms/descendant::tei:msIdentifier/tei:msName[@type eq 'specific']
        let $en as element(en)* := $re:genres/en[. = $specificNames]
        return $en/../ru
    let $general as element (ru)* := 
        let $generalNames as element(tei:msName)* := $ms/descendant::tei:msIdentifier/tei:msName[@type eq 'general']
        let $en as element(en)* := $re:genres/en[. = $generalNames]
        return $en/../ru
    return($individual, $specific, $general)[1] ! normalize-space(.) ! re:titleCase(.)
};

declare function re:addPeriod($text as xs:string) as xs:string {
    concat($text, if (ends-with(normalize-space($text), '.')) then
        ''
    else
        '.')
};

declare function re:pluralize($input as xs:string) as xs:string {
    (: Assumes, simplistically, that all plurals are formed by adding only "s" :)
    concat($input, "s")
};
declare function re:fileName($descriptionFile as document-node()) as xs:string {
    tokenize(base-uri($descriptionFile), '/')[last()]
};

declare function re:formatBib($bib as xs:string, $bibliog as node()) {
    let $current := $bibliog//tei:biblStruct[@xml:id = substring-after($bib, 'bib:')]
    let $author := concat($current//tei:author/tei:surname, ', ', $current//tei:author/tei:forename, '. ')
    let $title := <cite>{concat($current//tei:title[@level eq 'm'], '. ')}</cite>
    let $pubInfo := concat('(', $current//tei:pubPlace,
    if ($current//tei:publisher) then
        concat(': ', $current//tei:publisher)
    else
        (),
    ', ',
    $current//tei:date, ')')
    return
        ($author, $title, $pubInfo)
};


declare function re:titleCase($text as xs:string) as xs:string {
    upper-case(substring($text, 1, 1)) || substring($text, 2)
};

declare function re:unit($unit as xs:string) as xs:string {
    switch ($unit)
        case "folia"
            return
                "ff."
        case "folio"
            return
                "f."
        default return
            $unit
};

declare function re:roman($in as xs:double) as xs:string {
    fn:format-integer($in cast as xs:integer,"I")
};

declare function re:useModelNamespace($node as node()) as item()* {
    (: Change all namespaces to m: but retain local name 
       Complex content is more easily managed with XSLT :)
    typeswitch($node)
        case text() return $node
        case element() return element { "m:" || local-name($node)} {
            $node/@*,
            for $child in $node/node() return re:useModelNamespace($child)
        }
        default return "ERROR"
};
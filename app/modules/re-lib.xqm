xquery version "3.1";
module namespace re = "http://www.ilit.bas.bg/repertorium/ns/3.0";
declare namespace tei = "http://www.tei-c.org/ns/1.0";

(: TODO: Update documentation, esp. contents list :)

(: Contents
 :
 : get-attribute() functions have defaults for standard location for use
 :   during development
 :
 : re:addPeriod : adds a period if the string does not already end in one
 : re:fileName : returns immediate filename from base-uri()
 : re:formatBib : returns basic bibliographic information from <biblStruct> element
 : re:titleCase : capitalizes first word of input string
 : re:unit : converts "folia" to "ff", etc.
:)

declare variable $re:root as xs:string := (request:get-attribute("$exist:root"), "xmldb:exist:///db/apps")[1];
declare variable $re:controller as xs:string := (request:get-attribute("$exist:controller"), "/repertorium")[1];

(: Compute msName to display (individual, specific, general) in three languages :)
declare variable $re:genres as element(genre)+ := 
    doc(concat($re:root, $re:controller, '/aux/genres.xml'))/descendant::genre;

declare function re:bgMsName($ms as document-node()) as xs:string {
    (: eXist-db can optimize FLWOR but not monolithic XPath :)
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

declare function re:enMsName($ms as document-node()) as xs:string {
    let $individual as element(tei:msName)* := $ms/descendant::tei:msIdentifier/tei:msName[lang('en')][@type eq 'individual']
    let $specific as element(tei:msName)* := $ms/descendant::tei:msIdentifier/tei:msName[@type eq 'specific']
    let $general as element(tei:msName)* := $ms/descendant::tei:msIdentifier/tei:msName[@type eq 'general']
    return ($individual, $specific, $general)[1] ! normalize-space(.) ! re:titleCase(.)
};

declare function re:ruMsName($ms as document-node()) as xs:string {
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

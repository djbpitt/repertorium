xquery version "3.1";
module namespace re = "http://www.ilit.bas.bg/repertorium/ns/3.0";
declare namespace tei = "http://www.tei-c.org/ns/1.0";

(: TODO: Update documentation, esp. contents list:)

(: Contents
 : re:addPeriod : adds a period if the string does not already end in one
 : re:fileName : returns immediate filename from base-uri()
 : re:formatBib : returns basic bibliographic information from <biblStruct> element
 : re:titleCase : capitalizes first word of input string
 : re:unit : converts "folia" to "ff", etc.
:)

(: Compute msName to display (individual, specific, general) in three languages :)
declare variable $re:genres as element(genre)+ := 
    doc(concat(request:get-attribute('$exist:root'), 
        request:get-attribute('$exist:controller'), 
        '/aux/genres.xml'))/descendant::genre;

declare function re:bgMsName($ms as document-node()) as xs:string {
    ($ms/descendant::tei:msIdentifier/tei:msName[lang('bg') and @type eq 'individual'],  
    $re:genres[en = $ms/descendant::tei:msIdentifier/tei:msName[@type eq 'specific']]/bg,
    $re:genres[en = $ms/descendant::tei:msIdentifier/tei:msName[@type eq 'general']]/bg)[1]
    => string()
};

declare function re:enMsName($ms as document-node()) as xs:string {
    ($ms/descendant::tei:msIdentifier/tei:msName[lang('en') and @type eq 'individual'],
    $ms/descendant::tei:msIdentifier/tei:msName[@type eq 'specific'],
    $ms/descendant::tei:msIdentifier/tei:msName[@type eq 'general'])[1]
    => string()
};

declare function re:ruMsName($ms as document-node()) as xs:string {
    ($ms/descendant::tei:msIdentifier/tei:msName[lang('ru') and @type eq 'individual'],
    $re:genres[en = $ms/descendant::tei:msIdentifier/tei:msName[@tpe eq 'specific']]/ru,
    $re:genres[en = $ms/descendant::tei:msIdentifier/tei:msName[@type eq 'general']]/ru)[1]
    => string()
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

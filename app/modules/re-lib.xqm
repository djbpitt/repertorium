xquery version "3.1";
module namespace re = "http://www.ilit.bas.bg/repertorium/ns/3.0";
declare namespace tei = "http://www.tei-c.org/ns/1.0";
declare namespace m = "http://www.obdurodon.org/model";

(: Contents
 : re:addPeriod : adds a period if the string does not already end in one
 : re:fileName : returns immediate filename from base-uri()
 : re:formatBib : returns basic bibliographic information from <biblStruct> element
 : re:titleCase : capitalizes first word of input string
 : re:unit : converts "folia" to "ff", etc.
:)

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


declare function re:titleCase($text as xs:string*) as xs:string* {
    string-join(for $item in $text
    let $first := upper-case(substring($item, 1, 1))
    let $rest := substring($item, 2)
    return
        concat($first, $rest), '; ')
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

declare function re:serialize-facets($input as map(*), $checked as xs:string*) as element()* {
    for $key in map:keys($input)
    let $value as xs:integer := $input($key)
        order by lower-case($key)
    return
        <m:item
            key="{$key}">{
                if ($key = $checked) then
                    attribute checked {"checked"}
                else
                    ()
            }{$value}</m:item>
};

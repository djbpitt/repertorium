xquery version "3.1";

declare namespace tei = "http://www.tei-c.org/ns/1.0";
declare namespace m = "http://repertorium.obdurodon.org/model";

import module namespace re = "http://www.ilit.bas.bg/repertorium/ns/3.0" at "re-lib.xqm";
declare namespace output = "http://www.w3.org/2010/xslt-xquery-serialization";
declare option output:method "xml";
declare option output:indent "no";
declare variable $exist:root as xs:string := 
    request:get-parameter("exist:root", "xmldb:exist:///db/apps");
declare variable $exist:controller as xs:string := 
    request:get-parameter("exist:controller", "/repertorium");
declare variable $filename as xs:string? :=
    request:get-parameter('filename', 'AM100MCB.xml');
declare variable $ms as element(tei:TEI):=
    doc(concat($exist:root, $exist:controller, '/mss/',$filename))/*;
declare variable $lg as xs:string := (request:get-cookie-value('lg'), 'bg')[1];

declare function local:unit($unit as xs:string) as xs:string {
    switch($unit)
        case "folia" return "ff."
        case "folio" return "f."
        default return $unit
};
declare function local:computeExtent($ms as element(tei:TEI)) as xs:string {
    let $extent := $ms/descendant::tei:supportDesc/tei:extent
    let $measure := $extent/tei:measure
    let $folio_dimensions := $extent/tei:dimensions[@type='folia']
    let $written_dimensions := $extent/tei:dimensions[@type='written']
    let $unit := local:unit($measure/@unit)
    return 
        (concat($measure,' ',$unit),
        if ($folio_dimensions)
            then concat($folio_dimensions/tei:height, ' x ', $folio_dimensions/tei:width, ' ',
                $folio_dimensions/@unit, ' (folia)')
            else (),
        if ($written_dimensions)
            then 
                string-join(for $wd in $written_dimensions
                return concat($wd/tei:height,' x ', $wd/tei:width, ' (written',
                    if ($wd/@scope)
                        then concat (' ',$wd/@scope,')')
                        else ')'),', ')
            else()) => string-join(" ")
};
declare function local:process_watermark($watermark as element(tei:watermark)) as xs:string+ {
    if (not($watermark/*)) then re:titleCase(string($watermark)) else
    concat(
        re:titleCase($watermark/re:motif),
        if ($watermark/re:countermark) then concat(' with ',$watermark/re:countermark,'. ') else ' ',
        if ($watermark/tei:term) then concat(' ',$watermark/tei:term,' ') else ' ',
        if ($watermark/tei:ref) then
            let $refs :=
                for $w in $watermark/tei:ref
                let $author := substring($w/@target,5,string-length($w/@target) - 8)
                let $pubDate := substring($w/@target,string-length($w/@target) - 3)
                let $nums :=
                    if ($w/tei:num) then 
                        concat(
                            ': ',
                            string-join(
                                $w/tei:num ! concat(., ' (', following-sibling::tei:date[1],')'),
                                ', ')
                        )
                    else ()
                return concat($author,' ',$pubDate, $nums)
            return string-join($refs,'; ')
        else ()
    )
};
declare function local:process_collation($collation as element(tei:collation)) as item()* {
    if ($collation/tei:p) then concat(
        $collation/tei:p  ! re:titleCase(.) ! re:addPeriod(.), ' '
    )
    else (),
    if ($collation/tei:summary) then concat(
        $collation/tei:summary ! re:titleCase(.) ! re:addPeriod(.), ' '
    )
    else (),
    if ($collation/re:quire) then
        let $formula-parts :=
            for $quire in $collation/re:quire
                let $parts := tokenize($quire/@n, "-")
                let $preceding := tokenize($quire/preceding-sibling::re:quire[1]/@n, "-")[last()]
                let $extent := $quire/tei:extent ! string()
                return (
                    if (number($parts[1]) lt number($preceding)) then "+" else (),
                    $parts[1] ! re:roman(.),
                    <m:sup>{$extent}</m:sup>,
                    if ($parts[2]) then 
                        (concat("–", $parts[2] ! re:roman(.)), <m:sup>{$extent}</m:sup>)
                        else ())
        return <m:formula>{$formula-parts}. </m:formula>
    else (),
    (: no title casing because <signatures> may begin with lower-case 
    roman numeral that should be preserved :)
    if ($collation/tei:signatures) then <m:signatures>{concat(
        $collation/tei:signatures ! re:addPeriod(.), ' ')}</m:signatures>
    else (),
    if ($collation/tei:catchwords) then <m:catchwords>{concat(
        $collation/tei:catchwords ! re:titleCase(.) ! re:addPeriod(.), ' ')}</m:catchwords>
    else (),
    if ($collation/re:ruling) then <m:ruling>{concat(
        $collation/re:ruling ! re:titleCase(.) ! re:addPeriod(.), ' ')}</m:ruling>
    else (),
    if ($collation/re:pricking) then <m:pricking>{concat(
        $collation/re:pricking ! re:titleCase(.) ! re:addPeriod(.), ' ')}</m:pricking>
    else (),
    if ($collation/re:gregoryRule) then <m:gregoryRule>{concat(
        $collation/re:gregoryRule ! re:titleCase(.) ! re:addPeriod(.), ' ')}</m:gregoryRule>
    else ()
};
declare function local:useModelNamespace($node as node()) as item()* {
    (: Change all namespaces to m: but retain local name 
       Complex content is more easily managed with XSLT :)
    typeswitch($node)
        case text() return $node
        case element() return element { "m:" || local-name($node)} {
            $node/@*,
            for $child in $node/node() return local:useModelNamespace($child)
        }
        default return "ERROR"
};
declare function local:process_layoutDesc($layoutDesc as element(tei:layoutDesc)) as element(m:layout)+ {
    (: Ruled and written lines contains either one number or, for a range, two:)
    for $layout in $layoutDesc/tei:layout
        let $columns := $layout/@columns
        let $ruledLines := $layout/@ruledLines
        let $writtenLines := $layout/@writtenLines
    return
        <m:layout>{string-join((
        $columns ! concat($columns, ' column', if ($columns ne '1') then 's' else ()),
        $ruledLines ! concat(translate($ruledLines, ' ', '–'), ' ruled line',if ($ruledLines ne '1') then 's' else ()),
        $writtenLines ! concat(translate($writtenLines, ' ', '–'), ' written line',if ($writtenLines ne '1') then 's' else ()),
        if (string-length(normalize-space($layout)) gt 0) then $layout else ()), ', ') || "."
        }</m:layout>
};

<m:main>
<m:bgMsName>{re:bgMsName($ms)}</m:bgMsName>
<m:enMsName>{re:enMsName($ms)}</m:enMsName>
<m:ruMsName>{re:ruMsName($ms)}</m:ruMsName>
<!-- Must be exactly one country, zero or more other location parts -->
<m:location>
    <m:country>{$ms/descendant::tei:msIdentifier/tei:country ! string()}</m:country>
    {$ms/descendant::tei:msIdentifier/tei:settlement ! <m:settlement>{string(.)}</m:settlement>}
    {$ms/descendant::tei:msIdentifier/tei:repository ! <m:repository>{string(.)}</m:repository>}
    {$ms/descendant::tei:msIdentifier/tei:collection ! <m:collection>{string(.)}</m:collection>}
    {$ms/descendant::tei:msIdentifier/tei:idno[@type eq "shelfmark"] ! <m:shelfmark>{string(.)}</m:shelfmark>}
</m:location>
{$ms/descendant::tei:origDate ! string(.) ! re:titleCase(.) ! <m:date>{.}</m:date>}
{$ms/descendant::tei:material ! string(.) ! re:titleCase(.) ! <m:material>{.}</m:material>}
<m:extent>{local:computeExtent($ms)}</m:extent>
{if ($ms/descendant::tei:watermark) then 
    <m:watermarks>{
        $ms/descendant::tei:watermark ! <m:watermark>{local:process_watermark(.)}</m:watermark>
    }</m:watermarks>
    else ()}
{$ms/descendant::tei:foliation ! <m:foliation>{.}</m:foliation>}
<!-- Collation currently processes <quire> elements if present; may be removed from schema -->
{$ms/descendant::tei:collation ! <m:collation>{local:process_collation(.)}</m:collation>}
{$ms/descendant::tei:layoutDesc ! <m:layout>{local:process_layoutDesc(.)}</m:layout>}
{$ms/descendant::tei:binding ! <m:binding>{string(.)}</m:binding>}
{$ms/descendant::tei:condition ! <m:condition>{re:titleCase(.)}</m:condition>}
<!-- Change namespace of msItemStruct recursively to m: -->
{$ms/descendant::tei:msContents ! local:useModelNamespace(.)}
<m:bibliography>Bibliography will go here</m:bibliography>
<m:history>History will go here</m:history>
<m:id>{$ms/@xml:id ! string()}</m:id>
<m:authors>Authors will go here</m:authors>
<m:editors>Editors will go here</m:editors>
<m:genres>{$ms/descendant::tei:msName[@type ne "individual"] ! string() ! <m:genre>{.}</m:genre>}</m:genres>
<m:uri>{substring-before($filename, '.xml')}</m:uri>
<m:lg>{$lg}</m:lg>
</m:main>
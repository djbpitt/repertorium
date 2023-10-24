xquery version "3.1";

declare namespace tei = "http://www.tei-c.org/ns/1.0";
declare namespace m="http://repertorium.obdurodon.org/model";

import module namespace re = 'http://www.ilit.bas.bg/repertorium/ns/3.0' at "re-lib.xqm";
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
<m:watermark>Watermarks will go here</m:watermark>
<m:collation>Collation will go here</m:collation>
{$ms/descendant::tei:condition ! <m:condition>{re:titleCase(.)}</m:condition>}
<m:contents>Contents will go here</m:contents>
<m:bibliography>Bibliography will go here</m:bibliography>
<m:history>History will go here</m:history>
<m:id>{$ms/@xml:id ! string()}</m:id>
<m:authors>Authors will go here</m:authors>
<m:editors>Editors will go here</m:editors>
<m:genres>{$ms/descendant::tei:msName[@type ne "individual"] ! string() ! <m:genre>{.}</m:genre>}</m:genres>
<m:uri>{substring-before($filename, '.xml')}</m:uri>
<m:lg>{$lg}</m:lg>
</m:main>
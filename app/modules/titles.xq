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
{$ms/descendant::tei:msContents ! re:useModelNamespace(.)}
<m:id>{$ms/@xml:id ! string()}</m:id>
<m:authors>{$ms/descendant::tei:titleStmt/tei:author => string-join(", ")}</m:authors>
<m:editors>{$ms/descendant::tei:titleStmt/tei:editor => string-join(", ")}</m:editors>
<m:genres>{$ms/descendant::tei:msName[@type ne "individual"] ! string() ! <m:genre>{.}</m:genre>}</m:genres>
<m:uri>{substring-before($filename, '.xml')}</m:uri>
<m:lg>{$lg}</m:lg>
</m:main>
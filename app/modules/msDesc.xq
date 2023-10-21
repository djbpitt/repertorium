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
declare variable $ms as document-node() :=
    doc(concat($exist:root, $exist:controller, '/mss/',$filename));
declare variable $lg as xs:string := (request:get-cookie-value('lg'), 'bg')[1];
<m:main>
<m:uri>{substring-before($filename, '.xml')}</m:uri>
<m:bgMsName>{re:bgMsName($ms)}</m:bgMsName>
<m:enMsName>{re:enMsName($ms)}</m:enMsName>
<m:ruMsName>{re:ruMsName($ms)}</m:ruMsName>
<m:lg>{$lg}</m:lg>
</m:main>
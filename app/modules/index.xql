xquery version "3.1";
declare namespace m="http://www.obdurodon.org/model";
declare variable $exist:root as xs:string := request:get-parameter("exist:root", "xmldb:exist:///db/apps");
declare variable $exist:controller as xs:string := request:get-parameter("exist:controller", "/repertorium");
declare variable $path-to-data as xs:string := $exist:root || $exist:controller || '/data';
<m:index/>
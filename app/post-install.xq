xquery version "3.1";

import module namespace xdb = "http://exist-db.org/xquery/xmldb";

(: The following external variables are set by the repo:deploy function :)

(: file path pointing to the exist installation directory :)
declare variable $home external;
(: path to the directory containing the unpacked .xar package :)
declare variable $dir external;
(: the target collection into which the app is deployed :)
declare variable $target external;

declare variable $target-name as xs:string := concat($target, "/mss");
declare variable $target-collection as document-node()+ := collection($target-name);
for $d in $target-collection
let $resource-name as xs:anyURI := base-uri($d)
let $result as element() := transform:transform($d, doc(concat($target, "/util/add-article-titles.xsl")), ())
return
  xdb:store($target-name, $resource-name, $result)

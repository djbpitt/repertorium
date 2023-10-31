xquery version "3.1";

import module namespace xdb = "http://exist-db.org/xquery/xmldb";

(: The following external variables are set by the repo:deploy function :)

(: file path pointing to the exist installation directory :)
declare variable $home external;
(: path to the directory containing the unpacked .xar package :)
declare variable $dir external;
(: the target collection into which the app is deployed :)
declare variable $target external;

(:
 : Post-install process adds English and Russian article titles to msItemStruct elements
 : msItemStruct elements on input have only Bulgarian titles 
:)
declare variable $target-name as xs:string := concat($target, "/mss");
declare variable $target-collection as document-node()+ := collection($target-name);
(: document may have non-element children, so work with root element and not document node :)
for $d in $target-collection/*
let $resource-name as xs:anyURI := base-uri($d)
let $result as element() :=
transform:transform($d, doc(concat($target, "/util/add-article-titles.xsl")), ())
let $store-report := xdb:store($target-name, $resource-name, $result)
(: Uncomment first return statement for debugging (and comment out second return statement) :)
(:return
  util:log(
  "info",
  concat("Stored ", $resource-name, " into ", $target-name, " with result ", $store-report)
  ):)
  return true()
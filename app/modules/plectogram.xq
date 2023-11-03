xquery version "3.1";
(: ======================================================================= :)
(: Development notes 2023-11-03                                            :)
(:   Earlier version sorted mss by similarity according to dendrogram;     :)
(:     This version currently sorts by filename (arbitrarily, but the      :)
(:       is to ensure reproducible results                                 :)
(: ======================================================================= :)
(: Housekeeping                                                            :)
(: ======================================================================= :)
declare namespace tei = "http://www.tei-c.org/ns/1.0";
(:import module namespace re = "http://www.ilit.bas.bg/repertorium/ns/3.0" at 're-lib.xqm';:)
declare namespace output = "http://www.w3.org/2010/xslt-xquery-serialization";
declare option output:method "xml";
declare option output:indent "no";
declare %private variable $root-collection as xs:string :=
replace(system:get-module-load-path(), "xmldb:exist://embedded-eXist-server/", "/")
! substring-before(., "/modules");
(: ======================================================================= :)
(: Database resources: $all-mss, $all-titles                               :)
(: ======================================================================= :)
declare %private variable $all-titles as element(title)+ :=
doc(concat($root-collection, "/aux/titles.xml"))/descendant::title;
declare %private variable $all-mss as document-node()+ :=
collection(concat($root-collection, "/mss"))[ends-with(base-uri(.), ".xml")];
(: ======================================================================= :)
(: Plectogram constants                                                    :)
(: ======================================================================= :)
declare variable $columnSpacing as xs:integer := 129;
declare variable $boxWidth as xs:integer := 60;
declare variable $boxHeight as xs:integer := 17;
declare variable $textXShift as xs:integer := 2;
declare variable $textYShift as xs:integer := 14;
(: ======================================================================= :)
(: Form inputs                                                             :)
(: ======================================================================= :)
declare variable $ms-ids as xs:string* :=
request:get-parameter("items[]", ());
declare variable $mss as document-node()* := $all-mss[substring-after(tei:TEI/@xml:id, "RC-") = $ms-ids];
(: ======================================================================= :)
(: Main                                                                    :)
(: ======================================================================= :)
<items>{
    for $ms in $mss
    return
      <item>{$ms ! base-uri(.)}</item>
  }</items>
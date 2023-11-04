xquery version "3.1";
(: ======================================================================= :)
(: Development notes 2023-11-03                                            :)
(:                                                                         :)
(: Returns SVG inside <main> because better suited to XQuery than to XSLT  :)
(: Earlier version sorted mss by similarity according to dendrogram;       :)
(:     This version currently sorts by filename (arbitrarily, but ensures  :)
(:       reproducible results                                              :)
(: ======================================================================= :)
(: Housekeeping                                                            :)
(: ======================================================================= :)
declare namespace tei = "http://www.tei-c.org/ns/1.0";
declare namespace svg = "http://www.w3.org/2000/svg";
import module namespace re = "http://www.ilit.bas.bg/repertorium/ns/3.0" at 're-lib.xqm';
declare namespace output = "http://www.w3.org/2010/xslt-xquery-serialization";
declare option output:method "xml";
declare option output:indent "no";
declare %private variable $root-collection as xs:string :=
replace(system:get-module-load-path(), "xmldb:exist://embedded-eXist-server/", "/")
! substring-before(., "/modules");
(: ======================================================================= :)
(: Database resources: $all-mss, $all-titles                               :)
(: ======================================================================= :)
declare variable $all-titles as element(title)+ :=
doc(concat($root-collection, "/aux/titles.xml"))/descendant::title;
declare variable $all-mss as document-node()+ :=
collection(concat($root-collection, "/mss"))[ends-with(base-uri(.), ".xml")];
(: ======================================================================= :)
(: Plectogram constants                                                    :)
(: ======================================================================= :)
declare variable $xShift := 129; (: shift whole plectogram right:)
declare variable $yShift := 45;
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
declare variable $id-query as xs:string := "id:(" || $ms-ids => string-join(" OR ") || ")";
(: ======================================================================= :)
(: Main                                                                    :)
(: ======================================================================= :)
declare variable $mss as element(tei:TEI)* := $all-mss/tei:TEI[ft:query(., $id-query)];
declare variable $width as xs:integer := count($mss) * $columnSpacing;
declare variable $max-cell-count as xs:integer := max($mss/descendant::tei:msItemStruct => count()) + 1;
<svg
  xmlns="http://www.w3.org/2000/svg"
  xmlns:xlink="http://www.w3.org/1999/xlink"
  width="{$width}"
  viewBox="0 0 {$width} {($max-cell-count + 3) * $boxHeight}">
  <!-- Links are temporary, for viewing without HTML wrapper -->
  <link
    xmlns="http://www.w3.org/1999/xhtml"
    rel="stylesheet"
    href="../resources/css/style.css"
    type="text/css"/> 
  <link
    xmlns="http://www.w3.org/1999/xhtml"
    rel="stylesheet"
    href="../resources/css/repertorium.css"
    type="text/css"/>
  <g
    id="main_svg"
    transform="translate(-100)">
    <g>{
        for $ms at $pos in $mss
        let $filename as xs:string := base-uri($ms) ! tokenize(., "/")[last()]
        let $ms-texts as xs:string+ :=
        $ms/descendant::tei:msItemStruct/tei:title[lang("bg")] ! string()
        let $previous-ms-pos as xs:integer := $pos - 1
        let $previous-ms as element(tei:TEI)? := if ($previous-ms-pos > 0) then
          $mss[$previous-ms-pos]
        else
          ()
        let $previous-ms-texts as xs:string* :=
        if ($previous-ms) then
          $previous-ms/descendant::tei:msItemStruct/tei:title[lang("bg")] ! string()
        else
          ()
        return
          <g
            id="{$filename}"
            class="draggable"
            transform="translate({($pos - 1) * $columnSpacing + $xShift})">
            <image
              x="{($boxWidth - 25) div 2}"
              y="0"
              height="20"
              width="20"
              xlink:href="../resources/images/drag-icon-djb-dev.svg"/>
            <text
              x="{$boxWidth div 2}"
              y="45"
              text-anchor="middle">
              <a
                xlink:href="search?filename={$filename}">{$filename}</a></text>
            <g
              transform="translate(0,{$yShift})">{
                for $ms-text at $text-pos in $ms-texts
                let $box-label := $all-titles/Q{}bg[. eq $ms-text]/../Q{}en
                return
                  <g
                    class="cx">
                    <rect
                      class="cx)"
                      x="0"
                      y="{$text-pos * $boxHeight}"
                      width="{$boxWidth}"
                      height="{$boxHeight}"
                      title="Placeholder">
                      <text
                        x="{$textXShift}"
                        y="{$text-pos * $boxHeight + $textYShift}">{$box-label}</text>
                    </rect>
                  </g>
              }</g>
          </g>
      }</g>
  </g></svg>

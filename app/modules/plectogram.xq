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
declare option output:indent "yes";
declare %private variable $root-collection as xs:string :=
replace(system:get-module-load-path(), "xmldb:exist://embedded-eXist-server/", "/")
! substring-before(., "/modules");
(: ======================================================================= :)
(: Database resources: $all-mss, $all-bg-titles, hex-ref field in titles   :)
(: ======================================================================= :)
declare variable $all-bg-titles as element(bg)+ :=
doc(concat($root-collection, "/aux/titles.xml"))/descendant::bg;
declare variable $all-mss as document-node()+ :=
collection(concat($root-collection, "/mss"))[ends-with(base-uri(.), ".xml")];
declare variable $hex-ref-field as map(*) :=
map {
  "fields": "hex-ref"
};
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
  <g
    id="main_svg"
    transform="translate(-100)">
    <g
      id="columns">{
        for $ms at $ms-pos in $mss
        let $filename as xs:string := base-uri($ms) ! tokenize(., "/")[last()]
        let $ms-texts as element(tei:msItemStruct)+ :=
        $ms/descendant::tei:msItemStruct
        let $previous-ms-pos as xs:integer := $ms-pos - 1
        (: will be empty if no previous ms :)
        let $previous-ms as element(tei:TEI)? := $mss[$previous-ms-pos]
        let $previous-ms-texts as element(tei:msItemStruct)* := $previous-ms/descendant::tei:msItemStruct
        return
          <g
            id="{$filename}"
            class="draggable"
            transform="translate({($ms-pos - 1) * $columnSpacing + $xShift})">
            <image
              x="{($boxWidth - 25) div 2}"
              y="0"
              height="20"
              width="20"
              xlink:href="resources/images/drag-icon-djb-dev.svg"/>
            <a
              xlink:href="titles?filename={$filename}">
              <text
                x="{$boxWidth div 2}"
                y="45"
                text-anchor="middle">{$filename}</text>
            </a>
            <g
              transform="translate(0,{$yShift})">{
                for $ms-text at $text-pos in $ms-texts
                let $ms-bg-title as element(tei:title) := $ms-text/tei:title[@xml:lang eq "bg"]
                let $matching-bg-title as element(Q{}bg) := $all-bg-titles[. eq $ms-bg-title]
                let $box-label := $matching-bg-title/parent::Q{}title
                /preceding-sibling::*
                => count()
                => re:decimal-to-hex() => re:left-pad(4, '0')
                return
                  (<g
                    class="c{$box-label}">
                    <rect
                      class="c{$box-label})"
                      x="0"
                      y="{$text-pos * $boxHeight}"
                      width="{$boxWidth}"
                      height="{$boxHeight}"
                      title="{$box-label}">
                    </rect>
                    <text
                      x="{$textXShift}"
                      y="{$text-pos * $boxHeight + $textYShift}">{$box-label}</text>
                  </g>,
                  for $hit in ($previous-ms-texts)[tei:title eq $ms-bg-title]
                  let $prev-y-pos as xs:integer := sum(
                  (count($hit/preceding::tei:msItemStruct),
                  count($hit/ancestor::tei:msItemStruct),
                  1))
                  return
                    <line
                    (: TODO: y2 :)
                    (: 1 is right, 2 is left :)
                      class="c{$box-label}"
                      x1="{($ms-pos - 1) * $columnSpacing + $xShift}"
                      y1="{($text-pos + 0.5) * $boxHeight + $yShift}"
                      x2="{($ms-pos - 2) * $columnSpacing + $boxWidth + $xShift}"
                      y2="{($prev-y-pos + 0.5) * $boxHeight + $yShift}"
                    />
                  )
              }</g>
          </g>
      }</g>
  </g></svg>

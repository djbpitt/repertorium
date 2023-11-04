xquery version "3.1";
module namespace re = "http://www.ilit.bas.bg/repertorium/ns/3.0";
declare namespace tei = "http://www.tei-c.org/ns/1.0";
declare namespace m = "http://repertorium.obdurodon.org/model";

(: Temporary copy in aux directory because eXist-db cannot navigate upward in location hint :)

declare function re:decimal-to-hex($in as xs:integer) as xs:string {
  (: https://www.oxygenxml.com/archives/xsl-list/200902/msg00214.html :)
  if ($in eq 0) then
    "0"
  else
    concat(
    if ($in gt 16) then
      re:decimal-to-hex($in idiv 16)
    else
      "",
    substring("0123456789ABCDEF", ($in mod 16) + 1, 1))
};

declare function re:left-pad(
$inputString as xs:string?,
$outputLength as xs:integer,
$padChar as xs:string
) as xs:string {
  (: Breaks if $outputLength is less than the length of $inputString :)
  let $fullyPadded as xs:string := string-join((1 to $outputLength) ! $padChar) || $inputString
  return
    substring($fullyPadded, string-length($fullyPadded) - $outputLength + 1)
};

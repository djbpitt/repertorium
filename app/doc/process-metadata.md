# Process metadata

## XQuery filenaming

1. Main modules have filename extensions *.xq*. This includes *controller.xq* and *pre-install.xq*.
2. Library modules have filename extensions *.xqm*

## Project namespaces

* Model namespace: `http://repertorium.obdurodon.org/model`
* Function namespace: `http://www.ilit.bas.bg/repertorium/ns/3.0` (library is *re-lib.xqm*)

## FAIR

* Hex labels for texts in plectograms are not persistent, but the title texts are

## Code comments

### Article titles in plectogram cells

When a plectogram is constructed the title is mapped to a four-digit hex value, which is rendered
as the content of the rectangle and used (with a one-character prefix) as the associated `@class`
value. The numerical value corresponds to the ordinal position of the title in *titles.xml*. The
hex value is currently computed at query time (see below), but might be moved to a Lucene field.

To retrieve the title text on mouseover a JavaScript routine converts the hex value to decimal with
`parseInt(value, 16)` and passes it as the `$offset` parameter to an Ajax routine that retrieves
the title by offset in *titles.xml*, using the `lg` cookie value to select the title in the 
appropriate language. The value is currently returned as an XML element in no namespace (`<bg>`, 
`<en>`, or `<ru>`); that could (should?) be changed to a string, which would require changing the 
`<xsl:output>` specification of the XSLT that processes the Ajax call.

Currently the hex value that is rendered in the plectogram is computed at query time, but it could instead
be specified in a Lucene field. This would require using the Lucene keyword index, which, in turn, would
require using the XML (not Lucene) syntax to specify the query, since the Lucene syntax cannot be 
prevented from tokenizing the query on wrhitespace. The lookup time with keyword vs range index (which 
is what is currently used) when the plectogram is created is likely to be comparable (both are based on 
Lucene), but the computation of the hex value at index time with the keyword index is likely to reduce 
the query time.
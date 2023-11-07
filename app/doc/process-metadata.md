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

When a plectogram is constructed the article titles are mapped to four-digit hex values, which are
rendered as the content of the rectangles and used (with a one-character prefix) as the associated 
`@class` value. The numerical value corresponds to the ordinal position of the title in *titles.xml*. 
The hex value is currently computed at query time (see below), but might be moved to a Lucene field, 
which would entail using the Lucene keyword index (keyword because the full title is unique, and should
not be tokenized) to access the fields.

To retrieve the title text on mouseover a JavaScript routine converts the hex value to decimal with
`parseInt(value, 16)` and passes it as the `$offset` parameter to an Ajax routine that retrieves
the title by offset in *titles.xml*, using the `lg` cookie value to select the title in the 
appropriate language. The title is returned as a string.

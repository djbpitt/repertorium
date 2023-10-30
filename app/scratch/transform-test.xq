xquery version "3.1";
(: xml, xsl, and xq files are all in the same collection inside the database :)
(: fn:transform() example fails to find stylesheet;
   error message is:
   err:FODC0002 Location '/transform-test.xsl' returns an item 
     which is not a document node [at line 6, column 16, 
     source: String/-4771563225784395555];
   see https://github.com/eXist-db/exist/issues/5052 :)
(:let $result := transform( map { 
    "source-node" : doc("transform-test.xml"),
    "stylesheet-location": "transform-test.xsl"
})
return $result?output//body:)

(: transform:transform() works as expected :)
transform:transform(doc("transform-test.xml"), doc("transform-test.xsl"), ())
xquery version "3.1";
declare default function namespace "http://www.w3.org/2005/xpath-functions";
declare default element namespace "http://www.w3.org/1999/xhtml";
declare namespace xi="http://www.w3.org/2001/XInclude";
declare namespace output = "http://www.w3.org/2010/xslt-xquery-serialization";
declare option output:method "xml";
declare option output:media-type "application/xhtml+xml";
declare option output:omit-xml-declaration "no";
declare option output:indent "no";
declare variable $title as xs:string := "My awesome eXist-db app";
declare variable $exist:root as xs:string := request:get-parameter("exist:root", ());
(:declare variable $exist:prefix as xs:string := request:get-parameter("exist:prefix", ());:)
declare variable $exist:controller as xs:string := request:get-parameter("exist:controller", ());
(:declare variable $exist:path as xs:string := request:get-parameter("exist:path", ());:)
(:declare variable $exist:resource as xs:string := request:get-parameter("exist:resource", ());:)
(:declare variable $uri as xs:string := request:get-parameter("uri", ());:)
(:declare variable $context as xs:string := request:get-parameter("context", ());:)

<html xmlns="http://www.w3.org/1999/xhtml">
    <xi:include href="{concat(
        $exist:root, 
        $exist:controller, 
        '/includes/header.xql?title=', 
        encode-for-uri($title), 
        '&amp;exist:controller=', 
        $exist:controller,
        '&amp;exist:root=',
        $exist:root
    )}"/>
    <body>
        <h1>{$title}</h1>
        <p>Content will go here</p>
    </body>
</html>
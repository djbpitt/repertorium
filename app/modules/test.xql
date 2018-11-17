xquery version "3.1";
declare default function namespace "http://www.w3.org/2005/xpath-functions";
declare default element namespace "http://www.w3.org/1999/xhtml";
declare namespace xi = "http://www.w3.org/2001/XInclude";
declare namespace output = "http://www.w3.org/2010/xslt-xquery-serialization";
declare option output:method "xml";
declare option output:media-type "application/xhtml+xml";
declare option output:omit-xml-declaration "no";
declare option output:indent "no";
declare variable $title as xs:string := "eXist-db variables available to XQuery scripts";
declare variable $exist:root as xs:string := request:get-parameter("exist:root", ());
declare variable $exist:prefix as xs:string := request:get-parameter("exist:prefix", ());
declare variable $exist:controller as xs:string := request:get-parameter("exist:controller", ());
declare variable $exist:path as xs:string := request:get-parameter("exist:path", ());
declare variable $exist:resource as xs:string := request:get-parameter("exist:resource", ());
declare variable $uri as xs:string := request:get-parameter("uri", ());
declare variable $context as xs:string := request:get-parameter("context", ());
declare variable $fqcontroller as xs:string := concat($context, $exist:prefix, $exist:controller, '/');

<html
    xmlns="http://www.w3.org/1999/xhtml">
    <xi:include
        href="{
                concat(
                $exist:root,
                $exist:controller,
                '/includes/header.xql?title=',
                encode-for-uri($title),
                '&amp;fqcontroller=',
                $fqcontroller
                )
            }"/>
    <body>
        <h1>{$title}</h1>
        <table>
            <tr><th>Variable</th><th>Value</th></tr>
            <tr><td><code>$title</code></td><td>{$title}</td></tr>
            <tr><td><code>$exist:root</code></td><td>{$exist:root}</td></tr>
            <tr><td><code>$exist:prefix</code></td><td>{$exist:prefix}</td></tr>
            <tr><td><code>$exist:controller</code></td><td>{$exist:controller}</td></tr>
            <tr><td><code>$exist:path</code></td><td>{$exist:path}</td></tr>
            <tr><td><code>$exist:resource</code></td><td>{$exist:resource}</td></tr>
            <tr><td><code>$uri</code> (from <code>request:get-uri()</code>)</td><td>{$uri}</td></tr>
            <tr><td><code>$context</code> (from <code>request:get-context-path()</code>)</td><td>{$context}</td></tr>
            <tr><td><code>$fqcontroller</code><br/>(<code>concat($context, $exist:prefix, $exist:controller, '/')</code>)</td><td>{$fqcontroller}</td></tr>
        </table>
    </body>
</html>
xquery version "3.1";
declare default function namespace "http://www.w3.org/2005/xpath-functions";
declare default element namespace "http://www.w3.org/1999/xhtml";
declare namespace xi = "http://www.w3.org/2001/XInclude";
declare namespace output = "http://www.w3.org/2010/xslt-xquery-serialization";
declare option output:method "xml";
declare option output:media-type "application/xhtml+xml";
declare option output:omit-xml-declaration "no";
declare option output:indent "no";
declare option output:doctype-system "about:legacy-compat";
declare variable $exist:root as xs:string := request:get-attribute("$exist:root");
declare variable $exist:prefix as xs:string := request:get-attribute("$exist:prefix");
declare variable $exist:controller as xs:string := request:get-attribute("$exist:controller");
declare variable $exist:path as xs:string := request:get-attribute("$exist:path");
declare variable $exist:resource as xs:string := request:get-attribute("$exist:resource");
declare variable $module-load-path as xs:string := system:get-module-load-path();
declare variable $uri as xs:string := request:get-uri() ! string();
declare variable $context as xs:string := request:get-context-path();
declare variable $fqcontroller as xs:string := concat($context, $exist:prefix, $exist:controller, '/');

<html
  xmlns="http://www.w3.org/1999/xhtml">
  <head>
    <title>Controller variables</title>
    <link
      rel="stylesheet"
      type="text/css"
      href="resources/css/style.css"/>
    <style>
      code {{background-color: transparent;}}
    </style>
  </head>
  <body>
    <h1>Application variables</h1>
    <h2>eXist-db controller variables and related properties</h2>
    <p>Controller variables (beginning with <samp>$exist:</samp>) are available only if the URL is processed
      by the controller.</p>
    <table>
      <tr><th>Variable</th><th>Expression</th><th>Value</th></tr>
      <tr><td>$exist:root</td><td><samp>request:get-attribute("$exist:root)"</samp></td><td><samp>{$exist:root}</samp></td></tr>
      <tr><td><samp>$exist:prefix</samp></td><td><samp>request:get-attribute("$exist:prefix)"</samp></td><td><samp>{$exist:prefix}</samp></td></tr>
      <tr><td><samp>$exist:controller</samp></td><td><samp>request:get-attribute("$exist:controller)"</samp></td><td><samp>{$exist:controller}</samp></td></tr>
      <tr><td><samp>$exist:path</samp></td><td><samp>request:get-attribute("$exist:path)"</samp></td><td><samp>{$exist:path}</samp></td></tr>
      <tr><td><samp>$exist:resource</samp></td><td><samp>request:get-attribute("$exist:resource)"</samp></td><td><samp>{$exist:resource}</samp></td></tr>
      <tr><td>(none)</td><td><samp>concat($context, $exist:prefix, $exist:controller, '/'</samp>)</td><td><samp>{$fqcontroller}</samp></td></tr>
      <tr><td>(none)</td><td><samp>system:get-module-load-path()</samp></td><td><samp>{$module-load-path}</samp></td></tr>
      <tr><td>(none)</td><td><samp>request:get-uri()</samp></td><td><samp>{$uri}</samp></td></tr>
      <tr><td>(none)</td><td><samp>request:get-context-path()</samp></td><td><samp>{$context}</samp></td></tr>
    </table>
    <h2>JavaScript window.location properties</h2>
    <table>
      <tr><th>Expression</th><th>Value</th></tr>
      <!-- https://css-tricks.com/snippets/javascript/get-url-and-url-parts-in-javascript/ -->
      <tr><td><samp>window.location.href</samp></td><td><samp
            id="href"></samp></td></tr>
      <tr><td><samp>window.location.protocol</samp></td><td><samp
            id="protocol"></samp></td></tr>
      <tr><td><samp>window.location.host</samp></td><td><samp
            id="host"></samp></td></tr>
      <tr><td><samp>window.location.hostname</samp></td><td><samp
            id="hostname"></samp></td></tr>
      <tr><td><samp>window.location.port</samp></td><td><samp
            id="port"></samp></td></tr>
      <tr><td><samp>window.location.origin</samp></td><td><samp
            id="origin"></samp></td></tr>
      <tr><td><samp>window.location.pathname</samp></td><td><samp
            id="pathname"></samp></td></tr>
      <tr><td><samp>window.location.hash</samp></td><td><samp
            id="hash"></samp></td></tr>
      <tr><td><samp>window.location.search</samp></td><td><samp
            id="search"></samp></td></tr>
    </table>
    <script>window.onload = function()
      {{
      document.getElementById("protocol").innerHTML = window.location.protocol;
      document.getElementById("href").innerHTML = window.location.href;
      document.getElementById("host").innerHTML = window.location.host;
      document.getElementById("port").innerHTML = window.location.port;
      document.getElementById("hostname").innerHTML = window.location.hostname;
      document.getElementById("origin").innerHTML = window.location.origin;
      document.getElementById("pathname").innerHTML = window.location.pathname;
      document.getElementById("hash").innerHTML = window.location.hash;
      document.getElementById("search").innerHTML = window.location.search;
      }}
    </script>
  
  </body>
</html>
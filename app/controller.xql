xquery version "3.1";
declare namespace html="http://www.w3.org/1999/xhtml";

declare variable $exist:root external;
declare variable $exist:prefix external;
declare variable $exist:controller external;
declare variable $exist:path external;
declare variable $exist:resource external;

declare variable $uri as xs:anyURI := request:get-uri();
(: ==========
Variables used to construct path to CSS for jetty
========== :)
declare variable $context as xs:string := request:get-context-path();
declare variable $fqcontroller as xs:string := concat($context, $exist:prefix, $exist:controller, '/');
declare variable $lg as xs:string? := request:get-cookie-value('lg');

if ($exist:resource eq '') 
then
    <dispatch xmlns="http://exist.sourceforge.net/NS/exist">
        <redirect url="index"/>
    </dispatch>
else 
if (not(contains($exist:resource, '.')))
then
    <dispatch xmlns="http://exist.sourceforge.net/NS/exist">
        <forward url="{concat($exist:controller, '/modules', $exist:path, '.xql')}">
            <set-attribute name="xquery.attribute" value="model"/>
            <add-parameter name="exist:root" value="{$exist:root}"/>
            <add-parameter name="exist:prefix" value="{$exist:prefix}"/>
            <add-parameter name="exist:path" value="{$exist:path}"/>
            <add-parameter name="exist:controller" value="{$exist:controller}"/>
            <add-parameter name="exist:resource" value="{$exist:resource}"/>
            <add-parameter name="context" value="{$context}"/>
            <add-parameter name="fqcontroller" value="{$fqcontroller}"/>
        </forward>
        <view>
            (:transformation to html is different for different modules:)
            <forward servlet="XSLTServlet">
                <set-attribute name="xslt.input" value="model"/>
                <set-attribute name="xslt.stylesheet" value="{concat($exist:root, $exist:controller, '/views/', $exist:path, '-to-html.xsl')}"/>
                <set-attribute name="xslt.fqcontroller" value="{$fqcontroller}"/>
                <set-attribute name="xslt.lg" value="{($lg, 'bg')[1]}"/>
            </forward>
            {if (starts-with($exist:resource, 'ajax')) then () else
            <forward servlet="XSLTServlet">
                <clear-attribute name="xslt.input"/>
                <set-attribute name="xslt.stylesheet" value="{concat($exist:root, $exist:controller, '/views/wrapper.xsl')}"/>
                <set-attribute name="xslt.fqcontroller" value="{$fqcontroller}"/>
                <set-attribute name="xslt.resource" value="{$exist:resource}"/>
                <set-attribute name="xslt.lg" value="{($lg, 'bg')[1]}"/>
            </forward>}
        </view>
        <cache-control cache="no"/>
    </dispatch>
else
    <ignore xmlns="http://exist.sourceforge.net/NS/exist">
        <cache-control cache="yes"/>
    </ignore>

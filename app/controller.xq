xquery version "3.1";
declare namespace m="http://menology.obdurodon.org/model";

declare variable $exist:root external;
declare variable $exist:prefix external;
declare variable $exist:controller external;
declare variable $exist:path external;
declare variable $exist:resource external;

declare variable $uri as xs:anyURI := request:get-uri();
declare variable $context as xs:string := request:get-context-path();
declare variable $fqcontroller as xs:string := concat($context, $exist:prefix, $exist:controller, '/');
declare variable $query-filename as xs:string? := request:get-parameter("filename", ());

if ($exist:resource eq '') then
    <dispatch xmlns="http://exist.sourceforge.net/NS/exist">
        <redirect url="index"/>
    </dispatch>
else
    if (not(contains($exist:resource, '.')))
    then
        <dispatch xmlns="http://exist.sourceforge.net/NS/exist">
            <forward url="{concat($exist:controller, '/modules', $exist:path, '.xq')}"/>
        <view>
            (:transformation to html is different for different modules:)
            <forward servlet="XSLTServlet">
                <set-attribute name="xslt.input" value="model"/>
                <set-attribute name="xslt.stylesheet" value="{concat($exist:root, $exist:controller, '/xslt', $exist:path, '-to-html.xsl')}"/>
                <set-attribute name="xslt.fqcontroller" value="{$fqcontroller}"/>
            </forward>
            {if (starts-with($exist:resource, 'ajax')) then () else
            <forward servlet="XSLTServlet">
                <clear-attribute name="xslt.input"/>
                <set-attribute name="xslt.stylesheet" value="{concat($exist:root, $exist:controller, '/xslt/wrapper.xsl')}"/>
                <set-attribute name="xslt.fqcontroller" value="{$fqcontroller}"/>
                <set-attribute name="xslt.query-filename" value="{$query-filename}"/>
            </forward>}
        </view>
            <cache-control cache="no"/>
        </dispatch>
    else
        <ignore xmlns="http://exist.sourceforge.net/NS/exist">
            <cache-control cache="yes"/>
        </ignore>
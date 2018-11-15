xquery version "3.1" encoding "UTF-8";

(: External variables available to the controller:
 : $exist:root
 :      The path to where the app is installed, typically xmldb:exist:///db/apps
 : $exist:prefix
 :      The location within the database, specified in controller-config.xml on the
 :      server, where eXist begins looking for a controller, typically /apps 
 : $exist:controller
 :      The part of the URL leading from the prefix (typically /apps) to the controller 
 :      script. Often the root collection of the app, for example: /repertorium
 : $exist:path
 :      The part of the URL below the controller to the request resource. For example: 
 :      /a/b/c.xq.
 : $exist:resource
 :      The part of the URL after the last / character, usually pointing to a 
 :      resource. For example: c.xq
 : :)
declare variable $exist:root external;
declare variable $exist:prefix external;
declare variable $exist:controller external;
declare variable $exist:path external;
declare variable $exist:resource external;

(: Other variables 
 : $uri
 :      
 : :)
declare variable $uri as xs:anyURI := request:get-uri();
declare variable $context as xs:string := request:get-context-path();
declare variable $home-page-url as xs:string := "index";

(: Function to get the extension of a filename: :)
declare function local:get-extension($filename as xs:string) as xs:string {
    let $name := replace($filename, ".*[/\\]([^/\\]+)$", "$1")
    return
        if (contains($name, "."))
        then
            replace($name, ".*\.([^\.]+)$", "$1")
        else
            ""
};

(: If there is no resource specified, go to the home page.
This is a redirect, forcing the browser to perform a redirect. So this request
will pass through the controller again... :)
if ($exist:resource eq "") then
    <dispatch xmlns="http://exist.sourceforge.net/NS/exist">
        <redirect url="{$home-page-url}"/>
    </dispatch>
    
(: Check if there is no extension. If not, assume it is an XQuery file and located
 : in the modules subcollection. Because we use forward here, the browser will not be 
informed of the change and the user will see a URL without the "modules/" step in the
path and with the ".xql" extension. :)
else
if (local:get-extension($exist:resource) eq "") then
    <dispatch xmlns="http://exist.sourceforge.net/NS/exist">
        <forward url="{concat(
            $exist:controller, 
            substring-before($exist:path, $exist:resource), 
            "modules/", 
            $exist:resource, 
            ".xql"
        )}">
            <add-parameter name="exist:root" value="{$exist:root}"/>
            <add-parameter name="exist:prefix" value="{$exist:prefix}"/>
            <add-parameter name="exist:controller" value="{$exist:controller}"/>
            <add-parameter name="exist:path" value="{$exist:path}"/>
            <add-parameter name="exist:resource" value="{$exist:resource}"/>
            <add-parameter name="uri" value="{$uri}"/>
            <add-parameter name="context" value="{$context}"/>
        </forward>
    </dispatch>
(: Anything else, pass through: :)
    else
        <ignore xmlns="http://exist.sourceforge.net/NS/exist">
            <cache-control cache="yes"/>
        </ignore>
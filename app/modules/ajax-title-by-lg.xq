xquery version "3.1";
declare variable $all_titles as document-node() := doc('/db/apps/repertorium/aux/titles.xml');
declare variable $lg as xs:string := (request:get-cookie-value('lg'), 'bg')[1];
declare variable $offset as xs:integer := request:get-parameter("offset", 1) cast as xs:integer;
declare variable $result as element() := $all_titles/descendant::title[number($offset)]/*[local-name() eq $lg];
(:(response:set-header('Access-Control-Allow-Origin','http://repertorium.obdurodon.org'),
$result) :)
$result
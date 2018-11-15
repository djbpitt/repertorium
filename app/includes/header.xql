xquery version "3.1";
declare variable $title external;
declare variable $fqcontroller external;
<head xmlns="http://www.w3.org/1999/xhtml">
    <title>{$title}</title>
    <link rel="stylesheet" type="text/css" href="{concat($fqcontroller, 'resources/css/style.css')}"/> 
    <link rel="stylesheet" type="text/css" href="{concat($fqcontroller, 'resources/css/repertorium.css')}"/> 
</head>

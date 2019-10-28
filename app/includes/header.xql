xquery version "3.1";
declare namespace xi = "http://www.w3.org/2001/XInclude";
declare variable $title external;
declare variable $fqcontroller external;
<head
    xmlns="http://www.w3.org/1999/xhtml">
    <title>{$title}</title>
    <link
        rel="stylesheet"
        type="text/css"
        href="{concat($fqcontroller, 'resources/css/style.css')}"/>
    <link
        rel="stylesheet"
        type="text/css"
        href="{concat($fqcontroller, 'resources/css/repertorium.css')}"/>
    <link
        rel="shortcut icon"
        href="{concat($fqcontroller, 'resources/images/favicon.ico')}"/>
    <script
        type="text/javascript"
        src="{concat($fqcontroller, 'resources/js/lgToggle.js')}"></script>
</head>

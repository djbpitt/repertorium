xquery version "3.1";
let $date-time := current-dateTime() ! string()
return <hi>{$date-time}</hi>
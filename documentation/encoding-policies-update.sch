<?xml version="1.0" encoding="UTF-8"?>
<sch:schema xmlns:sch="http://purl.oclc.org/dsdl/schematron" queryBinding="xslt2"
    xmlns:sqf="http://www.schematron-quickfix.com/validator/process">
    <sch:ns prefix="html" uri="http://www.w3.org/1999/xhtml"/>
    <sch:let name="pointers" value="//html:nav/html:ul/html:li/html:a/@href/substring(., 2)"/>
    <sch:let name="targets" value="//html:section/@id/string()"/>
    <sch:pattern>
        <sch:rule context="html:nav/html:ul/html:li/@a">
            <sch:assert test="substring(., 2) = $targets"><sch:value-of select="."/> is a link but
                not a target.</sch:assert>
        </sch:rule>
        <sch:rule context="html:section/@id">
            <sch:assert test=". = $pointers"><sch:value-of select="."/> is a target but not a
                pointer</sch:assert>
        </sch:rule>
    </sch:pattern>
</sch:schema>

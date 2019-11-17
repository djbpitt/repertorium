<?xml version="1.0" encoding="UTF-8"?>
<sch:schema xmlns:sch="http://purl.oclc.org/dsdl/schematron"
    xmlns:sqf="http://www.schematron-quickfix.com/validator/process"
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform" queryBinding="xslt2"
    xmlns:tei="http://www.tei-c.org/ns/1.0" xmlns:re="http://www.ilit.bas.bg/repertorium/ns/3.0/"
    xml:lang="en">
    <sch:ns uri="http://www.tei-c.org/ns/1.0" prefix="tei"/>
    <sch:ns uri="http://www.ilit.bas.bg/repertorium/ns/3.0" prefix="re"/>
    <sch:pattern id="Repertorium-specific_rules">
        <sch:p>Rules used only in the Repertorium (not, e.g., in Zograph)</sch:p>
        <sch:rule context="tei:textClass/tei:keywords">
            <sch:assert test="@scheme eq 'Repertorium'">textClass/@keywords must have the value
                'Repertorium'; the current value is <sch:value-of select="@scheme"/></sch:assert>
        </sch:rule>
    </sch:pattern>
</sch:schema>

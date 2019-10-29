<?xml version="1.0" encoding="UTF-8"?>
<sch:schema xmlns:sch="http://purl.oclc.org/dsdl/schematron" queryBinding="xslt2"
    xmlns:sqf="http://www.schematron-quickfix.com/validator/process">
    <sch:pattern>
        <sch:rule context="text()">
            <sch:report test="matches(., '[&#xe000;-&#xfbff;]')">PUA characters not
                permitted</sch:report>
        </sch:rule>
    </sch:pattern>
</sch:schema>

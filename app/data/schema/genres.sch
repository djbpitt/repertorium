<?xml version="1.0" encoding="UTF-8"?>
<schema xmlns="http://purl.oclc.org/dsdl/schematron" queryBinding="xslt2">
  <pattern>
    <rule context="bg">
      <report
        test="normalize-space(lower-case(.)) = ../following-sibling::genre/bg/normalize-space(lower-case(.))"
        >Duplicate bg value</report>
    </rule>
    <rule context="en">
      <report
        test="normalize-space(lower-case(.)) = ../following-sibling::genre/en/normalize-space(lower-case(.))"
        >Duplicate en value</report>
    </rule>
    <rule context="ru">
      <report
        test="normalize-space(lower-case(.)) = ../following-sibling::genre/ru/normalize-space(lower-case(.))"
        >Duplicate ru value</report>
    </rule>
  </pattern>
</schema>

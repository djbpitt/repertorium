<?xml version="1.0" encoding="ISO-8859-1"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:xs="http://www.w3.org/2001/XMLSchema"
                xmlns:test="http://www.jenitennison.com/xslt/unit-test"
                xmlns:x="http://www.jenitennison.com/xslt/xspec"
                xmlns:__x="http://www.w3.org/1999/XSL/TransformAliasAlias"
                xmlns:pkg="http://expath.org/ns/pkg"
                xmlns:impl="urn:x-xspec:compile:xslt:impl"
                xmlns:re="http://www.ilit.bas.bg/repertorium/ns/3.0"
                version="2"
                exclude-result-prefixes="pkg impl">
   <xsl:import href="file:/Users/djb/repos/repertorium/stanka/stanka_lib.xsl"/>
   <xsl:import href="file:/Users/djb/Library/Preferences/com.oxygenxml/extensions/v21.1/frameworks/https___www.oxygenxml.com_InstData_Addons_community_updateSite.xml/xspec.support-1.2.1/src/compiler/generate-tests-utils.xsl"/>
   <xsl:import href="file:/Users/djb/Library/Preferences/com.oxygenxml/extensions/v21.1/frameworks/https___www.oxygenxml.com_InstData_Addons_community_updateSite.xml/xspec.support-1.2.1/src/schematron/sch-location-compare.xsl"/>
   <xsl:namespace-alias stylesheet-prefix="__x" result-prefix="xsl"/>
   <xsl:variable name="x:stylesheet-uri"
                 as="xs:string"
                 select="'file:/Users/djb/repos/repertorium/stanka/stanka_lib.xsl'"/>
   <xsl:output name="x:report" method="xml" indent="yes"/>
   <xsl:template name="x:main">
      <xsl:message>
         <xsl:text>Testing with </xsl:text>
         <xsl:value-of select="system-property('xsl:product-name')"/>
         <xsl:text> </xsl:text>
         <xsl:value-of select="system-property('xsl:product-version')"/>
      </xsl:message>
      <xsl:result-document format="x:report">
         <xsl:processing-instruction name="xml-stylesheet">type="text/xsl" href="file:/Users/djb/Library/Preferences/com.oxygenxml/extensions/v21.1/frameworks/https___www.oxygenxml.com_InstData_Addons_community_updateSite.xml/xspec.support-1.2.1/src/compiler/format-xspec-report.xsl"</xsl:processing-instruction>
         <x:report stylesheet="{$x:stylesheet-uri}"
                   date="{current-dateTime()}"
                   xspec="file:/Users/djb/repos/repertorium/stanka/stanka_lib.xspec">
            <xsl:call-template name="x:d5e2"/>
            <xsl:call-template name="x:d5e12"/>
            <xsl:call-template name="x:d5e21"/>
            <xsl:call-template name="x:d5e30"/>
            <xsl:call-template name="x:d5e34"/>
         </x:report>
      </xsl:result-document>
   </xsl:template>
   <xsl:template name="x:d5e2">
      <xsl:message>Scenario for testing function month-day-from-gMonthDay</xsl:message>
      <x:scenario>
         <x:label>Scenario for testing function month-day-from-gMonthDay</x:label>
         <xsl:call-template name="x:d5e3"/>
         <xsl:call-template name="x:d5e7"/>
      </x:scenario>
   </xsl:template>
   <xsl:template name="x:d5e3">
      <xsl:message>..February 3 test</xsl:message>
      <x:scenario>
         <x:label>February 3 test</x:label>
         <x:call function="re:month-day-from-gMonthDay">
            <x:param name="in" select="'--02-03'"/>
         </x:call>
         <xsl:variable name="x:result" as="item()*">
            <xsl:variable select="'--02-03'" name="in"/>
            <xsl:sequence select="re:month-day-from-gMonthDay($in)"/>
         </xsl:variable>
         <xsl:call-template name="test:report-value">
            <xsl:with-param name="value" select="$x:result"/>
            <xsl:with-param name="wrapper-name" select="'x:result'"/>
            <xsl:with-param name="wrapper-ns" select="'http://www.jenitennison.com/xslt/xspec'"/>
         </xsl:call-template>
         <xsl:call-template name="x:d5e6">
            <xsl:with-param name="x:result" select="$x:result"/>
         </xsl:call-template>
      </x:scenario>
   </xsl:template>
   <xsl:template name="x:d5e6">
      <xsl:param name="x:result" required="yes"/>
      <xsl:message>Format --MM-DD as 'February 3'</xsl:message>
      <xsl:variable select="'February 3'" name="impl:expected"/>
      <xsl:variable name="impl:successful"
                    as="xs:boolean"
                    select="test:deep-equal($impl:expected, $x:result, 2)"/>
      <xsl:if test="not($impl:successful)">
         <xsl:message>      FAILED</xsl:message>
      </xsl:if>
      <x:test successful="{$impl:successful}">
         <x:label>Format --MM-DD as 'February 3'</x:label>
         <xsl:call-template name="test:report-value">
            <xsl:with-param name="value" select="$impl:expected"/>
            <xsl:with-param name="wrapper-name" select="'x:expect'"/>
            <xsl:with-param name="wrapper-ns" select="'http://www.jenitennison.com/xslt/xspec'"/>
         </xsl:call-template>
      </x:test>
   </xsl:template>
   <xsl:template name="x:d5e7">
      <xsl:message>..November 3 test</xsl:message>
      <x:scenario>
         <x:label>November 3 test</x:label>
         <x:call function="re:month-day-from-gMonthDay">
            <x:param name="in" select="'--11-03'"/>
         </x:call>
         <xsl:variable name="x:result" as="item()*">
            <xsl:variable select="'--11-03'" name="in"/>
            <xsl:sequence select="re:month-day-from-gMonthDay($in)"/>
         </xsl:variable>
         <xsl:call-template name="test:report-value">
            <xsl:with-param name="value" select="$x:result"/>
            <xsl:with-param name="wrapper-name" select="'x:result'"/>
            <xsl:with-param name="wrapper-ns" select="'http://www.jenitennison.com/xslt/xspec'"/>
         </xsl:call-template>
         <xsl:call-template name="x:d5e10">
            <xsl:with-param name="x:result" select="$x:result"/>
         </xsl:call-template>
      </x:scenario>
   </xsl:template>
   <xsl:template name="x:d5e10">
      <xsl:param name="x:result" required="yes"/>
      <xsl:message>Format --MM-DD as 'February 3'</xsl:message>
      <xsl:variable select="'November 3'" name="impl:expected"/>
      <xsl:variable name="impl:successful"
                    as="xs:boolean"
                    select="test:deep-equal($impl:expected, $x:result, 2)"/>
      <xsl:if test="not($impl:successful)">
         <xsl:message>      FAILED</xsl:message>
      </xsl:if>
      <x:test successful="{$impl:successful}">
         <x:label>Format --MM-DD as 'February 3'</x:label>
         <xsl:call-template name="test:report-value">
            <xsl:with-param name="value" select="$impl:expected"/>
            <xsl:with-param name="wrapper-name" select="'x:expect'"/>
            <xsl:with-param name="wrapper-ns" select="'http://www.jenitennison.com/xslt/xspec'"/>
         </xsl:call-template>
      </x:test>
   </xsl:template>
   <xsl:template name="x:d5e12">
      <xsl:message>Scenario for testing function sort-gMonthDay</xsl:message>
      <x:scenario>
         <x:label>Scenario for testing function sort-gMonthDay</x:label>
         <xsl:call-template name="x:d5e13"/>
         <xsl:call-template name="x:d5e17"/>
      </x:scenario>
   </xsl:template>
   <xsl:template name="x:d5e13">
      <xsl:message>..Dates start in reverse order</xsl:message>
      <x:scenario>
         <x:label>Dates start in reverse order</x:label>
         <x:call function="re:sort-gMonthDay">
            <x:param name="in"
                     select="'--03-08', '--02-03', '--10-03', '--09-30', '--09-01'"/>
         </x:call>
         <xsl:variable name="x:result" as="item()*">
            <xsl:variable select="'--03-08', '--02-03', '--10-03', '--09-30', '--09-01'"
                          name="in"/>
            <xsl:sequence select="re:sort-gMonthDay($in)"/>
         </xsl:variable>
         <xsl:call-template name="test:report-value">
            <xsl:with-param name="value" select="$x:result"/>
            <xsl:with-param name="wrapper-name" select="'x:result'"/>
            <xsl:with-param name="wrapper-ns" select="'http://www.jenitennison.com/xslt/xspec'"/>
         </xsl:call-template>
         <xsl:call-template name="x:d5e16">
            <xsl:with-param name="x:result" select="$x:result"/>
         </xsl:call-template>
      </x:scenario>
   </xsl:template>
   <xsl:template name="x:d5e16">
      <xsl:param name="x:result" required="yes"/>
      <xsl:message>Sort gMonthDay by September calendar</xsl:message>
      <xsl:variable select="'--09-01', '--09-30', '--10-03', '--02-03', '--03-08'"
                    name="impl:expected"/>
      <xsl:variable name="impl:successful"
                    as="xs:boolean"
                    select="test:deep-equal($impl:expected, $x:result, 2)"/>
      <xsl:if test="not($impl:successful)">
         <xsl:message>      FAILED</xsl:message>
      </xsl:if>
      <x:test successful="{$impl:successful}">
         <x:label>Sort gMonthDay by September calendar</x:label>
         <xsl:call-template name="test:report-value">
            <xsl:with-param name="value" select="$impl:expected"/>
            <xsl:with-param name="wrapper-name" select="'x:expect'"/>
            <xsl:with-param name="wrapper-ns" select="'http://www.jenitennison.com/xslt/xspec'"/>
         </xsl:call-template>
      </x:test>
   </xsl:template>
   <xsl:template name="x:d5e17">
      <xsl:message>..Dates start in correct order</xsl:message>
      <x:scenario>
         <x:label>Dates start in correct order</x:label>
         <x:call function="re:sort-gMonthDay">
            <x:param name="in"
                     select="'--09-01', '--09-30', '--10-03', '--02-03', '--03-08'"/>
         </x:call>
         <xsl:variable name="x:result" as="item()*">
            <xsl:variable select="'--09-01', '--09-30', '--10-03', '--02-03', '--03-08'"
                          name="in"/>
            <xsl:sequence select="re:sort-gMonthDay($in)"/>
         </xsl:variable>
         <xsl:call-template name="test:report-value">
            <xsl:with-param name="value" select="$x:result"/>
            <xsl:with-param name="wrapper-name" select="'x:result'"/>
            <xsl:with-param name="wrapper-ns" select="'http://www.jenitennison.com/xslt/xspec'"/>
         </xsl:call-template>
         <xsl:call-template name="x:d5e20">
            <xsl:with-param name="x:result" select="$x:result"/>
         </xsl:call-template>
      </x:scenario>
   </xsl:template>
   <xsl:template name="x:d5e20">
      <xsl:param name="x:result" required="yes"/>
      <xsl:message>Sort gMonthDay by September calendar</xsl:message>
      <xsl:variable select="'--09-01', '--09-30', '--10-03', '--02-03', '--03-08'"
                    name="impl:expected"/>
      <xsl:variable name="impl:successful"
                    as="xs:boolean"
                    select="test:deep-equal($impl:expected, $x:result, 2)"/>
      <xsl:if test="not($impl:successful)">
         <xsl:message>      FAILED</xsl:message>
      </xsl:if>
      <x:test successful="{$impl:successful}">
         <x:label>Sort gMonthDay by September calendar</x:label>
         <xsl:call-template name="test:report-value">
            <xsl:with-param name="value" select="$impl:expected"/>
            <xsl:with-param name="wrapper-name" select="'x:expect'"/>
            <xsl:with-param name="wrapper-ns" select="'http://www.jenitennison.com/xslt/xspec'"/>
         </xsl:call-template>
      </x:test>
   </xsl:template>
   <xsl:template name="x:d5e21">
      <xsl:message>Scenario for testing function septemberize</xsl:message>
      <x:scenario>
         <x:label>Scenario for testing function septemberize</x:label>
         <xsl:call-template name="x:d5e22"/>
         <xsl:call-template name="x:d5e26"/>
      </x:scenario>
   </xsl:template>
   <xsl:template name="x:d5e22">
      <xsl:message>..Month is February</xsl:message>
      <x:scenario>
         <x:label>Month is February</x:label>
         <x:call function="re:septemberize">
            <x:param name="in" select="'--02-03'"/>
         </x:call>
         <xsl:variable name="x:result" as="item()*">
            <xsl:variable select="'--02-03'" name="in"/>
            <xsl:sequence select="re:septemberize($in)"/>
         </xsl:variable>
         <xsl:call-template name="test:report-value">
            <xsl:with-param name="value" select="$x:result"/>
            <xsl:with-param name="wrapper-name" select="'x:result'"/>
            <xsl:with-param name="wrapper-ns" select="'http://www.jenitennison.com/xslt/xspec'"/>
         </xsl:call-template>
         <xsl:call-template name="x:d5e25">
            <xsl:with-param name="x:result" select="$x:result"/>
         </xsl:call-template>
      </x:scenario>
   </xsl:template>
   <xsl:template name="x:d5e25">
      <xsl:param name="x:result" required="yes"/>
      <xsl:message>Add 1 to January through August</xsl:message>
      <xsl:variable select="'--14-03'" name="impl:expected"/>
      <xsl:variable name="impl:successful"
                    as="xs:boolean"
                    select="test:deep-equal($impl:expected, $x:result, 2)"/>
      <xsl:if test="not($impl:successful)">
         <xsl:message>      FAILED</xsl:message>
      </xsl:if>
      <x:test successful="{$impl:successful}">
         <x:label>Add 1 to January through August</x:label>
         <xsl:call-template name="test:report-value">
            <xsl:with-param name="value" select="$impl:expected"/>
            <xsl:with-param name="wrapper-name" select="'x:expect'"/>
            <xsl:with-param name="wrapper-ns" select="'http://www.jenitennison.com/xslt/xspec'"/>
         </xsl:call-template>
      </x:test>
   </xsl:template>
   <xsl:template name="x:d5e26">
      <xsl:message>..Month is October</xsl:message>
      <x:scenario>
         <x:label>Month is October</x:label>
         <x:call function="re:septemberize">
            <x:param name="in" select="'--10-03'"/>
         </x:call>
         <xsl:variable name="x:result" as="item()*">
            <xsl:variable select="'--10-03'" name="in"/>
            <xsl:sequence select="re:septemberize($in)"/>
         </xsl:variable>
         <xsl:call-template name="test:report-value">
            <xsl:with-param name="value" select="$x:result"/>
            <xsl:with-param name="wrapper-name" select="'x:result'"/>
            <xsl:with-param name="wrapper-ns" select="'http://www.jenitennison.com/xslt/xspec'"/>
         </xsl:call-template>
         <xsl:call-template name="x:d5e29">
            <xsl:with-param name="x:result" select="$x:result"/>
         </xsl:call-template>
      </x:scenario>
   </xsl:template>
   <xsl:template name="x:d5e29">
      <xsl:param name="x:result" required="yes"/>
      <xsl:message>Don&#x2019;t add 1 to October through December</xsl:message>
      <xsl:variable select="'--10-03'" name="impl:expected"/>
      <xsl:variable name="impl:successful"
                    as="xs:boolean"
                    select="test:deep-equal($impl:expected, $x:result, 2)"/>
      <xsl:if test="not($impl:successful)">
         <xsl:message>      FAILED</xsl:message>
      </xsl:if>
      <x:test successful="{$impl:successful}">
         <x:label>Don&#x2019;t add 1 to October through December</x:label>
         <xsl:call-template name="test:report-value">
            <xsl:with-param name="value" select="$impl:expected"/>
            <xsl:with-param name="wrapper-name" select="'x:expect'"/>
            <xsl:with-param name="wrapper-ns" select="'http://www.jenitennison.com/xslt/xspec'"/>
         </xsl:call-template>
      </x:test>
   </xsl:template>
   <xsl:template name="x:d5e30">
      <xsl:message>Scenario for testing function getMonth</xsl:message>
      <x:scenario>
         <x:label>Scenario for testing function getMonth</x:label>
         <x:call function="re:getMonth">
            <x:param name="in" select="'--02-03'"/>
         </x:call>
         <xsl:variable name="x:result" as="item()*">
            <xsl:variable select="'--02-03'" name="in"/>
            <xsl:sequence select="re:getMonth($in)"/>
         </xsl:variable>
         <xsl:call-template name="test:report-value">
            <xsl:with-param name="value" select="$x:result"/>
            <xsl:with-param name="wrapper-name" select="'x:result'"/>
            <xsl:with-param name="wrapper-ns" select="'http://www.jenitennison.com/xslt/xspec'"/>
         </xsl:call-template>
         <xsl:call-template name="x:d5e33">
            <xsl:with-param name="x:result" select="$x:result"/>
         </xsl:call-template>
      </x:scenario>
   </xsl:template>
   <xsl:template name="x:d5e33">
      <xsl:param name="x:result" required="yes"/>
      <xsl:message>Extract month from gMonthDay</xsl:message>
      <xsl:variable select="'02'" name="impl:expected"/>
      <xsl:variable name="impl:successful"
                    as="xs:boolean"
                    select="test:deep-equal($impl:expected, $x:result, 2)"/>
      <xsl:if test="not($impl:successful)">
         <xsl:message>      FAILED</xsl:message>
      </xsl:if>
      <x:test successful="{$impl:successful}">
         <x:label>Extract month from gMonthDay</x:label>
         <xsl:call-template name="test:report-value">
            <xsl:with-param name="value" select="$impl:expected"/>
            <xsl:with-param name="wrapper-name" select="'x:expect'"/>
            <xsl:with-param name="wrapper-ns" select="'http://www.jenitennison.com/xslt/xspec'"/>
         </xsl:call-template>
      </x:test>
   </xsl:template>
   <xsl:template name="x:d5e34">
      <xsl:message>Scenario for testing function gMonthDay-from-month-day</xsl:message>
      <x:scenario>
         <x:label>Scenario for testing function gMonthDay-from-month-day</x:label>
         <xsl:call-template name="x:d5e35"/>
         <xsl:call-template name="x:d5e39"/>
         <xsl:call-template name="x:d5e43"/>
      </x:scenario>
   </xsl:template>
   <xsl:template name="x:d5e35">
      <xsl:message>..Month is February</xsl:message>
      <x:scenario>
         <x:label>Month is February</x:label>
         <x:call function="re:gMonthDay-from-month-day">
            <x:param name="in" select="'February 3'"/>
         </x:call>
         <xsl:variable name="x:result" as="item()*">
            <xsl:variable select="'February 3'" name="in"/>
            <xsl:sequence select="re:gMonthDay-from-month-day($in)"/>
         </xsl:variable>
         <xsl:call-template name="test:report-value">
            <xsl:with-param name="value" select="$x:result"/>
            <xsl:with-param name="wrapper-name" select="'x:result'"/>
            <xsl:with-param name="wrapper-ns" select="'http://www.jenitennison.com/xslt/xspec'"/>
         </xsl:call-template>
         <xsl:call-template name="x:d5e38">
            <xsl:with-param name="x:result" select="$x:result"/>
         </xsl:call-template>
      </x:scenario>
   </xsl:template>
   <xsl:template name="x:d5e38">
      <xsl:param name="x:result" required="yes"/>
      <xsl:message>Convert February to 2</xsl:message>
      <xsl:variable select="'--02-03'" name="impl:expected"/>
      <xsl:variable name="impl:successful"
                    as="xs:boolean"
                    select="test:deep-equal($impl:expected, $x:result, 2)"/>
      <xsl:if test="not($impl:successful)">
         <xsl:message>      FAILED</xsl:message>
      </xsl:if>
      <x:test successful="{$impl:successful}">
         <x:label>Convert February to 2</x:label>
         <xsl:call-template name="test:report-value">
            <xsl:with-param name="value" select="$impl:expected"/>
            <xsl:with-param name="wrapper-name" select="'x:expect'"/>
            <xsl:with-param name="wrapper-ns" select="'http://www.jenitennison.com/xslt/xspec'"/>
         </xsl:call-template>
      </x:test>
   </xsl:template>
   <xsl:template name="x:d5e39">
      <xsl:message>..Month is September</xsl:message>
      <x:scenario>
         <x:label>Month is September</x:label>
         <x:call function="re:gMonthDay-from-month-day">
            <x:param name="in" select="'September 3'"/>
         </x:call>
         <xsl:variable name="x:result" as="item()*">
            <xsl:variable select="'September 3'" name="in"/>
            <xsl:sequence select="re:gMonthDay-from-month-day($in)"/>
         </xsl:variable>
         <xsl:call-template name="test:report-value">
            <xsl:with-param name="value" select="$x:result"/>
            <xsl:with-param name="wrapper-name" select="'x:result'"/>
            <xsl:with-param name="wrapper-ns" select="'http://www.jenitennison.com/xslt/xspec'"/>
         </xsl:call-template>
         <xsl:call-template name="x:d5e42">
            <xsl:with-param name="x:result" select="$x:result"/>
         </xsl:call-template>
      </x:scenario>
   </xsl:template>
   <xsl:template name="x:d5e42">
      <xsl:param name="x:result" required="yes"/>
      <xsl:message>Convert September to 9</xsl:message>
      <xsl:variable select="'--09-03'" name="impl:expected"/>
      <xsl:variable name="impl:successful"
                    as="xs:boolean"
                    select="test:deep-equal($impl:expected, $x:result, 2)"/>
      <xsl:if test="not($impl:successful)">
         <xsl:message>      FAILED</xsl:message>
      </xsl:if>
      <x:test successful="{$impl:successful}">
         <x:label>Convert September to 9</x:label>
         <xsl:call-template name="test:report-value">
            <xsl:with-param name="value" select="$impl:expected"/>
            <xsl:with-param name="wrapper-name" select="'x:expect'"/>
            <xsl:with-param name="wrapper-ns" select="'http://www.jenitennison.com/xslt/xspec'"/>
         </xsl:call-template>
      </x:test>
   </xsl:template>
   <xsl:template name="x:d5e43">
      <xsl:message>..Month is October</xsl:message>
      <x:scenario>
         <x:label>Month is October</x:label>
         <x:call function="re:gMonthDay-from-month-day">
            <x:param name="in" select="'October 3'"/>
         </x:call>
         <xsl:variable name="x:result" as="item()*">
            <xsl:variable select="'October 3'" name="in"/>
            <xsl:sequence select="re:gMonthDay-from-month-day($in)"/>
         </xsl:variable>
         <xsl:call-template name="test:report-value">
            <xsl:with-param name="value" select="$x:result"/>
            <xsl:with-param name="wrapper-name" select="'x:result'"/>
            <xsl:with-param name="wrapper-ns" select="'http://www.jenitennison.com/xslt/xspec'"/>
         </xsl:call-template>
         <xsl:call-template name="x:d5e46">
            <xsl:with-param name="x:result" select="$x:result"/>
         </xsl:call-template>
      </x:scenario>
   </xsl:template>
   <xsl:template name="x:d5e46">
      <xsl:param name="x:result" required="yes"/>
      <xsl:message>Convert October to 10</xsl:message>
      <xsl:variable select="'--10-03'" name="impl:expected"/>
      <xsl:variable name="impl:successful"
                    as="xs:boolean"
                    select="test:deep-equal($impl:expected, $x:result, 2)"/>
      <xsl:if test="not($impl:successful)">
         <xsl:message>      FAILED</xsl:message>
      </xsl:if>
      <x:test successful="{$impl:successful}">
         <x:label>Convert October to 10</x:label>
         <xsl:call-template name="test:report-value">
            <xsl:with-param name="value" select="$impl:expected"/>
            <xsl:with-param name="wrapper-name" select="'x:expect'"/>
            <xsl:with-param name="wrapper-ns" select="'http://www.jenitennison.com/xslt/xspec'"/>
         </xsl:call-template>
      </x:test>
   </xsl:template>
</xsl:stylesheet>

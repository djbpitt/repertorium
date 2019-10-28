<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:impl="urn:x-xspec:compile:xslt:impl"
                xmlns:test="http://www.jenitennison.com/xslt/unit-test"
                xmlns:xs="http://www.w3.org/2001/XMLSchema"
                xmlns:x="http://www.jenitennison.com/xslt/xspec"
                xmlns:re="http://www.ilit.bas.bg/repertorium/ns/3.0"
                version="2.0"
                exclude-result-prefixes="impl">
   <xsl:import href="file:/Users/djb/repos/repertorium/stanka/stanka_lib.xsl"/>
   <xsl:import href="file:/Users/djb/repos/xspec/src/compiler/generate-tests-utils.xsl"/>
   <xsl:import href="file:/Users/djb/repos/xspec/src/schematron/sch-location-compare.xsl"/>
   <xsl:include href="file:/Users/djb/repos/xspec/src/common/xspec-utils.xsl"/>
   <xsl:output name="x:report" method="xml" indent="yes"/>
   <xsl:variable name="x:xspec-uri" as="xs:anyURI">file:/Users/djb/repos/repertorium/stanka/stanka_lib.xspec</xsl:variable>
   <xsl:template name="x:main">
      <xsl:message>
         <xsl:text>Testing with </xsl:text>
         <xsl:value-of select="system-property('xsl:product-name')"/>
         <xsl:text> </xsl:text>
         <xsl:value-of select="system-property('xsl:product-version')"/>
      </xsl:message>
      <xsl:result-document format="x:report">
         <xsl:processing-instruction name="xml-stylesheet">type="text/xsl" href="file:/Users/djb/repos/xspec/src/reporter/format-xspec-report.xsl"</xsl:processing-instruction>
         <x:report stylesheet="file:/Users/djb/repos/repertorium/stanka/stanka_lib.xsl"
                   date="{current-dateTime()}"
                   xspec="file:/Users/djb/repos/repertorium/stanka/stanka_lib.xspec">
            <xsl:call-template name="x:d6e2"/>
            <xsl:call-template name="x:d6e11"/>
            <xsl:call-template name="x:d6e15"/>
            <xsl:call-template name="x:d6e24"/>
            <xsl:call-template name="x:d6e28"/>
         </x:report>
      </xsl:result-document>
   </xsl:template>
   <xsl:template name="x:d6e2">
      <xsl:message>Scenario for testing function month-day-from-gMonthDay</xsl:message>
      <x:scenario>
         <x:label>Scenario for testing function month-day-from-gMonthDay</x:label>
         <xsl:call-template name="x:d6e3"/>
         <xsl:call-template name="x:d6e7"/>
      </x:scenario>
   </xsl:template>
   <xsl:template name="x:d6e3">
      <xsl:message>..February 3 test</xsl:message>
      <x:scenario>
         <x:label>February 3 test</x:label>
         <x:call>
            <xsl:attribute name="function">re:month-day-from-gMonthDay</xsl:attribute>
            <x:param>
               <xsl:attribute name="name">in</xsl:attribute>
               <xsl:attribute name="select">'--02-03'</xsl:attribute>
            </x:param>
         </x:call>
         <xsl:variable name="x:result" as="item()*">
            <xsl:variable name="in" select="'--02-03'"/>
            <xsl:sequence select="re:month-day-from-gMonthDay($in)"/>
         </xsl:variable>
         <xsl:call-template name="test:report-sequence">
            <xsl:with-param name="sequence" select="$x:result"/>
            <xsl:with-param name="wrapper-name" as="xs:string">x:result</xsl:with-param>
         </xsl:call-template>
         <xsl:call-template name="x:d6e6">
            <xsl:with-param name="x:result" select="$x:result"/>
         </xsl:call-template>
      </x:scenario>
   </xsl:template>
   <xsl:template name="x:d6e6">
      <xsl:param name="x:result" required="yes"/>
      <xsl:message>Format --MM-DD as 'February 3'</xsl:message>
      <xsl:variable name="impl:expected" select="'February 3'"/>
      <xsl:variable name="impl:successful"
                    as="xs:boolean"
                    select="test:deep-equal($impl:expected, $x:result, '')"/>
      <xsl:if test="not($impl:successful)">
         <xsl:message>      FAILED</xsl:message>
      </xsl:if>
      <x:test successful="{$impl:successful}">
         <x:label>Format --MM-DD as 'February 3'</x:label>
         <xsl:call-template name="test:report-sequence">
            <xsl:with-param name="sequence" select="$impl:expected"/>
            <xsl:with-param name="wrapper-name" as="xs:string">x:expect</xsl:with-param>
            <xsl:with-param name="test" as="attribute(test)?"/>
         </xsl:call-template>
      </x:test>
   </xsl:template>
   <xsl:template name="x:d6e7">
      <xsl:message>..November 3 test</xsl:message>
      <x:scenario>
         <x:label>November 3 test</x:label>
         <x:call>
            <xsl:attribute name="function">re:month-day-from-gMonthDay</xsl:attribute>
            <x:param>
               <xsl:attribute name="name">in</xsl:attribute>
               <xsl:attribute name="select">'--11-03'</xsl:attribute>
            </x:param>
         </x:call>
         <xsl:variable name="x:result" as="item()*">
            <xsl:variable name="in" select="'--11-03'"/>
            <xsl:sequence select="re:month-day-from-gMonthDay($in)"/>
         </xsl:variable>
         <xsl:call-template name="test:report-sequence">
            <xsl:with-param name="sequence" select="$x:result"/>
            <xsl:with-param name="wrapper-name" as="xs:string">x:result</xsl:with-param>
         </xsl:call-template>
         <xsl:call-template name="x:d6e10">
            <xsl:with-param name="x:result" select="$x:result"/>
         </xsl:call-template>
      </x:scenario>
   </xsl:template>
   <xsl:template name="x:d6e10">
      <xsl:param name="x:result" required="yes"/>
      <xsl:message>Format --MM-DD as 'February 3'</xsl:message>
      <xsl:variable name="impl:expected" select="'November 3'"/>
      <xsl:variable name="impl:successful"
                    as="xs:boolean"
                    select="test:deep-equal($impl:expected, $x:result, '')"/>
      <xsl:if test="not($impl:successful)">
         <xsl:message>      FAILED</xsl:message>
      </xsl:if>
      <x:test successful="{$impl:successful}">
         <x:label>Format --MM-DD as 'February 3'</x:label>
         <xsl:call-template name="test:report-sequence">
            <xsl:with-param name="sequence" select="$impl:expected"/>
            <xsl:with-param name="wrapper-name" as="xs:string">x:expect</xsl:with-param>
            <xsl:with-param name="test" as="attribute(test)?"/>
         </xsl:call-template>
      </x:test>
   </xsl:template>
   <xsl:template name="x:d6e11">
      <xsl:message>Scenario for testing function sort-gMonthDay</xsl:message>
      <x:scenario>
         <x:label>Scenario for testing function sort-gMonthDay</x:label>
         <x:call>
            <xsl:attribute name="function">re:sort-gMonthDay</xsl:attribute>
            <x:param>
               <xsl:attribute name="name">in</xsl:attribute>
               <xsl:attribute name="select">'--09-30', '--03-08', '--09-01', '--02-03', '--10-03'</xsl:attribute>
            </x:param>
         </x:call>
         <xsl:variable name="x:result" as="item()*">
            <xsl:variable name="in"
                          select="'--09-30', '--03-08', '--09-01', '--02-03', '--10-03'"/>
            <xsl:sequence select="re:sort-gMonthDay($in)"/>
         </xsl:variable>
         <xsl:call-template name="test:report-sequence">
            <xsl:with-param name="sequence" select="$x:result"/>
            <xsl:with-param name="wrapper-name" as="xs:string">x:result</xsl:with-param>
         </xsl:call-template>
         <xsl:call-template name="x:d6e14">
            <xsl:with-param name="x:result" select="$x:result"/>
         </xsl:call-template>
      </x:scenario>
   </xsl:template>
   <xsl:template name="x:d6e14">
      <xsl:param name="x:result" required="yes"/>
      <xsl:message>Sort gMonthDay by September calendar</xsl:message>
      <xsl:variable name="impl:expected"
                    select="'--09-01', '--09-30', '--10-03', '--02-03', '--03-08'"/>
      <xsl:variable name="impl:successful"
                    as="xs:boolean"
                    select="test:deep-equal($impl:expected, $x:result, '')"/>
      <xsl:if test="not($impl:successful)">
         <xsl:message>      FAILED</xsl:message>
      </xsl:if>
      <x:test successful="{$impl:successful}">
         <x:label>Sort gMonthDay by September calendar</x:label>
         <xsl:call-template name="test:report-sequence">
            <xsl:with-param name="sequence" select="$impl:expected"/>
            <xsl:with-param name="wrapper-name" as="xs:string">x:expect</xsl:with-param>
            <xsl:with-param name="test" as="attribute(test)?"/>
         </xsl:call-template>
      </x:test>
   </xsl:template>
   <xsl:template name="x:d6e15">
      <xsl:message>Scenario for testing function septemberize</xsl:message>
      <x:scenario>
         <x:label>Scenario for testing function septemberize</x:label>
         <xsl:call-template name="x:d6e16"/>
         <xsl:call-template name="x:d6e20"/>
      </x:scenario>
   </xsl:template>
   <xsl:template name="x:d6e16">
      <xsl:message>..Month is February</xsl:message>
      <x:scenario>
         <x:label>Month is February</x:label>
         <x:call>
            <xsl:attribute name="function">re:septemberize</xsl:attribute>
            <x:param>
               <xsl:attribute name="name">in</xsl:attribute>
               <xsl:attribute name="select">'--02-03'</xsl:attribute>
            </x:param>
         </x:call>
         <xsl:variable name="x:result" as="item()*">
            <xsl:variable name="in" select="'--02-03'"/>
            <xsl:sequence select="re:septemberize($in)"/>
         </xsl:variable>
         <xsl:call-template name="test:report-sequence">
            <xsl:with-param name="sequence" select="$x:result"/>
            <xsl:with-param name="wrapper-name" as="xs:string">x:result</xsl:with-param>
         </xsl:call-template>
         <xsl:call-template name="x:d6e19">
            <xsl:with-param name="x:result" select="$x:result"/>
         </xsl:call-template>
      </x:scenario>
   </xsl:template>
   <xsl:template name="x:d6e19">
      <xsl:param name="x:result" required="yes"/>
      <xsl:message>Add 1 to January through August</xsl:message>
      <xsl:variable name="impl:expected" select="'--14-03'"/>
      <xsl:variable name="impl:successful"
                    as="xs:boolean"
                    select="test:deep-equal($impl:expected, $x:result, '')"/>
      <xsl:if test="not($impl:successful)">
         <xsl:message>      FAILED</xsl:message>
      </xsl:if>
      <x:test successful="{$impl:successful}">
         <x:label>Add 1 to January through August</x:label>
         <xsl:call-template name="test:report-sequence">
            <xsl:with-param name="sequence" select="$impl:expected"/>
            <xsl:with-param name="wrapper-name" as="xs:string">x:expect</xsl:with-param>
            <xsl:with-param name="test" as="attribute(test)?"/>
         </xsl:call-template>
      </x:test>
   </xsl:template>
   <xsl:template name="x:d6e20">
      <xsl:message>..Month is October</xsl:message>
      <x:scenario>
         <x:label>Month is October</x:label>
         <x:call>
            <xsl:attribute name="function">re:septemberize</xsl:attribute>
            <x:param>
               <xsl:attribute name="name">in</xsl:attribute>
               <xsl:attribute name="select">'--10-03'</xsl:attribute>
            </x:param>
         </x:call>
         <xsl:variable name="x:result" as="item()*">
            <xsl:variable name="in" select="'--10-03'"/>
            <xsl:sequence select="re:septemberize($in)"/>
         </xsl:variable>
         <xsl:call-template name="test:report-sequence">
            <xsl:with-param name="sequence" select="$x:result"/>
            <xsl:with-param name="wrapper-name" as="xs:string">x:result</xsl:with-param>
         </xsl:call-template>
         <xsl:call-template name="x:d6e23">
            <xsl:with-param name="x:result" select="$x:result"/>
         </xsl:call-template>
      </x:scenario>
   </xsl:template>
   <xsl:template name="x:d6e23">
      <xsl:param name="x:result" required="yes"/>
      <xsl:message>Don’t add 1 to October through December</xsl:message>
      <xsl:variable name="impl:expected" select="'--10-03'"/>
      <xsl:variable name="impl:successful"
                    as="xs:boolean"
                    select="test:deep-equal($impl:expected, $x:result, '')"/>
      <xsl:if test="not($impl:successful)">
         <xsl:message>      FAILED</xsl:message>
      </xsl:if>
      <x:test successful="{$impl:successful}">
         <x:label>Don’t add 1 to October through December</x:label>
         <xsl:call-template name="test:report-sequence">
            <xsl:with-param name="sequence" select="$impl:expected"/>
            <xsl:with-param name="wrapper-name" as="xs:string">x:expect</xsl:with-param>
            <xsl:with-param name="test" as="attribute(test)?"/>
         </xsl:call-template>
      </x:test>
   </xsl:template>
   <xsl:template name="x:d6e24">
      <xsl:message>Scenario for testing function getMonth</xsl:message>
      <x:scenario>
         <x:label>Scenario for testing function getMonth</x:label>
         <x:call>
            <xsl:attribute name="function">re:getMonth</xsl:attribute>
            <x:param>
               <xsl:attribute name="name">in</xsl:attribute>
               <xsl:attribute name="select">'--02-03'</xsl:attribute>
            </x:param>
         </x:call>
         <xsl:variable name="x:result" as="item()*">
            <xsl:variable name="in" select="'--02-03'"/>
            <xsl:sequence select="re:getMonth($in)"/>
         </xsl:variable>
         <xsl:call-template name="test:report-sequence">
            <xsl:with-param name="sequence" select="$x:result"/>
            <xsl:with-param name="wrapper-name" as="xs:string">x:result</xsl:with-param>
         </xsl:call-template>
         <xsl:call-template name="x:d6e27">
            <xsl:with-param name="x:result" select="$x:result"/>
         </xsl:call-template>
      </x:scenario>
   </xsl:template>
   <xsl:template name="x:d6e27">
      <xsl:param name="x:result" required="yes"/>
      <xsl:message>Extract month from gMonthDay</xsl:message>
      <xsl:variable name="impl:expected" select="'02'"/>
      <xsl:variable name="impl:successful"
                    as="xs:boolean"
                    select="test:deep-equal($impl:expected, $x:result, '')"/>
      <xsl:if test="not($impl:successful)">
         <xsl:message>      FAILED</xsl:message>
      </xsl:if>
      <x:test successful="{$impl:successful}">
         <x:label>Extract month from gMonthDay</x:label>
         <xsl:call-template name="test:report-sequence">
            <xsl:with-param name="sequence" select="$impl:expected"/>
            <xsl:with-param name="wrapper-name" as="xs:string">x:expect</xsl:with-param>
            <xsl:with-param name="test" as="attribute(test)?"/>
         </xsl:call-template>
      </x:test>
   </xsl:template>
   <xsl:template name="x:d6e28">
      <xsl:message>Scenario for testing function gMonthDay-from-month-day</xsl:message>
      <x:scenario>
         <x:label>Scenario for testing function gMonthDay-from-month-day</x:label>
         <xsl:call-template name="x:d6e29"/>
         <xsl:call-template name="x:d6e33"/>
         <xsl:call-template name="x:d6e37"/>
      </x:scenario>
   </xsl:template>
   <xsl:template name="x:d6e29">
      <xsl:message>..Month is February</xsl:message>
      <x:scenario>
         <x:label>Month is February</x:label>
         <x:call>
            <xsl:attribute name="function">re:gMonthDay-from-month-day</xsl:attribute>
            <x:param>
               <xsl:attribute name="name">in</xsl:attribute>
               <xsl:attribute name="select">'February 3'</xsl:attribute>
            </x:param>
         </x:call>
         <xsl:variable name="x:result" as="item()*">
            <xsl:variable name="in" select="'February 3'"/>
            <xsl:sequence select="re:gMonthDay-from-month-day($in)"/>
         </xsl:variable>
         <xsl:call-template name="test:report-sequence">
            <xsl:with-param name="sequence" select="$x:result"/>
            <xsl:with-param name="wrapper-name" as="xs:string">x:result</xsl:with-param>
         </xsl:call-template>
         <xsl:call-template name="x:d6e32">
            <xsl:with-param name="x:result" select="$x:result"/>
         </xsl:call-template>
      </x:scenario>
   </xsl:template>
   <xsl:template name="x:d6e32">
      <xsl:param name="x:result" required="yes"/>
      <xsl:message>Convert February to 2</xsl:message>
      <xsl:variable name="impl:expected" select="'--02-03'"/>
      <xsl:variable name="impl:successful"
                    as="xs:boolean"
                    select="test:deep-equal($impl:expected, $x:result, '')"/>
      <xsl:if test="not($impl:successful)">
         <xsl:message>      FAILED</xsl:message>
      </xsl:if>
      <x:test successful="{$impl:successful}">
         <x:label>Convert February to 2</x:label>
         <xsl:call-template name="test:report-sequence">
            <xsl:with-param name="sequence" select="$impl:expected"/>
            <xsl:with-param name="wrapper-name" as="xs:string">x:expect</xsl:with-param>
            <xsl:with-param name="test" as="attribute(test)?"/>
         </xsl:call-template>
      </x:test>
   </xsl:template>
   <xsl:template name="x:d6e33">
      <xsl:message>..Month is September</xsl:message>
      <x:scenario>
         <x:label>Month is September</x:label>
         <x:call>
            <xsl:attribute name="function">re:gMonthDay-from-month-day</xsl:attribute>
            <x:param>
               <xsl:attribute name="name">in</xsl:attribute>
               <xsl:attribute name="select">'September 3'</xsl:attribute>
            </x:param>
         </x:call>
         <xsl:variable name="x:result" as="item()*">
            <xsl:variable name="in" select="'September 3'"/>
            <xsl:sequence select="re:gMonthDay-from-month-day($in)"/>
         </xsl:variable>
         <xsl:call-template name="test:report-sequence">
            <xsl:with-param name="sequence" select="$x:result"/>
            <xsl:with-param name="wrapper-name" as="xs:string">x:result</xsl:with-param>
         </xsl:call-template>
         <xsl:call-template name="x:d6e36">
            <xsl:with-param name="x:result" select="$x:result"/>
         </xsl:call-template>
      </x:scenario>
   </xsl:template>
   <xsl:template name="x:d6e36">
      <xsl:param name="x:result" required="yes"/>
      <xsl:message>Convert September to 9</xsl:message>
      <xsl:variable name="impl:expected" select="'--09-03'"/>
      <xsl:variable name="impl:successful"
                    as="xs:boolean"
                    select="test:deep-equal($impl:expected, $x:result, '')"/>
      <xsl:if test="not($impl:successful)">
         <xsl:message>      FAILED</xsl:message>
      </xsl:if>
      <x:test successful="{$impl:successful}">
         <x:label>Convert September to 9</x:label>
         <xsl:call-template name="test:report-sequence">
            <xsl:with-param name="sequence" select="$impl:expected"/>
            <xsl:with-param name="wrapper-name" as="xs:string">x:expect</xsl:with-param>
            <xsl:with-param name="test" as="attribute(test)?"/>
         </xsl:call-template>
      </x:test>
   </xsl:template>
   <xsl:template name="x:d6e37">
      <xsl:message>..Month is October</xsl:message>
      <x:scenario>
         <x:label>Month is October</x:label>
         <x:call>
            <xsl:attribute name="function">re:gMonthDay-from-month-day</xsl:attribute>
            <x:param>
               <xsl:attribute name="name">in</xsl:attribute>
               <xsl:attribute name="select">'October 3'</xsl:attribute>
            </x:param>
         </x:call>
         <xsl:variable name="x:result" as="item()*">
            <xsl:variable name="in" select="'October 3'"/>
            <xsl:sequence select="re:gMonthDay-from-month-day($in)"/>
         </xsl:variable>
         <xsl:call-template name="test:report-sequence">
            <xsl:with-param name="sequence" select="$x:result"/>
            <xsl:with-param name="wrapper-name" as="xs:string">x:result</xsl:with-param>
         </xsl:call-template>
         <xsl:call-template name="x:d6e40">
            <xsl:with-param name="x:result" select="$x:result"/>
         </xsl:call-template>
      </x:scenario>
   </xsl:template>
   <xsl:template name="x:d6e40">
      <xsl:param name="x:result" required="yes"/>
      <xsl:message>Convert October to 10</xsl:message>
      <xsl:variable name="impl:expected" select="'--10-03'"/>
      <xsl:variable name="impl:successful"
                    as="xs:boolean"
                    select="test:deep-equal($impl:expected, $x:result, '')"/>
      <xsl:if test="not($impl:successful)">
         <xsl:message>      FAILED</xsl:message>
      </xsl:if>
      <x:test successful="{$impl:successful}">
         <x:label>Convert October to 10</x:label>
         <xsl:call-template name="test:report-sequence">
            <xsl:with-param name="sequence" select="$impl:expected"/>
            <xsl:with-param name="wrapper-name" as="xs:string">x:expect</xsl:with-param>
            <xsl:with-param name="test" as="attribute(test)?"/>
         </xsl:call-template>
      </x:test>
   </xsl:template>
</xsl:stylesheet>

<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    xmlns:math="http://www.w3.org/2005/xpath-functions/math" exclude-result-prefixes="#all"
    xmlns:re="http://www.ilit.bas.bg/repertorium/ns/3.0" version="3.0">
    <xsl:output method="xml" indent="yes"/>

    <!-- *-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*_*  -->
    <!-- re:month-day-from-gMonthDay()                                  -->
    <!-- Convert gMonthDay to "February 3" format                       -->
    <!--                                                                -->
    <!-- Input: Date in gMonthDay format as xs:string                   -->
    <!-- Returns: Date in "February 3" format as xs:string              -->
    <!-- Dependencies: re:getMonth                                      -->
    <!-- *-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*_*  -->
    <xsl:function name="re:month-day-from-gMonthDay" as="xs:string">
        <xsl:param name="in" as="xs:string"/>
        <xsl:variable name="month-names" as="xs:string+"
            select="
                'January', 'February', 'March', 'April',
                'May', 'June', 'July', 'August',
                'September', 'October', 'November', 'December'"/>
        <xsl:variable name="month-ordinal" as="xs:integer" select="xs:integer(substring($in, 3, 2))"/>
        <xsl:sequence
            select="string-join(($month-names[$month-ordinal], xs:integer(substring($in, 6))), ' ')"
        />
    </xsl:function>

    <!-- *-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*_*  -->
    <!-- re:sort-gMonthDay()                                            -->
    <!-- Sorts dates in gMonthDay format from September through August  -->
    <!--                                                                -->
    <!-- Input: Sequence of strings formatted as gMonthDay              -->
    <!-- Returns: Sequence sorted according to September calendar       -->
    <!-- Dependencies: re:septemberize                                  -->
    <!-- *-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*_*  -->
    <xsl:function name="re:sort-gMonthDay" as="item()*">
        <xsl:param name="in" as="xs:string+"/>
        <xsl:variable name="sorted" as="xs:string+">
            <xsl:for-each select="$in">
                <xsl:sort select="re:septemberize(.)"/>
                <xsl:sequence select="."/>
            </xsl:for-each>
        </xsl:variable>
        <xsl:sequence select="$sorted"/>
    </xsl:function>

    <!-- *-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*_*  -->
    <!-- re:sort-septemberize()                                         -->
    <!-- Adjust month number to sort by September calendar              -->
    <!--                                                                -->
    <!-- Input: Date in gMonthDay format as xs:string                   -->
    <!-- Returns: Date in gMonthDay format as string, but with month    -->
    <!--   adjusted to sort by September calendar                       -->
    <!-- Dependencies: re:getMonth                                      -->
    <!-- *-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*_*  -->
    <xsl:function name="re:septemberize" as="xs:string">
        <xsl:param name="in" as="xs:string"/>
        <xsl:variable name="month" as="xs:integer" select="xs:integer(re:getMonth($in))"/>
        <xsl:sequence
            select="
                format-number(if ($month lt 9) then
                    $month + 12
                else
                    $month, '00')"
        />
    </xsl:function>

    <!-- *-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*_*  -->
    <!-- re:sort-getMonth()                                             -->
    <!-- Extract month number from gMonthDay                            -->
    <!--                                                                -->
    <!-- Input: Date in gMonthDay format as xs:string                   -->
    <!-- Returns: Month as two-digit string                             -->
    <!-- Dependencies: None                                             -->
    <!-- *-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*_*  -->
    <xsl:function name="re:getMonth" as="xs:string">
        <xsl:param name="in" as="xs:string"/>
        <xsl:sequence select="substring($in, 3, 2)"/>
    </xsl:function>
</xsl:stylesheet>

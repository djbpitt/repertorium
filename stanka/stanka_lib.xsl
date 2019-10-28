<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    xmlns:math="http://www.w3.org/2005/xpath-functions/math" exclude-result-prefixes="#all"
    xmlns:tei="http://www.tei-c.org/ns/1.0" xpath-default-namespace="http://www.tei-c.org/ns/1.0"
    xmlns:re="http://www.ilit.bas.bg/repertorium/ns/3.0" version="3.0">
    <xsl:output method="xml" indent="yes"/>

    <!-- *-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*_*  -->
    <!-- Variables used in multiple functions                           -->
    <!-- *-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*_*  -->
    <xsl:variable name="month-names" as="xs:string+"
        select="
            'January', 'February', 'March', 'April',
            'May', 'June', 'July', 'August',
            'September', 'October', 'November', 'December'"/>

    <!-- *-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*_*  -->
    <!-- re:getAllDates() .                                             -->
    <!-- List of all dates in gMonthDay format from all mss             -->
    <!--                                                                -->
    <!-- Input: mss as document-node()+ .                               -->
    <!-- Returns: Dates in gMonthDay format as xs:string+               -->
    <!-- Dependencies: none                                             -->
    <!-- *-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*_*  -->
    <xsl:function name="re:getAllDates" as="xs:string+">
        <xsl:param name="mss" as="document-node()+"/>
        <xsl:sequence select="distinct-values($mss//msContents/msItemStruct/date/@when)"/>
    </xsl:function>

    <!-- *-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*_*  -->
    <!-- re:gMonthDay-from-month-day()                                  -->
    <!-- Convert from "February 3" format to gMonthDay                  -->
    <!--                                                                -->
    <!-- Input: Date in "February 3" format as xs:string                -->
    <!-- Returns: Date in gMonthDay format as xs:string                 -->
    <!-- Dependencies: none                                             -->
    <!-- Note: unused; remove?                                          -->
    <!-- *-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*_*  -->
    <xsl:function name="re:gMonthDay-from-month-day" as="xs:string">
        <xsl:param name="in" as="xs:string"/>
        <xsl:variable name="dateParts" as="xs:string+" select="tokenize($in, '\s+')"/>
        <xsl:sequence
            select="
                '--' ||
                format-number(index-of($month-names, $dateParts[1]), '00') ||
                '-' ||
                format-number(xs:integer($dateParts[2]), '00')"
        />
    </xsl:function>

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
    <!-- re:getEntry()                                                  -->
    <!-- Retrieve top-level <msItemStruct> for date in ms               -->
    <!--                                                                -->
    <!-- Input: $ms as document-node()                                  -->
    <!--        $qdate (query date) as xs:string() in gMonthDate format -->
    <!-- Returns: <msItemStruct> or ()                                  -->
    <!-- Dependencies: none                                             -->
    <!-- *-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*_*  -->
    <xsl:function name="re:getEntry" as="element(msItemStruct)?">
        <xsl:param name="ms" as="document-node()"/>
        <xsl:param name="qdate" as="xs:string"/>
        <xsl:variable name="results" as="element(msItemStruct)*"
            select="$ms//msContents/msItemStruct[date/@when eq $qdate]"/>
        <xsl:sequence select="($results)"/>
    </xsl:function>

    <!-- *-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*_*  -->
    <!-- re:sort-septemberize()                                         -->
    <!-- Adjust month number to sort by September calendar              -->
    <!--                                                                -->
    <!-- Input: Date in gMonthDay format as xs:string                   -->
    <!-- Returns: Date as string, adjusted to sort by                   -->
    <!--   September calendar                                           -->
    <!-- Dependencies: re:getMonth                                      -->
    <!-- *-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*_*  -->
    <xsl:function name="re:septemberize" as="xs:string">
        <xsl:param name="in" as="xs:string"/>
        <xsl:variable name="month" as="xs:integer" select="xs:integer(re:getMonth($in))"/>
        <xsl:sequence
            select="
                '--' ||
                format-number(if ($month lt 9) then
                    $month + 12
                else
                    $month, '00') ||
                '-' ||
                substring($in, 6)"
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

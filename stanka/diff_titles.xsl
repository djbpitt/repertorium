<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:xhtml="http://www.w3.org/1999/xhtml"
    xmlns="http://www.w3.org/1999/xhtml" xmlns:math="http://www.w3.org/2005/xpath-functions/math"
    exclude-result-prefixes="#all" xpath-default-namespace="http://www.tei-c.org/ns/1.0"
    xmlns:re="http://www.ilit.bas.bg/repertorium/ns/3.0" xmlns:f="urn:stylesheet-functions"
    version="3.0">
    <xsl:output method="xml" indent="yes"/>
    <xsl:import href="stanka_lib.xsl"/>
    <xsl:import href="levenstein.xsl"/>

    <!-- *-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*_*  -->
    <!-- stylesheet variables                                           -->
    <!-- *-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*_*  -->
    <xsl:variable name="drag" as="document-node()" select="doc('drag_test1-red-fin.xml')"/>
    <xsl:variable name="sin" as="document-node()" select="doc('Sinait-Slav-25.xml')"/>
    <xsl:variable name="all-dates" as="xs:string+" select="re:getAllDates(($drag, $sin))"/>

    <!-- *-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*_*  -->
    <!-- functions                                                      -->
    <!-- *-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*_*  -->
    <!-- re:normalize()                                                 -->
    <!--                                                                -->
    <!-- lower case, normalize space, strip punctuation, tokenize, and  -->
    <!--   soundexify each token separately                             -->
    <!-- *-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*_*  -->
    <xsl:function name="re:normalize" as="xs:string">
        <xsl:param name="in" as="xs:string"/>
        <xsl:variable name="words" as="xs:string+"
            select="
                lower-case($in) =>
                normalize-space() =>
                replace('\p{P}', '') =>
                tokenize(' ')"/>
        <xsl:sequence
            select="
                string-join(for $word in $words
                return
                    re:soundex($word), ' ')"
        />
    </xsl:function>

    <!-- *-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*_*  -->
    <!-- re:soundex()                                                   -->
    <!--                                                                -->
    <!-- 1. keep first letter, but otherwise strip all vowels           -->
    <!-- 2. strip any non-letters                                       -->
    <!-- 3. normalize variant spellings that share pronunciation        -->
    <!-- 4. keep only first four letters                                -->
    <!-- *-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*_*  -->
    <xsl:function name="re:soundex" as="xs:string">
        <xsl:param name="in" as="xs:string"/>
        <xsl:variable name="first" as="xs:string" select="substring($in, 1, 1)"/>
        <xsl:variable name="rest" as="xs:string"
            select="
                substring($in, 2) !
                replace(., '[^\p{L}]+', '') !
                replace(., 'ѯ', 'кс') !
                replace(., 'ѱ', 'ps') !
                replace(., 'ѽ', 'от') !
                replace(., '[^бвгджзꙁꙃꙅѕклмнпрстѳфѳхцчшщ]+', '') =>
                substring(1, 5)
                "/>
        <xsl:sequence
            select="
                concat($first, $rest) ! translate(.,
                'яꙝꙗꙙѧѩєѥѣыꙇꙇꙑіїѵѻѡѹꙋюѫѭꙁꙃѕꙅѳ',
                'ааааааеееиииииииооуууууззззф')"
        />
    </xsl:function>

    <xsl:template name="xsl:initial-template">
        <html>
            <head>
                <title>Stuff</title>
                <link rel="stylesheet" type="text/css"
                    href="http://www.obdurodon.org./css/style.css"/>
                <link rel="stylesheet" type="text/css" href="compare.css"/>
                <style type="text/css">
                    table {
                        width: fit-content;
                    }
                    th:first-of-type {
                        text-align: left;
                    }</style>
            </head>
            <body>
                <h1>Title comparisons</h1>
                <xsl:for-each select="$all-dates => re:sort-gMonthDay()">
                    <xsl:variable name="dragEntry" as="element(msItemStruct)?"
                        select="$drag//msContents/msItemStruct[date/@when eq current()]"/>
                    <xsl:variable name="sinEntry" as="element(msItemStruct)?"
                        select="$sin//msContents/msItemStruct[date/@when eq current()]"/>
                    <xsl:variable name="dragItem" select="$dragEntry/re:sampleText/head"/>
                    <xsl:variable name="sinItem" select="$sinEntry/re:sampleText/head"/>
                    <xsl:if test="$dragEntry/title eq $sinEntry/title and $dragItem and $sinItem">
                        <hr/>
                        <h2>
                            <xsl:value-of select="re:month-day-from-gMonthDay(.)"/>
                        </h2>
                        <h3>
                            <xsl:value-of select="$dragEntry/title"/>
                        </h3>
                        <xsl:variable name="dragSoundex" as="xs:string"
                            select="re:normalize($dragItem)"/>
                        <xsl:variable name="sinSoundex" as="xs:string"
                            select="re:normalize($sinItem)"/>
                        <xsl:variable name="dragSoundexLength" as="xs:integer"
                            select="string-length($dragSoundex)"/>
                        <xsl:variable name="sinSoundexLength" as="xs:integer"
                            select="string-length($sinSoundex)"/>
                        <table>
                            <tr>
                                <th>Source</th>
                                <th>Text</th>
                                <th>Soundex</th>
                            </tr>
                            <tr>
                                <th>Drag</th>
                                <td class="os">
                                    <xsl:apply-templates select="$dragItem"/>
                                </td>
                                <td><xsl:value-of select="$dragSoundex"/> (<xsl:value-of
                                        select="$dragSoundexLength"/>)</td>
                            </tr>
                            <tr>
                                <th>Sin</th>
                                <td class="os">
                                    <xsl:apply-templates select="$sinItem"/>
                                </td>
                                <td><xsl:value-of select="$sinSoundex"/> (<xsl:value-of
                                        select="$sinSoundexLength"/>)</td>
                            </tr>
                        </table>
                        <p>
                            <xsl:value-of
                                select="
                                    (f:levenshtein($dragSoundex, $sinSoundex) div max(($dragSoundexLength, $sinSoundexLength))) =>
                                    format-number('.0000')"
                            />
                        </p>
                    </xsl:if>
                </xsl:for-each>
            </body>
        </html>
    </xsl:template>

</xsl:stylesheet>

<?xml version="1.0" encoding="UTF-8"?>
<sch:schema xmlns:sch="http://purl.oclc.org/dsdl/schematron" queryBinding="xslt2"
    xmlns:sqf="http://www.schematron-quickfix.com/validator/process"
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:djb="http://www.obdurodon.org">
    <sch:ns prefix="djb" uri="http://www.obdurodon.org"/>
    <xsl:function name="djb:decimal-to-hex" as="xs:string*">
        <!--
            Adapted for XSLT 3.1 from
            https://gist.github.com/xpathr/2653476 (license information not available)
            by David J. Birnbaum 2019-10-30
            MIT License
        -->
        <xsl:param name="in" as="xs:double"/>
        <xsl:variable name="results" as="xs:string+">
            <xsl:if test="$in gt 0">
                <xsl:sequence select="djb:decimal-to-hex(floor($in div 16))"/>
            </xsl:if>
            <xsl:choose>
                <xsl:when test="$in mod 16 lt 10">
                    <xsl:value-of select="$in mod 16"/>
                </xsl:when>
                <xsl:otherwise>
                    <xsl:value-of select="codepoints-to-string(xs:integer($in mod 16 + 55))"/>
                </xsl:otherwise>
            </xsl:choose>
        </xsl:variable>
        <xsl:sequence select="replace(string-join($results), '^0+', '')"/>
    </xsl:function>

    <sch:pattern>
        <sch:rule context="text()">
            <sch:let name="words" value="tokenize(., '\s+')"/>
            <sch:report test="matches(., '[&#xe000;-&#xfbff;]')">PUA characters not permitted:
                    <sch:value-of
                    select="
                        string-join(
                        for $word in $words[matches(., '[&#xe000;-&#xfbff;]')]
                        return
                            $word ||
                            ' contains ' ||
                            string-join(
                            for $i in
                            string-to-codepoints(replace($word, '[^&#xe000;-&#xfbff;]', ''))
                            return
                                'U+' || djb:decimal-to-hex($i), ', '
                            ) ||
                            '; ')"
                /></sch:report>
        </sch:rule>
    </sch:pattern>
</sch:schema>

<?xml version="1.0" encoding="UTF-8"?>
<sch:schema xmlns:sch="http://purl.oclc.org/dsdl/schematron" queryBinding="xslt2"
    xmlns:sqf="http://www.schematron-quickfix.com/validator/process">
    <sch:ns uri="http://www.tei-c.org/ns/1.0" prefix="tei"/>
    <sch:ns uri="http://www.ilit.bas.bg/repertorium/ns/3.0" prefix="re"/>
    <sch:pattern id="title-check">
        <sch:rule context="tei:msItemStruct/tei:title">
            <sch:assert test="@xml:lang eq 'bg'" sqf:fix="addTitleLg changeTitleLg">Titles of
                articles must specify an @xml:lang attribute with the value 'bg'.</sch:assert>
            <sch:report
                test="
                    some $i in text()
                        satisfies matches($i, '[IV]+')"
                >Roman numerals representing mode numbers in &lt;title&gt; elements must be tagged
                as &lt;num type="mode"&gt;</sch:report>
            <sqf:fix id="addTitleLg" use-when="not(@xml:lang)" role="add">
                <sqf:description>
                    <sqf:title>Specify that the article title is in Bulgarian</sqf:title>
                    <sqf:p>Add 'bg' as the value of an @xml:lang attribute on a &lt;title&gt;
                        element</sqf:p>
                </sqf:description>
                <sqf:add node-type="attribute" target="xml:lang" select="'bg'"/>
            </sqf:fix>
            <sqf:fix id="changeTitleLg" use-when="@xml:lang ne 'bg'">
                <sqf:description>
                    <sqf:title>Specify that the article title is in Bulgarian</sqf:title>
                    <sqf:p>Change the current value of the @xml:lang attribute to 'bg'</sqf:p>
                </sqf:description>
                <sqf:replace match="./@xml:lang" node-type="keep" target="xml:lang" select="'bg'"/>
            </sqf:fix>
        </sch:rule>
    </sch:pattern>
    <sch:pattern id="msItemStruct-check">
        <sch:rule context="tei:msItemStruct">
            <!-- rule-level variables -->
            <sch:p><sch:emph>$stem</sch:emph> = @xml:id without final dot and trailing
                digits</sch:p>
            <sch:p><sch:emph>$tail</sch:emph> = @xml:id after final dot</sch:p>
            <sch:p><sch:emph>$preceding-stem</sch:emph> = @xml:id of preceding sibling without final
                dot and trailing digits</sch:p>
            <sch:p><sch:emph>$preceding-tail</sch:emph> = @xml:id of preceding sibling after final
                dot</sch:p>
            <sch:let name="stem" value="replace(@xml:id, '\.\d+$', '')"/>
            <sch:let name="tail" value="tokenize(@xml:id, '\.')[last()]"/>
            <sch:let name="preceding-stem"
                value="replace(preceding-sibling::tei:msItemStruct[1]/@xml:id, '\.\d+$', '')"/>
            <sch:let name="preceding-tail"
                value="tokenize(preceding-sibling::tei:msItemStruct[1]/@xml:id, '\.')[last()]"/>
            <!-- end of rule-level variables -->
            <sch:p>Add missing @xml:id anywhere</sch:p>
            <sch:report test="not(@xml:id) or not(matches(@xml:id, 'ACD(\d+)(\.\d+)*'))"
                sqf:fix="add-acd">&lt;msItemStruct&gt; must have an @xml:id attribute</sch:report>
            <sqf:fix id="add-acd" use-when="not(@xml:id)">
                <sqf:description>
                    <sqf:title>Add missing @xml:id</sqf:title>
                </sqf:description>
                <sqf:add node-type="attribute" target="xml:id"/>
            </sqf:fix>
            <sch:p>Applies only to first &lt;msItemStruct&gt;</sch:p>
            <sch:report
                test="not(preceding::tei:msItemStruct or ancestor::tei:msItemStruct) and @xml:id ne 'ACD1'"
                sqf:fix="fix-first-acd">The @xml:id value of the first &lt;msItemStruct&gt; must be
                'ACD1'</sch:report>
            <sqf:fix id="fix-first-acd">
                <sqf:description>
                    <sqf:title>Add 'ACD1' as @xml:id of first &lt;msItemStruct&gt;</sqf:title>
                </sqf:description>
                <sqf:replace match="@xml:id" node-type="attribute" target="xml:id" select="'ACD1'"/>
            </sqf:fix>
            <sch:p>Applies only to first &lt;msItemStruct&gt;, but not at top of hierarchy</sch:p>
            <sch:report
                test="parent::tei:msItemStruct and not(preceding-sibling::tei:msItemStruct) and @xml:id ne concat(parent::tei:msItemStruct/@xml:id, '.1')"
                sqf:fix="first-top-non-first-acd">First item at current level must have @xml:id
                value equal to @xml:id of parent followed by '.1'</sch:report>
            <sqf:fix id="first-top-non-first-acd">
                <sqf:description>
                    <sqf:title>Change @xml:id to append '.1' to @xml:id of parent</sqf:title>
                </sqf:description>
                <sqf:replace match="@xml:id" node-type="attribute" target="xml:id"
                    select="concat(ancestor::tei:msItemStruct[2]/@xml:id, '.1')"/>
            </sqf:fix>
            <sch:p>@xml:id value of non-top item should be one greater than that of first preceding
                sibling</sch:p>
            <sch:report
                test="preceding-sibling::tei:msItemStruct and @xml:id ne concat($preceding-stem, '.', number($preceding-tail) + 1)"
                sqf:fix="fix-non-top-acd">The value of @xml:id should be one greater than the value
                of @xml:id on the first preceding sibling</sch:report>
            <sqf:fix id="fix-non-top-acd">
                <sqf:description>
                    <sqf:title>Change @xml:id to one greater than @xml:id of previous
                        item</sqf:title>
                </sqf:description>
                <sqf:replace match="@xml:id" node-type="attribute" target="xml:id"
                    select="concat($preceding-stem, '.', number($preceding-tail) + 1)"/>
            </sqf:fix>
        </sch:rule>
    </sch:pattern>
    <sch:pattern id="sampleText-check">
        <sch:rule context="re:sampleText">
            <sch:p>Usually &lt;re:sampleText&gt; has @xml:lang value of 'cu'. But other values
                (e.g., 'gk') are not necessarily errors.</sch:p>
            <sch:report test="not(@xml:lang) or @xml:lang eq ''" sqf:fix="sampleText-cu"
                >&lt;re:sampleText&gt; lacks an @xml:lang attribute. The most common value is 'cu'
                (Church Slavonic).</sch:report>
            <sqf:fix id="sampleText-cu">
                <sqf:description>
                    <sqf:title>Add @xml:lang with value of 'cu' to
                        &lt;re:sampleText&gt;.</sqf:title>
                </sqf:description>
                <sqf:add node-type="attribute" target="xml:lang" select="'cu'"/>
            </sqf:fix>
            <sch:report role="info" test="@xml:lang ne 'cu'">@xml:lang on &lt;re:sampleText&gt; is
                not 'cu' (Church Slavonic). This is not necessarily an error.</sch:report>
        </sch:rule>
    </sch:pattern>
    <sch:pattern id="incipit-check">
        <sch:rule context="tei:incipit">
            <sch:report test="@xml:lang eq parent::re:sampleText/@xml:lang"
                sqf:fix="remove-xml-lang">&lt;incipit&gt; elements must not have an @xml:lang
                attribute value equal to that of the parent &lt;re:sampleText&gt;
                element.</sch:report>
            <sqf:fix id="remove-xml-lang">
                <sqf:description>
                    <sqf:title>Remove redundant @xml:lang attribute</sqf:title>
                </sqf:description>
                <sqf:delete match="@xml:lang"/>
            </sqf:fix>
            <sch:report test="matches(., '[\[\]\(\)]')">Square brackets (to indicate text supplied
                by the editor) and parentheses (to indicate superscription) are not permitted inside
                &lt;incipit&gt; elements. Square brackets must be replaced with &lt;supplied&gt;
                tags. Parentheses must be replaced with a &lt;seg&gt; element that has a @rend
                attribute with the value 'sup', i.e., &lt;seg rend='sup'&gt;</sch:report>
            <!--
                fix should convert wrapping square brackets to <supplied> and parens to <seg rend="sup"> 
            -->
        </sch:rule>
    </sch:pattern>
</sch:schema>

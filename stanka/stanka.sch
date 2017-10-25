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
                        satisfies matches($i, '[IV]+.+гл')"
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
<!--    <sch:pattern id="msItemStruct-check">
        <sch:rule context="tei:msItemStruct">
            <sch:assert test="starts-with(@xml:id, 'ACD')" sqf:fix="addACD changeACD"
                >&lt;msItemStruct&gt; elements must have an @xml:id value that begins with the
                string 'ACD'.</sch:assert>
            <sqf:fix id="addACD" use-when="not(@xml:id)">
                <!-\- modify this to add full correct value -\->
                <sqf:description>
                    <sqf:title>Add @xml:id to &lt;msItemStruct&gt;</sqf:title>
                    <sqf:p>Add @xml:id that begins with 'ACD' to @lt;msItemStruct&gt;</sqf:p>
                </sqf:description>
                <sqf:add node-type="attribute" target="xml:id" select="'ACD'"/>
            </sqf:fix>
            <sqf:fix id="changeACD" use-when="not(starts-with(@xml:id, 'ACD'))">
                <sqf:description>
                    <sqf:title>Change @xml:id to begin with 'ACD'</sqf:title>
                </sqf:description>
                <sqf:replace match="./@xml:id" node-type="keep" target="xml:id" select="'ACD'"/>
            </sqf:fix>
        </sch:rule>
    </sch:pattern>
    <!-\- add rule to validate and correct erroneous ACD -\->
-->    <sch:pattern id="sampleText-check">
        <sch:rule context="re:sampleText">
            <sch:assert test="@xml:lang eq 'cu'">&lt;re:sampleText&gt; elements must have an
                @xml:lang attribute with the value 'cu'.</sch:assert>
            <!-- 
                fix should add lang as 'cu' and remove any lang equal to 'cu' from children
                nb: lang might be Gk
            -->
        </sch:rule>
    </sch:pattern>
    <sch:pattern id="incipit-check">
        <sch:rule context="tei:incipit">
            <sch:report test="@xml:lang">&lt;incipit&gt; elements must not have an @xml:lang
                attibute. Instead, their parent &lt;re:sampleText&gt; element must have an @xml:lang
                attribute with the value 'cu'.</sch:report>
            <!--
                fix should remove lang from child of simpleText if it's 'cu' and add it to simpleText
                nb: lang may be Gk
            -->
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

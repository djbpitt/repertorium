<?xml version="1.0" encoding="UTF-8"?>
<sch:schema xmlns:sch="http://purl.oclc.org/dsdl/schematron"
    xmlns:sqf="http://www.schematron-quickfix.com/validator/process"
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform" queryBinding="xslt2"
    xmlns:tei="http://www.tei-c.org/ns/1.0" xmlns:re="http://www.ilit.bas.bg/repertorium/ns/3.0/"
    xml:lang="en">
    <sch:ns uri="http://www.tei-c.org/ns/1.0" prefix="tei"/>
    <sch:ns uri="http://www.ilit.bas.bg/repertorium/ns/3.0" prefix="re"/>
    <xsl:key name="bgTitles" match="bg" use="."/>
    <xsl:key name="genres" match="en" use="."/>
    <sch:pattern id="TEI-rules">
        <sch:p>Rules for &lt;TEI&gt;</sch:p>
        <sch:rule context="tei:TEI">
            <sch:let name="filename"
                value="substring-before(tokenize(base-uri(.), '/')[last()], '.xml')"/>
            <sch:let name="id" value="substring(@xml:id, 4)"/>
            <sch:assert test="starts-with(@xml:id, 'RC-')">The @xml:id (<sch:value-of
                    select="@xml:id"/>) does not begin with "RC-"</sch:assert>
            <sch:assert test="$filename eq $id" sqf:fix="change-tei-xml-id">The filename
                    (<sch:value-of select="$filename"/>) does not match the @xml:id (<sch:value-of
                    select="$id"/>)</sch:assert>
            <sqf:fix id="change-tei-xml-id">
                <sqf:description>
                    <sqf:title>Change TEI/@xml:id to match filename</sqf:title>
                </sqf:description>
                <sqf:replace node-type="attribute" match="@xml:id" target="xml:id"
                    select="concat('RC-', $filename)"/>
            </sqf:fix>
        </sch:rule>
    </sch:pattern>
    <sch:pattern id="article-title-rules">
        <sch:rule context="tei:msItemStruct/tei:title">
            <sch:let name="titles" value="doc('../aux/titles_cyrillic.xml')"/>
            <sch:assert test="normalize-space(.) eq ." sqf:fix="normalize-space">You have entered a
                title with extra white space</sch:assert>
            <sqf:fix id="normalize-space">
                <sqf:description>
                    <sqf:title>Remove extra white space</sqf:title>
                </sqf:description>
                <sqf:replace match="text()[1]" select="replace(., '^\s+', '')"/>
                <sqf:replace match="text()[last()]" select="replace(., '\s+$', '')"/>
            </sqf:fix>
            <sch:assert test=". eq normalize-space(.) and . = key('bgTitles', ., $titles)">The title
                you have entered, <sch:value-of select="."/>, does not appear in the master list of
                titles</sch:assert>
            <sch:assert test="@xml:lang eq 'bg'" sqf:fix="addTitleLg changeTitleLg">Titles of
                articles must specify an @xml:lang attribute with the value 'bg'.</sch:assert>
            <sch:report test="child::text()[matches(., '[IVXLC]+')]" sqf:fix="roman">Roman numerals
                representing mode numbers in &lt;title&gt; elements must be tagged as &lt;num
                type="mode"&gt;</sch:report>
            <sqf:fix id="roman">
                <sqf:description>
                    <sqf:title>Wrap Roman numerical in &lt;num type="mode"&gt; tags</sqf:title>
                </sqf:description>
                <sqf:stringReplace regex="[IVXCL]+" match="text()"><tei:num type="mode"
                    >$0</tei:num></sqf:stringReplace>
            </sqf:fix>
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
                <sqf:replace match="./@xml:lang" node-type="keep" target="xml:lang" select="bg"/>
            </sqf:fix>
        </sch:rule>
    </sch:pattern>
    <sch:pattern id="date-rules">
        <sch:rule context="tei:publicationStmt/tei:date">
            <sch:assert test="@when">The Date in the &lt;publicationStmt&gt; must have a @when
                attribute</sch:assert>
        </sch:rule>
        <sch:rule context="tei:note[@type = 'churchCal']">
            <sch:report test="1">Dates according to the church calendar must be tagged as &lt;date
                type="churchCal"&gt; (not as a &lt;note&gt; element).</sch:report>
        </sch:rule>
        <sch:rule context="tei:date[@type = 'churchCal'][matches(., '\d')]" role="warn">
            <sch:report test="not(@when or @when-custom) and not(matches(., '\d+\p{L}'))">If a date
                is given according to the Church calendar, the &lt;date&gt; element should normally
                have either a @when (fixed dates) or @when-custom (moveable dates)
                attribute.</sch:report>
        </sch:rule>
        <sch:rule
            context="tei:msItemStruct[not(tei:title = 'Колофон')]/tei:date[not(@type eq 'churchCal')]"
            role="warn">
            <sch:report test="1">If a &lt;date&gt; child of &lt;msItemStruct&gt; refers to a date in
                the church calendar, it must have a @type value of "churchCal".</sch:report>
        </sch:rule>
        <sch:rule context="tei:msItemStruct/tei:note">
            <sch:report
                test="tei:date and string-length(normalize-space(.)) eq sum(tei:date/string-length(normalize-space(.)))"
                role="warn">A &lt;date&gt; in this position normally should not be wrapped in a
                &lt;note&gt; parent</sch:report>
        </sch:rule>
    </sch:pattern>
    <sch:pattern id="msIdentifier-rules">
        <sch:rule context="tei:msDesc/tei:msIdentifier">
            <sch:p>Rules for &lt;msIdentifier&gt; do not apply inside &lt;msPart&gt; or
                &lt;msFrag&gt;</sch:p>
            <sch:assert
                test="tei:altIdentifier or following-sibling::tei:msFrag or count(tei:idno[not(@type eq 'former')][@type eq 'shelfmark']) eq 1"
                >Unless there is an &lt;altIdentifier&gt;, there must be exactly one non-former
                &lt;idno&gt; element inside &lt;msIdentifier&gt; with the @type value of
                'shelfmark'</sch:assert>
            <sch:assert test="count(tei:msName[@type eq 'general']) eq 1">There must be exactly one
                msName element of type general</sch:assert>
            <sqf:fix id="add-general">
                <sqf:description>
                    <sqf:title>Add &lt;msName type="general"&gt;</sqf:title>
                </sqf:description>
                <sqf:user-entry name="genre" default="'miscellany'">
                    <sqf:description>
                        <sqf:title>Add a genre identifier</sqf:title>
                    </sqf:description>
                </sqf:user-entry>
                <sqf:add node-type="element" target="tei:msName" select="$genre"/>
                <sqf:add match="tei:msName[1]" node-type="attribute" target="type"
                    select="'general'"/>
                <sqf:add match="tei:msName[1]" node-type="attribute" target="xml:lang" select="'en'"
                />
            </sqf:fix>
            <sch:assert test="count(tei:msName[@type eq 'specific']) eq 1">There must be exactly one
                msName element of type specific</sch:assert>
            <sqf:fix id="add-specific">
                <sqf:description>
                    <sqf:title>Add &lt;msName type="specific"&gt;</sqf:title>
                </sqf:description>
                <sqf:user-entry name="genre" default="'miscellany'">
                    <sqf:description>
                        <sqf:title>Add a genre identifier</sqf:title>
                    </sqf:description>
                </sqf:user-entry>
                <sqf:add node-type="element" target="tei:msName" select="$genre"/>
                <sqf:add match="tei:msName[1]" node-type="attribute" target="type"
                    select="'specific'"/>
                <sqf:add match="tei:msName[1]" node-type="attribute" target="xml:lang" select="'en'"
                />
            </sqf:fix>
            <sch:assert test="
                    if (tei:msName[@type eq 'individual']) then
                        tei:msName[@type eq 'individual' and @xml:lang eq 'bg'] and
                        tei:msName[@type eq 'individual' and @xml:lang eq 'en'] and
                        tei:msName[@type eq 'individual' and @xml:lang eq 'ru']
                    else
                        true()" sqf:fix="add-bg add-en add-ru">If there is an individual
                msName, there must be at least one in each of the three languages, and they must be
                non-empty.</sch:assert>
            <sqf:fix id="add-bg"
                use-when="not(tei:msName[@type eq 'individual' and @xml:lang eq 'bg'])">
                <sqf:description>
                    <sqf:title>Add Bulgarian individual name</sqf:title>
                </sqf:description>
                <sqf:add node-type="element" target="tei:msName"/>
                <sqf:add node-type="attribute" match="tei:msName[1]" target="type"
                    select="'individual'"/>
                <sqf:add node-type="attribute" match="tei:msName[1]" target="xml:lang" select="'bg'"
                />
            </sqf:fix>
            <sqf:fix id="add-en"
                use-when="not(tei:msName[@type eq 'individual' and @xml:lang eq 'en'])">
                <sqf:description>
                    <sqf:title>Add English individual name</sqf:title>
                </sqf:description>
                <sqf:add node-type="element" target="tei:msName"/>
                <sqf:add node-type="attribute" match="tei:msName[1]" target="type"
                    select="'individual'"/>
                <sqf:add node-type="attribute" match="tei:msName[1]" target="xml:lang" select="'en'"
                />
            </sqf:fix>
            <sqf:fix id="add-ru"
                use-when="not(tei:msName[@type eq 'individual' and @xml:lang eq 'ru'])">
                <sqf:description>
                    <sqf:title>Add Russian individual name</sqf:title>
                </sqf:description>
                <sqf:add node-type="element" target="tei:msName"/>
                <sqf:add node-type="attribute" match="tei:msName[1]" target="type"
                    select="'individual'"/>
                <sqf:add node-type="attribute" match="tei:msName[1]" target="xml:lang" select="'ru'"
                />
            </sqf:fix>
        </sch:rule>
    </sch:pattern>
    <sch:pattern id="msItemStruct-check">
        <sch:rule context="tei:msItemStruct">
            <!-- rule-level variables -->
            <sch:p><sch:emph>$preceding-stem</sch:emph> = @xml:id of preceding sibling without final
                dot and trailing digits</sch:p>
            <sch:p><sch:emph>$preceding-tail</sch:emph> = @xml:id of preceding sibling after final
                dot</sch:p>
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
            <sch:p>@xml:id value of non-top and non-first item should be one greater than that of
                first preceding sibling</sch:p>
            <sch:report
                test="ancestor::tei:msItemStruct and preceding-sibling::tei:msItemStruct and @xml:id ne concat($preceding-stem, '.', number($preceding-tail) + 1)"
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
            <sch:report
                test="not(ancestor::tei:msItemStruct) and preceding-sibling::tei:msItemStruct[1] and number(substring-after(@xml:id, 'ACD')) ne number(substring-after(preceding-sibling::tei:msItemStruct[1]/@xml:id, 'ACD')) + 1"
                sqf:fix="fix-top-non-first-acd">@xml:id of top-level non-first item should be one
                greater than that of preceding item</sch:report>
            <sqf:fix id="fix-top-non-first-acd">
                <sqf:description>
                    <sqf:title>Change @xml:id to one greater than @xml:id of previous
                        item</sqf:title>
                </sqf:description>
                <sqf:replace match="@xml:id" node-type="attribute" target="xml:id"
                    select="concat('ACD', string(number(substring-after(preceding-sibling::tei:msItemStruct[1]/@xml:id, 'ACD')) + 1))"
                />
            </sqf:fix>
        </sch:rule>
    </sch:pattern>
    <sch:pattern id="msName-rules">
        <sch:rule context="
                tei:msName[@type = ('general',
                'specific')]">
            <sch:let name="genres" value="doc('../aux/genres.xml')"/>
            <sch:assert test=". = key('genres', ., $genres)">The genre label you have entered,
                    <sch:value-of select="."/>, does not appear in the master list of general or
                specific genres</sch:assert>
            <sch:report test="@subtype">No @subtype may be specified for general and specific msName
                elements</sch:report>
            <sch:assert test="@xml:lang eq 'en'">General and specific msName elements must be in
                English</sch:assert>
            <sch:assert test="string-length(normalize-space(.)) gt 0">general and specific
                &lt;msName&gt; elements cannot be empty</sch:assert>
        </sch:rule>
        <sch:rule context="tei:msName[@type eq 'individual' and @subtype]">
            <sch:assert test="@subtype eq 'old'">The only legal value of the @subtype attribute is
                "old". Current subtypes should not specify the subtype attribute</sch:assert>
        </sch:rule>
        <sch:rule context="tei:msName">
            <sch:report test="not(@type = ('general', 'specific', 'individual'))">The only legal
                values of the @type attribute are "general", "specific", and "individual". The value
                    "<sch:value-of select="@type"/>" is invalid</sch:report>
        </sch:rule>
    </sch:pattern>
    <sch:pattern id="watermark-rules">
        <sch:rule context="tei:watermark">
            <sch:assert
                test="(not(*) and string-length(normalize-space(.)) gt 0) or count(*:motif) eq 1">A
                watermark must contain either bare text or exactly one motif element.</sch:assert>
        </sch:rule>

        <sch:rule context="tei:countermark">
            <sch:assert test="count(*:motif) eq 1">A countermark must contain exactly one motif
                element</sch:assert>
        </sch:rule>

        <sch:rule context="tei:watermark/*:motif">
            <sch:report test="tei:countermark">Countermark should not be a child of motif; it should
                be a sibling, so that they share a watermark parent.</sch:report>
        </sch:rule>

        <sch:rule context="tei:watermark/tei:ref">
            <sch:report test="
                    *[1][self::tei:date] or *[last()][self::tei:num] or
                    tei:num/following-sibling::*[1][not(self::tei:date)] or
                    tei:date/following-sibling::*[1][not(self::tei:num)]">In an album
                reference in a watermark, the num and date elements must alternate, starting with a
                num.</sch:report>
        </sch:rule>
    </sch:pattern>
    <sch:pattern id="misc-rules">
        <sch:rule context="tei:supportDesc/tei:extent">
            <sch:assert test="tei:measure">supportDesc/extent must contain a measure
                element</sch:assert>
        </sch:rule>

        <sch:rule context="tei:measure">
            <sch:assert test="matches(., '^(\d|[\+ivxlcdIVXLCD])+|unknown$')">measure elements must
                contain only one or more digits, roman numerals, or plus signs or the string
                "unknown"</sch:assert>
            <assert test="@unit">measure elements must have a @unit attribute</assert>
        </sch:rule>

        <sch:rule context="tei:extent/tei:dimensions">
            <sch:assert test="
                    @type = ('folia',
                    'written')">extent/dimensions must specify a @type attribute of
                either 'folia' or 'written'</sch:assert>
        </sch:rule>
    </sch:pattern>
    <sch:pattern id="sampleText-rules">
        <sch:rule context="resampleText">
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
        <sch:rule context="re:sampleText/*">
            <sch:report test="descendant::tei:c" role="warn">The &lt;c&gt; element in cited text is
                usually an error for &lt;seg rend="sup"&gt;</sch:report>
        </sch:rule>
    </sch:pattern>
    <sch:pattern id="incipit-rules">
        <sch:rule context="re:sampleText/*">
            <sch:report test="@xml:lang eq parent::re:sampleText/@xml:lang"
                sqf:fix="remove-xml-lang">Children of &lt;re:sampleText&gt; elements must not have
                an @xml:lang attribute value equal to that of the parent</sch:report>
            <sqf:fix id="remove-xml-lang">
                <sqf:description>
                    <sqf:title>Remove redundant @xml:lang attribute</sqf:title>
                </sqf:description>
                <sqf:delete match="@xml:lang"/>
            </sqf:fix>
            <sch:report test="matches(., '[\[\]\(\)]')">Square brackets (to indicate text supplied
                by the editor) and parentheses (to indicate superscription) are not permitted inside
                children of &lt;re:sampleText&gt;. Square brackets must be replaced with
                &lt;supplied&gt; tags. Parentheses must be replaced with a &lt;seg&gt; element that
                has a @rend attribute with the value 'sup', i.e., &lt;seg
                rend='sup'&gt;</sch:report>
            <!--
                fix should convert wrapping square brackets to <supplied> and parens to <seg rend="sup"> 
            -->
        </sch:rule>
    </sch:pattern>
    <sch:pattern id="language-rules">
        <sch:p>Rules for &lt;language&gt; and @xml:lang. Abbreviations are from
            https://www.iana.org/assignments/language-subtag-registry/language-subtag-registry.</sch:p>
        <sch:let name="language"
            value="('Bulgarian', 'Czech', 'English', 'German', 'Greek', 'Latin', 'Moldavian', 'Old Slavic', 'Polish', 'Romanian', 'Russian', 'Serbian', 'Swedish', 'Ukrainian')"/>
        <sch:let name="xmllang"
            value="('bg', 'cs', 'en', 'de', 'el', 'la', 'mo', 'cu', 'pl', 'ro', 'ru', 'sr', 'sv', 'uk')"/>
        <sch:let name="allxmllang" value="distinct-values(//@xml:lang)"/>
        <sch:let name="allident" value="//tei:language/@ident"/>
        <sch:rule context="tei:profileDesc">
            <sch:report test="not(tei:langUsage)">&lt;profileDesc&gt; must contain
                &lt;langUsage&gt;</sch:report>
        </sch:rule>
        <sch:rule context="tei:langUsage">
            <sch:report test="not(tei:language)">&lt;langUsage&gt; must contain at least one
                &lt;language&gt;</sch:report>
            <sch:assert test="count(tei:language) eq count(distinct-values(tei:language))"
                >&lt;language&gt; values must be unique</sch:assert>
        </sch:rule>
        <sch:rule context="tei:langUsage/tei:language">
            <sch:let name="langName" value="."/>
            <sch:assert test=". = $language">Value of &lt;language&gt; (currently <sch:value-of
                    select="(., '[empty]')[1]"/>) must be one of <sch:value-of select="$language"
                /></sch:assert>
            <sch:assert test="@ident eq $xmllang[index-of($language, $langName)]">Content of
                &lt;language&gt; element (<sch:value-of select="."/>) does not match value of @ident
                    (<sch:value-of select="@ident"/>)</sch:assert>
        </sch:rule>
        <sch:rule context="tei:language/@ident">
            <sch:assert test=". = $xmllang">Value of @ident (currently <sch:value-of select="."/>)
                does not match any @xml:lang in file (<sch:value-of select="$xmllang"
                />)</sch:assert>
        </sch:rule>
        <sch:rule context="@xml:lang">
            <sch:assert test=". = $allident">Value of @xml:lang (currently <sch:value-of select="."
                />) does not match any @ident in file (<sch:value-of select="$allident"
                />)</sch:assert>
        </sch:rule>
    </sch:pattern>
    <sch:pattern id="orthography-rules">
        <sch:p>&lt;re:orthNote&gt; requires a @type attribute with values restricted to 'jer' (jer
            letters), 'jus' (nasal vowel letters), 'jotVowel' (jotation), and 'otherLetters'
            (anything other than jers, nasal vowels, and jotation). @subtype values are contrained
            according to the @type value.</sch:p>
        <sch:rule context="re:orthNote[@type eq 'jer']">
            <sch:assert test="@subtype = ('front', 'back', 'etymReg', 'nonEtymReg', 'irregular')"
                >Legal values for jer @subtype are 'front', 'back', 'etymReg', 'nonEtymReg', and
                'irregular'. <sch:value-of select="./namespace-uri()"/></sch:assert>
        </sch:rule>
        <sch:rule context="orthNote[not(@type = ('jer', 'jus', 'jotVowel', 'otherLetters'))]">
            <sch:assert test="@type = ('jer', 'jus', 'jotVowel', 'otherLetters')">&lt;orthoNote&gt;
                elements must have a @type attribute with a value of 'jer' (jer letters), 'jus'
                (nasal vowel letters), 'jotVowel' (jotation), or 'otherLetters' (anything other than
                jers, nasal vowels, and jotation).</sch:assert>
        </sch:rule>
        <sch:rule context="orthNote[@type eq 'jus']">
            <sch:assert test="
                    @subtype = ('etymReg', 'nonEtymReg', 'nonConsis', 'nonJus',
                    'jusTrace')">Legal values for jus @subtype are 'etymReg',
                'nonEtymReg', 'nonConsis', 'nonJus', and 'jusTrace'.</sch:assert>
        </sch:rule>
        <sch:rule context="orthNote[@type eq 'jotation']">
            <sch:assert test="not(@subtype)">The @subtype attribute is not permitted when the @type
                value of an &lt;orthNote&gt; element is 'jotation'.</sch:assert>
        </sch:rule>
    </sch:pattern>
    <sch:pattern id="whitespace-rules">
        <sch:p>Manuscript names, textual citations, and paragraphs cannot begin or end with
            whitespace, except when the element has only element content. They also cannot be
            empty.</sch:p>
        <sch:rule
            context="tei:acquisition | tei:condition | tei:date | tei:filiation | tei:foliation | tei:msName | tei:note | tei:p | tei:provenance | tei:ref | tei:signatures | tei:summary | re:sampleText/*">
            <sch:report
                test="text()[matches(., '\S')] and starts-with(node()[1][self::text()], ' ')">A
                    &lt;<sch:value-of select="name(.)"/>&gt; element cannot begin with a whitespace
                character</sch:report>
            <sch:report
                test="text()[matches(., '\S')] and ends-with(node()[last()][self::text()], ' ')">A
                    &lt;<sch:value-of select="name(.)"/>&gt; element cannot end with a whitespace
                character</sch:report>
            <sch:report test="empty(.)">A &lt;<sch:value-of select="name(.)"/>&gt; element cannot be
                empty.</sch:report>
        </sch:rule>
    </sch:pattern>
    <sch:pattern id="capitalization-rules">
        <sch:rule context="text()">
            <sch:report test="matches(., 'bulgarian|greek|russian|serbian|[\P{L}]slavic[\P{L}]')"
                >Names of languages and cultures (e.g., Bulgarian, Serbian) should normally be
                capitalized.</sch:report>
        </sch:rule>
    </sch:pattern>
</sch:schema>

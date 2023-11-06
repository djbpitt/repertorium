xquery version "3.0";
module namespace app="http://www.ilit.bas.bg/repertorium/ns/3.0/monahos/templates";
declare namespace tei="http://www.tei-c.org/ns/1.0";
declare namespace re="http://www.ilit.bas.bg/repertorium/ns/3.0";
declare namespace functx = 'http://www.functx.com';
declare namespace util = "http://exist-db.org/xquery/util";
import module namespace templates="http://exist-db.org/xquery/templates" ;
import module namespace config="http://www.ilit.bas.bg/repertorium/ns/3.0/monahos/config" at "config.xqm";
import module namespace kwic = "http://exist-db.org/xquery/kwic" at "resource:org/exist/xquery/lib/kwic.xql";
declare function functx:substring-after-last
  ( $arg as xs:string? ,
    $delim as xs:string )  as xs:string {
    replace ($arg,concat('^.*',$delim),'')
 };


(:~
 : This is a sample templating function. It will be called by the templating module if
 : it encounters an HTML element with an attribute data-template="app:test" 
 : or class="app:test" (deprecated). The function has to take at least 2 default
 : parameters. Additional parameters will be mapped to matching request or session parameters.
 : 
 : @param $node the HTML node with the attribute which triggered this call
 : @param $model a map containing arbitrary data - used to pass information between template calls
 :)
declare function app:test($node as node(), $model as map(*)) {
    <p>Dummy template output generated by function app:test at {current-dateTime()}. The templating
        function was triggered by the data-template attribute <code>data-template="app:test"</code>.</p>
};

(:~
: returns the name of the document of the node passed to this function.
:)
declare function app:getDocName($node as node()){
let $name := functx:substring-after-last(document-uri(root($node)), '/')
    return $name
};

(:~
 : href to document.
 :)
declare function app:hrefToDoc($node as node()){
let $name := functx:substring-after-last($node, '/')
let $href := concat('show.html','?document=', app:getDocName($node))
    return $href
};


(:~
 : a fulltext-search function
 :)
 declare function app:ft_search($node as node(), $model as map (*)) {
 if (request:get-parameter("searchexpr", "") !="") then
 let $searchterm as xs:string:= request:get-parameter("searchexpr", "")
 for $hit in collection(concat($config:app-root, '/data/descriptions/'))//*[.//tei:p[ft:query(.,$searchterm)]|.//tei:msDesc[ft:query(.,$searchterm)]]
    let $href := concat(app:hrefToDoc($hit), "&amp;searchexpr=", $searchterm)
    let $score as xs:float := ft:score($hit)
    order by $score descending
    return
    <tr>
        <td>{$score}</td>
        <td class="KWIC">{kwic:summarize($hit, <config width="40" link="{$href}" />)}</td>
        <td>{app:getDocName($hit)}</td>
    </tr>
 else
    <div>Не е открито нищо</div>
 };
 
(:~
 : fetches all documents which contain the searched entity
 :)
declare function app:registerBasedSearch_hits($node as node(), $model as map(*), $searchkey as xs:string?, $path as xs:string?)
{
for $title in collection(concat($config:app-root, '/data/'))//tei:TEI[.//*[@key=$searchkey] | .//*[@ref=concat("#",$searchkey)] | .//tei:abbr[text()=$searchkey]]
    let $doc := document-uri(root($title))
    let $type := tokenize($doc,'/')[(last() - 1)]
    let $params := concat("&amp;directory=", $type, "&amp;stylesheet=", $type)
    let $matchingdoc := root($title)//tei:abbr[text()=$searchkey] | root($title)//*[@key=$searchkey] |  root($title)//*[@ref=concat("#",$searchkey)]
    let $hits := count($matchingdoc)
    let $snippet := 
        for $context in $matchingdoc
        let $before := $context/preceding::text()[1]
        let $after := $context/following::text()[1]
        return
            <p>... {$before} <strong><a href="{concat(app:hrefToDoc($title), $params)}"> {$context/text()}</a></strong> {$after}...<br/></p>
    order by -$hits
    return
    <tr>
        <td>{$hits}</td>
        <td class="KWIC">{$snippet}</td>
        <td>
            <a href="{concat(app:hrefToDoc($title),$params)}">{app:getDocName($title)}</a>
        </td>
    </tr> 
 };
  

 
(:~
 : creates a basic bibl-index derived from the  '/data/indices/listbibl.xml'
 :)
declare function app:listBibl($node as node(), $model as map(*)) {
    let $hitHtml := "hits.html?searchkey="
    for $bibl in doc(concat($config:app-root, '/data/indices/listbibl.xml'))//tei:item
        return
        <tr>
            <td>
                <a href="{concat($hitHtml,$bibl/tei:label)}">{$bibl}</a>
            </td>
        </tr>
};
 

(:~
 : creates a basic person-index derived from the  '/data/indices/listperson.xml'
 :)
declare function app:listPers($node as node(), $model as map(*)) {
    let $hitHtml := "hits.html?searchkey="
    for $person in doc(concat($config:app-root, '/data/indices/listperson.xml'))//tei:listPerson/tei:person
    for $ptr in $person//tei:bibl//tei:ptr
    for $churchCal in $person//tei:bibl//tei:date
        return
        <tr>
            <td>
                <a href="{concat($hitHtml,data($person/@xml:id))}">{$person/tei:persName}</a>
            </td>
             <td>
               {$churchCal/text()}
            </td>
            <td>
                <a href="{data($ptr/@target)}" target="_blank"><i class="fas fa-link"/></a>
            </td>
        </tr>
};

(:~
 : creates a basic table of content derived from the documents stored in '/data/editions'
 :)
declare function app:toc($node as node(), $model as map(*)) {
    for $doc in (collection(concat($config:app-root, '/data/descriptions'))//tei:TEI)
    let $collection := functx:substring-after-last(util:collection-name($doc), '/')
    let $title := $doc//tei:titleStmt/tei:title/text()
        return
        <tr>
            <td>{$title}</td>
            <td>
                <a href="{concat(app:hrefToDoc($doc),'&amp;directory=',$collection,'&amp;stylesheet=',$collection)}">{app:getDocName($doc)}</a>
            </td>
        </tr>   
};


(:~ creates a list of offices derived from the documents stored in '/data/descriptions' :)
declare function app:office($node as node(), $model as map(*)) {
    for $doc in (collection(concat($config:app-root, '/data/descriptions'))//tei:TEI)
    let $collection := functx:substring-after-last(util:collection-name($doc), '/')
    for $mstitle in $doc//tei:titleStmt/tei:title
    for $msItem in $doc//tei:msContents//tei:msItemStruct[1]
    for $office in $msItem//tei:title[@type="office"]
    let $churchCal := $msItem//tei:date[@type="churchCal"]
    let $sample := $msItem//re:sampleText
    let $head := $sample//tei:head[1]
        return
        <tr>
            <td>
                <ul class="result">
                    <li>
                {$office/string()}</li>
                    </ul>
                </td>
                <td>
                <ul class="result">
                    <li lang="cu">
                {$head//text()}</li>
                    </ul>
                </td>
                
            <td>
                <ul class="result">
                    <li>
                {$churchCal//string()}
                    </li>
                    </ul>
                </td>
            <td>
                 <a href="{concat(app:hrefToDoc($doc),'&amp;directory=',$collection,'&amp;stylesheet=',$collection)}">{$mstitle//text()}</a>
            </td>
        </tr>   
};

(:~ creates a list of offices derived from the documents stored in '/data/descriptions' :)
declare function app:churchCal($node as node(), $model as map(*)) {
    for $doc in (collection(concat($config:app-root, '/data/descriptions'))//tei:TEI)
    let $collection := functx:substring-after-last(util:collection-name($doc), '/')
    for $mstitle in $doc//tei:titleStmt/tei:title
    for $msItem in $doc//tei:msContents//tei:msItemStruct[1]
    for $saint in $msItem//tei:title/tei:rs[@type="person"]
    let $churchCal := $msItem//tei:date[@type="churchCal"]
        return
        <tr>
                <td>
                <ul class="result">
                    <li>
                {$churchCal//string()}
                    </li>
                    </ul>
                </td>
                
                <td>
                <ul class="result">
                    <li>
                {$saint/string()}</li>
                    </ul>
                </td>
            <td>
                 <a href="{concat(app:hrefToDoc($doc),'&amp;directory=',$collection,'&amp;stylesheet=',$collection)}">{$mstitle//text()}</a>
            </td>
        </tr>   
};

(:~ creates a basic table of content derived from the documents stored in '/data/descriptions' :)
declare function app:canon($node as node(), $model as map(*)) {
    for $doc in (collection(concat($config:app-root, '/data/descriptions'))//tei:TEI)
    let $collection := functx:substring-after-last(util:collection-name($doc), '/')
    for $msItem in $doc//tei:msContents//tei:msItemStruct/tei:msItemStruct
    for $canon in $msItem//tei:title[@type="canon"]
    for $heirmos in $msItem//tei:title[@type="heirmos"]
    for $mstitle in $doc//tei:titleStmt/tei:title
    let $sample := $msItem//re:sampleText
    let $incipit :=$sample//tei:incipit
        return
        <tr>
            <td>
                {$canon//text()}
                </td>
                 <td>
                {$heirmos//text()}
                </td>
                 <td>
                      <ul class="result">
                <li lang="cu">{$incipit//text()}</li>
                </ul>
                </td>
            <td>
                 <a href="{concat(app:hrefToDoc($doc),'&amp;directory=',$collection,'&amp;stylesheet=',$collection)}">{$mstitle//text()}</a>
            </td>
        </tr>   
};

(:~ creates a basic table of content derived from the documents stored in '/data/descriptions' :)
declare function app:stichera($node as node(), $model as map(*)) {
    for $doc in (collection(concat($config:app-root, '/data/descriptions'))//tei:TEI)
    let $collection := functx:substring-after-last(util:collection-name($doc), '/')
    for $msItem in $doc//tei:msContents//tei:msItemStruct/tei:msItemStruct
    for $sticheron in $msItem//tei:title[@type="sticheron"]
    for $mstitle in $doc//tei:titleStmt/tei:title
    let $sample := $msItem//re:sampleText
    let $incipit :=$sample//tei:incipit
        return
        <tr>
            <td>
                <ul class="result">
                    <li>
                {$sticheron//string()}
                </li>
                    </ul>
                </td>
                <td>
                <ul class="result">
                    <li lang="cu">{$incipit//text()}</li>
                    
                    </ul>
                </td>
            <td>
                 <a href="{concat(app:hrefToDoc($doc),'&amp;directory=',$collection,'&amp;stylesheet=',$collection)}">{$mstitle//text()}</a>
            </td>
        </tr>   
};

(:~ creates a basic table of content derived from the documents stored in '/data/descriptions' :)
declare function app:kontakia($node as node(), $model as map(*)) {
    for $doc in (collection(concat($config:app-root, '/data/descriptions'))//tei:TEI)
    let $collection := functx:substring-after-last(util:collection-name($doc), '/')
    for $msItem in $doc//tei:msContents//tei:msItemStruct/tei:msItemStruct
    for $kontakion in $msItem//tei:title[@type="kontakion"]
    for $mstitle in $doc//tei:titleStmt/tei:title
    let $sample := $msItem//re:sampleText
    let $incipit :=$sample//tei:incipit[1]
        return
        <tr>
            <td>
                <ul class="result">
                    <li>
                {$kontakion//text()}
                </li>
                    </ul>
                </td>
                <td>
                <ul class="result">
                    <li lang="cu">{$incipit//text()}</li>
                    </ul>
                </td>
            <td>
                 <a href="{concat(app:hrefToDoc($doc),'&amp;directory=',$collection,'&amp;stylesheet=',$collection)}">{$mstitle//text()}</a>
            </td>
        </tr>   
};

(:~ creates a basic table of content derived from the documents stored in '/data/descriptions' :)
declare function app:kathisma($node as node(), $model as map(*)) {
    for $doc in (collection(concat($config:app-root, '/data/descriptions'))//tei:TEI)
    let $collection := functx:substring-after-last(util:collection-name($doc), '/')
    for $msItem in $doc//tei:msContents//tei:msItemStruct/tei:msItemStruct
    for $kathisma in $msItem//tei:title[@type="kathisma"]
    for $mstitle in $doc//tei:titleStmt/tei:title
    let $sample := $msItem//re:sampleText
    let $incipit :=$sample//tei:incipit[1]
        return
        <tr>
            <td>
                <ul class="result">
                    <li>
                {$kathisma//text()}
                </li>
                    </ul>
                </td>
                <td>
                <ul class="result">
                    <li lang="cu">{$incipit//text()}</li>
                    </ul>
                </td>
            <td>
                 <a href="{concat(app:hrefToDoc($doc),'&amp;directory=',$collection,'&amp;stylesheet=',$collection)}">{$mstitle//text()}</a>
            </td>
        </tr>   
};

(:~ creates a basic table of content derived from the documents stored in '/data/descriptions' :)
declare function app:troparia($node as node(), $model as map(*)) {
    for $doc in (collection(concat($config:app-root, '/data/descriptions'))//tei:TEI)
    let $collection := functx:substring-after-last(util:collection-name($doc), '/')
    for $msItem in $doc//tei:msContents//tei:msItemStruct/tei:msItemStruct
    for $troparion in $msItem//tei:title[@type="troparion"]
    for $mstitle in $doc//tei:titleStmt/tei:title
    let $sample := $msItem//re:sampleText
    let $incipit :=$sample//tei:incipit
        return
        <tr>
             <td>
                <ul class="result">
                    <li>
                {$troparion//string()}
                </li>
                    </ul>
                </td>
            <td>
                <ul class="result">
                        <li lang="cu">{$incipit//text()}</li>
                   
                </ul>
                </td>
            <td>
               <a href="{concat(app:hrefToDoc($doc),'&amp;directory=',$collection,'&amp;stylesheet=',$collection)}">{$mstitle//text()}</a>
            </td>
        </tr>   
};

(:~ creates a basic table of content derived from the documents stored in '/data/descriptions' :)
declare function app:exaposteilaria($node as node(), $model as map(*)) {
   for $doc in (collection(concat($config:app-root, '/data/descriptions'))//tei:TEI)
    for $msItem in $doc//tei:msContents//tei:msItemStruct/tei:msItemStruct
     let $collection := functx:substring-after-last(util:collection-name($doc), '/')
    for $exaposteilarion in $msItem//tei:title[@type="exaposteilarion"]
    for $mstitle in $doc//tei:titleStmt/tei:title
    let $sample := $msItem//re:sampleText
    let $incipit :=$sample//tei:incipit
        return
        <tr>
             <td>
                <ul class="result">
                    <li>
                {$exaposteilarion//string()}
                </li>
                    </ul>
                </td>
            <td>
                <ul class="result">
                        <li lang="cu">{$incipit//text()}</li>
                   
                </ul>
                </td>
            <td>
               <a href="{concat(app:hrefToDoc($doc),'&amp;directory=',$collection,'&amp;stylesheet=',$collection)}">{$mstitle//text()}</a>
            </td>
        </tr>   
};

(:~
 : perfoms an XSLT transformation
:)
declare function app:XMLtoHTML ($node as node(), $model as map (*), $query as xs:string?) {
let $ref := xs:string(request:get-parameter("document", ""))
let $xmlPath := concat(xs:string(request:get-parameter("directory", "descriptions")), '/')
let $xml := doc(replace(concat($config:app-root,'/data/', $xmlPath, $ref), '/exist/', '/db/'))
let $xslPath := concat(xs:string(request:get-parameter("stylesheet", "descriptions")), '.xsl')
let $xsl := doc(replace(concat($config:app-root,'/resources/xslt/', $xslPath), '/exist/', '/db/'))
let $params := 
<parameters>
   {for $p in request:get-parameter-names()
    let $val := request:get-parameter($p,())
    where  not($p = ("document","directory","stylesheet"))
    return
       <param name="{$p}"  value="{$val}"/>
   }
</parameters>
return 
    transform:transform($xml, $xsl, $params)
};


(:~
 : creates a basic table of content derived from the documents stored in '/data/descriptions'
 :)
declare function app:showEntityInfo($node as node(), $model as map(*)) {
    let $ref := xs:string(request:get-parameter("entityID", ""))
    let $element := collection(concat($config:app-root,'/data/indices/'))//*[@xml:id=$ref]
    for $x in $element
    return
        $x
};
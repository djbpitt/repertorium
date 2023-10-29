# Searching for full text that isn’t there

## Context

Manuscripts (the primary corpus documents) contain articles with article
titles, and many article titles appear in more than one corpus document.
We want to ensure that all titles are available in Bulgarian, English, and
Russian and that the titles are translated consistently. Letting editors
enter the titles in all three languages would create an opportunity for 
inconsistent translation within the corpus. To enhance consistency, editors 
enter only Bulgarian article titles in the primary corpus documents. An 
ancillary document maps each Bulgarian title to corresponding English 
and Russian titles so that all three can be rendered. 

**Housekeeping:** The ancillary document must be kept in sync with the corpus.
That is, when a primary corpus document that contains a new Bulgarian title
is added, that title and its English and Russian translations must be added
to the ancillary document. The ancillary document has a Relax NG schema 
that ensures that all titles in each language are unique, while a Schematron
schema verifies that all Bulgarian titles in primary corpus documents are
represented in the ancillary document.

## Challenge

Users need to perform full-text queries on titles in any of the three languages.
Full-text indexing of the Bulgarian titles is easy because the Bulgarian titles are
in the XML for the primary corpus documents, but the Russian and English
titles are not in the XML, and therefore cannot be indexed directly. There are
at least three ways to manage this limitation, described below.

## Brute force

Transform the documents before indexing to insert the English and Russian titles
into the primary corpus files. This could be an XSLT ant task as part of the build 
(which would require adding the Saxon jar file to the eXist-db configuration, which
could be a deal-breaker for some users who want to be able to build the app but don’t
know what a jar file is) or part of the pre-install and post-install scripts in the 
app (which is likely to be slower).

There is no incremental update to the corpus—that is, editors do not add individual
new corpus documents. The app does not support write actions; all content is created
before the app is built, and if new content is added, the app is rebuilt and reinstalled.

## Using the ancillary document and Lucene keyword analyzer

1.  Create a full-text index on all titles in all three languages in the ancillary
    document using the Lucene standard analyzer.
2.  Create an index on the Bulgarian article titles in the primary corpus 
    documents using the Lucene keyword analyzer.
3.  Perform the full-text lookup on the titles (in all languages) in the ancillary
    title-mapping document (not the primary corpus files) and retrieve the full 
    Bulgarian titles for all hits.
4.  Use the keyword analyzer ("kw") to look up the full and exact Bulgarian titles 
    in the primary corpus files.

**Disadvantage and work-around:** No keyword highlighting because 1) the lookup in
the primary corpus documents is by Bulgarian title even when the user might have 
entered English or Russian words, and 2) that lookup is by the keyword analyzer, 
which treats the entire element as a single token. It would be possible to perform 
the highlighting, if desired, separately before rendering by tokenizing the titles 
after retrieval and tagging matching words.

## Using fields

1.  Create field values for all three languages (using lookup in the ancillary
    document).
2.  Perform the full-text query on the fields.
3.  Highlighting, if desired, is possible using `ft:highlight-field-matches()` 
    (returns  `<exist:field>` with `<exist:match>` inside).

**Possible disadvantage:** How expensive are large numbers of field values?
 
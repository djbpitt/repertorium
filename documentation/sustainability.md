# Sustainability plan

Based on <https://sites.haa.pitt.edu/sustainabilityroadmap/>  
Last revised 2018-12-11 by David J. Birnbaum

## Module A1: What is the scope of your project?

_Q: Where are the access points (_sites of production_) for the project? Is there only one? Where there are different access points, there are often different creative outputs._

### End-user

Single, integrated web site currently at <http://repertorium.obdurodon.org>. Principal access types are:

1. Browse the collection
2. Search the collection
3. Dendrogram overview of corpus

_Digital workstation_ model where there are (ideally) no dead ends that require the back button or going back to start (although those navigations are always available). Information about individual manuscripts in XML, contents, and codicological (manuscript description) views, where only the first should be a dead end. Browse and search  views facilitate follow-up searches, as well as plectogram generation. Plectogram and dendrogram also support follow-up searching. Plectogram is dynamic (can the system suggest optimal organization?).  Bibliographic search, an ancillary resource, is not yet fully conceptualized, let alone integrated.

### Developer

Encoding guidelines, schemas, authority files (text titles, genres), summary data dumps of element types. Inconsistency checks (Unicode, missing titles, corpus consistency reports [schematron]), external references (e.g., TEI guidelines), links to tools and similar resources (fonts, etc.). Reliable resources are in GitHub at <https://github.com/djbpitt/repertorium>. 

_Q: Have you created different project deliverables to serve unique purposes or reach specific audiences? Different deliverables can signal different manifestations of your project._

Principal end-user deliverable is plectogram visualization and navigation, plus content browsing and searching, to support study of textual transmission in convoy. Secondary end-user deliverable is traditional codicological description for information access and preservation purposes. Codicological view is not yet fully interactive, that is, does not have full workstation integration.

Developer deliverables include markup documentation (reference and tutorial), summary reports, and consistency checks.

_Q: What different workflows do you have on your team? Do they correlate with different creative outputs?_

Products and associated workflows include:

1. The main data product is an open-ended corpus of manuscript descriptions, which, in the case of new contributors, relies on tutorial and reference documentation for taggers. Insofar as new data may introduce new complications and new research questions, they may necessitate schema enhancements, which require documentation updates. New texts also require augmentation of the master text and genre lists. New structures (document types) often require code revision, e.g., `<msPart>` and `<msFrag>`.
2. The ODD (and derived schemas) require maintenance, both expansion to support additional manuscript types and constraints to reduce opportunities for errors, as those are discovered. Each new error type requires creating a new schematron rule. Schema changes require documentation and code updates.
3. Auxiliary resources, especially the title list (also the genre list), is maintained in sync with the corpus.
4. Bibliographic management and integration with codicological descriptions. Bibliographic references are part of the descriptions (pointers must resolve), and they are also a potential entry point into the corpus (a mode of access that is not currently implemented).

_Q: How do the intellectual goals of your project manifest themselves? Do they appear together in one creative output, or are they distributed across many?_

Intellectual output is in books, articles, conference reports, most of which focus on subcorpora. These are separate projects that use the Repertorium for data access, management, visualization, and analysis, but they are not part of the Repertorium project itself. They are not tracked within the Repertorium, although at least a list of them should be.

The spin-off _Slovo-ASO: Toward a digital library of South Slavic manuscripts_ project (<http://aso.obdurodon.org/>) relies on the same core technology, but the extent of description, and therefore research support, is substantially different. Slovo-ASO is completed, live, but no longer actively maintained.

_Q: How does your data flow through your project? Is it analyzed and presented in a single way, or a variety of ways? As the data changes shape, it can signal different manifestations of your project._

From a model—view—controller perspective, all views emerge from the same core data, the XML manuscript description files, and involve either a single manuscript-description record or multiple records. Research questions drive the views, and the controller is updated to support new views as they are added. The first product was XML descriptions with no publication or interaction, then controlled searching, then textual content views (e.g., lists), then graphic visualization (first plectograms, then also dendrograms). The organizing principle is the digital workstation, and each new view requires new integration with existing views to maintain that organization. The project is attentive to non-goals, e.g., no effort at graphic visualization of geographic mapping, timelines, or social networking, since those would not be connected to research goals.

## Module A2: How long do you want your project to last?

There are only three phases of development:

1. Active creation
2. Ongoing maintenance (_regular non-transformative activity_)
3. Retirement (_graceful degradation_, where components are allowed to fail).

When you change the focus or scope, active creation restarts. 

Lifespans can conveniently be divided into:

1. Expected development for fewer than three years from now (_bloom and fade_ or first steps toward retirement)
2. More than three years from now, with expectation of retirement, and
3. More than three years, with no plans for retirement (_book time_). 

In all cases, plan for three years and then plan again three years later; don’t plan for perpetuity. Different products within the same project may be in different stages. Lifespan #3, above, may require input from sustainability specialists.

Considerations (with Repertorium values)

* The intellectual goals of your project: ongoing
* Available funding sources: assume none
* Current and future staffing: assume limited but committed
* Preferred technologies: assume general stability with controlled improvement

_Q: How long do you want your project to last, that is: what is your anticipated digital project lifespan?_

Longer than three years, no plan for retirement, similarly to Perseus.

_Q: Why have you chosen this lifespan? Intellectual goals? Financial reasons? Staffing reasons? Technical reasons? Other reasons?_

Ongoing research value, potentially unbounded corpus, where having more data increases the value of the project as a whole. Future financing and staffing are uncertain; the project depends on volunteer labor by a small corps of trained (not crowd) end-users.

_Q: What phase of development would you currently say your project is in? How long has it been in this phase? How long do you project that it will continue in this phase?_

Active creation. We continue to add new manuscript descriptions, and new types of manuscript descriptions (most recently detailed hymnography), and therefore to expand the schema and modify processing code accordingly. We continue to enhance views. The project currently also includes some non-transformative development, such as the port from PHP to `.xar` currently under way. That is, from this perspective the project has two products.

_Q: What is the next phase of development you foresee for this project? When do you think that the project will enter this phase?_

The `.xar` port will be concluded in 2019. Corpus expansion, with associated modifications of schema, auxiliary files, and processing code has no planned end.

## Module A3: Who is the project designed for?

_Designated communities_ are the target audiences (see <http://www.oclc.org/research/publications/library/2000/lavoie-oais.html>). Different team members may prioritize different target audiences, but if you don’t know who your public is, you don’t know what to sustain to meet their needs. _General public_ is okay (e.g., it might be a target audience for Folger), but we can still be specific about the types of members of the general public we have in mind. If the project is openly accessible, there is also necessarily an implicit _unanticipated users_ community. Which features of the project are to be aligned with which communities? 

Core questions include:

1. Who do you imagine using your project?
2. Why do you imagine they use it? What needs do they have?
3. What do you imagine they get out of it? 

Contrast that to:

1. Who uses your project?
1. Why do they use it? What needs do they have?
1. What do you imagine they get out of it? 

### Further thoughts

Ir the _general public_ is a user communities, what types of people constitute that group? How does your project meet the needs of your users, whether actual or imagined? What skills and knowledges do you assume your users have that would allow this interaction to succeed? Have you done usability studies to find out how your users engage with your project? Who might you have as unanticipated users? What other publics have access to your work?

Think of a three-column table: user community, needs, how are their needs met? 

Community | Needs | How
----|----|----
Medieval Slavic philologists interested in the transmission of texts in mixed-content miscellanies, i.e., the core development team | Identify, visualize, analyze patterns of transmission in convoy | Search interface, workstation browsing, graphic visualizations
Slavic manuscript scholars | Codicological information about manuscripts | Codicological and XML views
Slavist and Byzantinist literary historians | Textual transmission of individual works | Search interface, workstation browsing

In the case of the Repertorium, we don’t care about general public. All three categories of target users have domain-specific expert knowledge and language proficiency. Usability studies are inwardly focused: we are our own primary target audience, so the project must meet our research needs, although we respond to feedback from other users. We do not devote attention to unanticipated users, but the site is fully public, i.e., they are welcome to do whatever they find useful with it. Learners are not a separate community; they are members of one or another of the principal communities, but at an earlier stage of knowledge acquisition and practical proficiency.

## Module A4: What are the project’s sustainability priorities?

Focus on *significant properties*, which are fluid. Each has three aspects: 

Content: narrative argumentation, depends on technological and discursive scaffolding

Context: institutional, technological, social. Discipline, institution, audience; who is in charge? Source and ownership of data. Technologies. Often represented by metadata, including external process metadata.

Structure: data (as part of technological architecture, rather than intellectual content), technology stack, interfaces (presentation layer). 

Not all aspects of the project are equally significant, at least at all stages? Is open access a significant property? Password protection? Browse but not search, or vice versa, or both are interface-significant properties? Abstract significant properties: data are stored as XML. This site will always be about Mitford, and only Mitford. 

Q: What is your project’s narrative, argument, or mission? Where and how do your intellectual goals unfold?

Mission defined by research hypotheses about textual transmission in a miscellany context. The project is a tool for structured exploration, aggregation, analysis, and visualization, in support of traditional (human-centered) research reporting.

Q: What information is your project intended to convey? How does it convey it?

Which texts are available where and in what contexts? Which texts co-occur in the same order? How do sets of individual manuscripts compare internally? What does the entire corpus look like? Information is conveyed in lists of manuscript identifiers, that is, in plain language, and graphically (plectograms, dendrograms). 

Q: How do you define your project’s institutional context? What are its contours and features?

Does the institutional hosting matter? Collaboration? Funding agencies? None of it does, except that the host needs to be committed to the goals. Collaboration is open to all who are willing to contribute. As for funding, we'll be grateful for whatever we can get. Must be open access, fairly committed to BY, less so to SA, less so to NC, but all are currently part of the license, and under reconsideration.

Q: What are the structural components of your project? What about your project’s chosen technologies and/or digital interactivity is most salient to you? What forms does it take?

Whatever works. Highest priority is computational tractability. Ambivalent commitment to TEI: community and fundability, but entails technological compromises and costs. Need to balance portability (avoid platform lock-in) with maintenance (Apache PHP + eXist-db is much harder to maintain than .xar). Mobile devices are a low priority. Accessibility matters, but not enough to compromise functionality (cf. secret link underlining for color-blind user). That is, don't forget (explicit, considered) non-goals.

Q: Of all the things you have listed so far in this exercise, what are the features without which your project simply would not be your project? Which seem utterly essential to your overall intellectual and technological goals? And, recalling your work in Module A3, which of these characteristics seem most essential to your designated communities? 

Highest end-user priority is ability to explore patterns of agreement, which means graphically enabled workstation interactivity. With respect to content, mixed-content miscellanies are most important, then fixed-content miscellanies, then other compilations, then the rest.

In tabular form: significant property, function on project, designated communities served

Rank | Property | Function | Community
----|----|----|----
1 | Content (hierarchy of content types) | Improve research coverage | Philologists (following hierarchy of user communities, above)
2 | Workstation interface | User-oriented research interaction| Ditto
2 | Varied (text and graphic) representations | Form follows function | Ditto
3 | Markup documentation, consistency testing, developing guides | Improve integrity and consistency of data | Developers, both core (reference) and new (tutorial)
4 | Non-goals: mobile, accessibility | Avoid scope creep | Prioritize allocation of limited resources to target users

Within the workstation interface (#2, above), plectogram and content views have the highest priority and codicology and dendrogram are secondary. XML publication has the lowest value for us (because we control the API, we can modify it whenever a need is identified), but a high community value (it provides access that bypasses the API).

## Module A5: Project Documentation Checklist

Documentation may be paper or digital, but is best stored in reliable shared location. Number of locations should be small. 

Spreadsheet columns are:

1. Documentation site
1. Type of documentation
1. Reliable?
1. Accessible by whom?
1. Funded how?

The Visual Media Workshop (VMW) doesn’t regard Google docs as reliable, not because it is inadequate, but because there were many choices, and the team picked Box. As a side-effect, they decided that what they do in Google docs is expendable. This means that when a Google doc becomes important, it moves to Box. The reliable site itself becomes a _significant property_. 

Project documentation in a hierarchical folder system should be shallow because fewer buckets improves the likelihood that people will file in the same place. VMW has only four top-level folders:

1. Articles-books-links (bibliography): Zotero might do here
1. Data: machine-actionable. If you keep old versions, be clear about what is old and what is current
1. Process documentation (admin): hosting, local bureaucracy, Asana or Slack chat
1. Sites of production: correspond to A1 _creative outputs_, perhaps organized into subfolders. 

VMW uses Google docs for drafts and working documents. Asana and Slack are project documentation; in VMW, they are not _reliable sites_, so information in them that needs to be preserved needs to be moved. You may need to compromise between the sites that offer the best functionality and those that the team is willing to use. Sigh. With that in place, you can back up only the reliable sites, without having to worry about everything else. 

_Copy of record_ is a thing; put it in a reliable site and mark it as such. Email is drafts, and is not manageable; once you’ve sent documents in various forms around, record whatever you’ve agreed elsewhere. If you must use email as a reliable site, make it a communal account to which all users have access. Keep names, email addresses, dates, and attachments. 

“Funded by whom?” may contain sustainability red flags. For example, a Google doc is funded at the pleasure of Google. VMW uses it, too, but it entails a risk.

Sample locations and record types are:

* Working drafts in Google Docs;
* File folders in Dropbox;
* File folders on a university server;
* Data visualizations on a web server;
* Documentation in GitHub repositories;
* Communication in email accounts or Slack;
* Printed documents in filing cabinets. 

The Repertorium is currently in transition, with the following scattered resources, not all well curated:

* Dropbox, multiple dated folders and subfolders, all types of data, some reliable and some not, accessible by all but curated by djb, owned by Dropbox
* GitHub, not widely used except by djb; master branch is well managed, others less so; intended to include all development and deliverable materials, including app
* Email correspondence is disorganized, opportunistic, and not reliable
* There is no organized collection or curation of third-party research resources (many of which cannot be shared in public for copyright reasons)
* There is no organized collection—or even list—of internal research products, that is, publications or other derived works

### Possible reorganization

* All data in public GitHub repo
* Developers download data from Obdurodon to work on it, and check it out on a Google spreadsheet to avoid simultaneous edits
* Developers submit (most often manuscript descriptions, but also ODD and schemas) to djb by email or pull request, and then check it back in in the Google spreadsheet
* Only djb updates master branch, so all data is reviewed before being committed to the reliable resource
* Better workflow: download data from Obdurodon, check out on Google spreadsheet for management, submit to djb for review before upload

Alison: It’s a little control-freaky, but it’s workable, and it simplifies management a lot

## Module B1: Who is on the project team and what are their roles?

Spreadsheet includes: name, Title, Responsibilities (be specific), funding source, funding duration.

Additionally: 

1. Institutional partners (PI's institution, e.g., administration, equipment, storage, meeting and work space, IT support)
1. Extra-institutional partners (GitHub, Google, hosting, etc.; detail what they do)
1. Project charter: guiding document, typically developed at the beginning and refreshed every three years. Intersects substantially with sustainability plan, since it depends on the information in this module. Avoids issues like having each participant think someone else is maintaining the server.

### Core team

**Name:** David J. Birnbaum (Obdurodon).  
**Title:** Technical director for deployment and publication.  
**Responsibilities:** Design, implement, maintain, deploy, and host official site; maintain Schematron validation rules; maintain documentation (with Andrej).  
**Current funding source and duration:** none

**Name:** Andrej Bojadžiev (Sofia University).  
**Title:** Research assistant director; Technical director for markup.  
**Responsibilities:** Design, implement, and maintain ODD and derived schemas and documentation; advise and assist on site design and implementation; maintain documentation (with David); train taggers (with Anisava); content development and editing, including master lists of titles.  
**Current funding source and duration:** none

**Name:** Anisava Miltenova (Bulgarian Academy of Sciences).  
**Title:** Project owner, Research director.  
**Responsibilities:** Formulate research goals, manage research publication program; train taggers (with Andrej); content development and editing, including master list of titles.  
**Current funding source and duration:** none

**Name:** Dilyana Radoslavova (Bulgarian Academy of Sciences).  
**Title:** Content developer.  
**Responsibilities:** Content development and editing, including assisting with master list of titles.  
**Current funding source and duration:** none

**Content contributors (past):** Adelina Anguševa, Ana Stojkova, Desislava Atanasova, Dimitrinka Dimitrova, Elena Tomova, Elisaveta Musakova, Elisaveta Nenčeva, Margaret Dimitrova, Marina Jordanova, Marija Jovčeva, Maja Petrova, Nina Gagova, Radoslava Stankova, Ralph Cleminson.  
**Other contributors (past):** Rumjan Lazov (font development); Milena Dobreva (project management and administration; grant development); Harry Gaylord (schema development); Berend Dijk (schema development).  
**Content contributors (current):** Stanka
**Content contributors (in training):** Ivan Iliev

**Institutional partners:** None.   
**Extra-institutional partners:**

1. **Dropbox:** Development resource hosting, transitioning out
2. **Google:** Spreadsheet to track content editing
3. **GitHub:** Development resource hosting (in transition from Dropbox)
4. **Rackspace:** Obdurodon hosting
5. (**OSU:** potential permanent host; in conversation with Pasha)

**Former funding sources:** ACLS, IREX (others to be supplied by Anisava)

No charter, but mission statement on site: 

> The Repertorium of Old Bulgarian Literature and Letters was conceived as an archival repository capable of encoding and preserving in SGML (and, subsequently, XML) format archeographic, paleographic, codicological, textological, and literary-historical data concerning original and translated medieval texts represented in Balkan and other Slavic manuscripts. The files are intended to serve both as documentation (fulfilling the goals of traditional manuscript catalogues) and as direct input for computer-assisted philological research. The present site was designed and implemented by David J. Birnbaum, Andrej Bojadžiev, Anisava Miltenova, and Diljana Radoslavova.

## Module B2: What is the technological infrastructure of the project?

Three categories: 

### Data

Authoritative data is in GitHub (public repo https://github.com/djbpitt/repertorium), transitioning from (temporary) Dropbox. Delivered from http://repertorium.obdurodon.org (migration to institutional hosting at OSU under discussion).

### Software, including server software, operating systems, and presentation layer applications

Documented, with links, as "Repertorium toolkit" at <http://repertorium.obdurodon.org/.> Currently: 

* eXist-db XML database
* &lt;oXygen/&gt; XML editor and IDE
* Saxon XSLT and XQuery processor
* xmlsh command-line shell for XML
* XMLStarlet command-line XML utilities
* PhpStorm web technologies editor and IDE
* Anaconda Python 3 platform
* PyCharm Python editor and IDE
* R project for statistical computing
* RStudio R IDE
* Bukyvede Slavic Cyrillic font from MacCampus (production)
* Quivera broad-spectrum Unicode font (development)
* FontForge font editor
* FontPrep web-font generator
* UnicodeChecker to explore and convert Unicode
* Unicode code converter online utility
* UniView online utility
* Cloudconvert online convert anything utility

### Hardware, including the machines that you own, “use for free,” or rent. 

Data and application at GitHub, with distributed local clones. Hosting at <http://repertorium.obdurodon.org> with Rackspace, paid by David.

### Hardware and software infrastructure questions

* **What is the function of this technology on your project?** Documented on the project site (see list of software, above)
* **How is the technology funded, and for how long will that funding last?** Open source, no funding needed, except &lt;oXygen/&gt;, which we pay and renew individually, in perpetuity
* **How long will this technology be required by your project?** Indefinitely (under constant active development)

## Module B3: Socio-Technical Responsibility Checklist

Spreadsheet is an extension of B1, B2: Technology, function on project, funding source, funding duration, duration of need, member responsible (with title, responsibilities, funding source, funding duration, as in B1). Then:

1. Flag any situations where funding for person and technology do not overlap; not necessarily a problem, but at a minimum a known risk (which can be fixed; put someone else on it). 
2. Look back at significant-properties list, which should mention technologies, and see which items on this list are high on the significant-properties list. Are they securely staffed and funded? We wind up with mapping of significant properties to the people and technologies that make them work. Make sure that people have access to the technologies they need.

All participants have access to all open-source technology resources. &lt;oXygen/&gt; licenses are self-funded (David) or underwritten by employers (Sofia University, Bulgarian Academy of Sciences). 

## Module C1: Adapting the NDSA Levels of Preservation

Issues include the following:

* Access
* Backing Up Your Work
* File Formats
* Metadata
* Permissions
* Data Integrity

C1 is informational; no project-specific deliverables.


## Module C2: Access and backing up your work

### Access

<table>
<tr><th>Level 1</th><th>Level 2</th><th>Level 3</th><th>Level 4</th></tr>
<tr>
<td>
<ul>
<li>Determine designated communities. </li>
<li>Create and make available descriptive metadata, such as title, abstract, keywords, or other information that is useful for discovery</li>
</ul>
</td>
<td>
<ul>
<li>Have publicly available documentation, user guides, or other materials that make your work legible to users</li></ul>
</td>
<td>
<ul>
<li>Have a publicly available access and use policy
</li>
</ul>
</td>
<td>
<ul>
<li>Provide access to the parts of the project that have become obsolete or difficult to access via a native environment and/or emulation
</li>
</ul>
</td></tr>
</table>


* **How high a priority this area is for your project?** Medium. Target users are experts or near-experts. Access for others is not actively, but active facilitation is low priority.
* **Your current level of sustainability practices.** In Level 1, we’ve identified communities, but we have not prioritized discovery, although we have non-structured metadata on site. Our documentation is geared to developers, not end-users, and therefore not Level 2, unless we define targeting an expert community as providing usability guidance (provision through obviation?). Our CC license is on every page, so Level 3 is complete. We are migrating all content (data and application) to public GitHub repo, and therefore slouching toward Level 4.
* **Your desired level of sustainability practices (as a goal to be achieved within the next three years).** Complete migration to GitHub (Level 4). End-user documentation is a goal, although not highest priority, and nobody has taken responsibility for it.
* **The resources and actions that will be required to meet your desired level.**  Complete migration to GitHub (in progress, completion is certain). Write end-user documentation (no activity or explicit planning yet). 

### Backing up your work

Level 4 is only slightly more secure than Level 1.

<table>
            <tr>
                <th>Level 1</th>
                <th>Level 2</th>
                <th>Level 3</th>
                <th>Level 4</th>
            </tr>
            <tr>
                <td style="vertical-align: top;"><ul>
                        <li>Document your reliable sites of project documentation including a description of their contents</li>
                        <li>Maintain two complete copies, stored separately</li>
                        <li>Reduce to a minimum data stored on heterogeneous types of media (hard drives, flash drives, etc.)</li>
                    </ul></td>

                <td style="vertical-align: top;"><ul>
                        <li>Keep an inventory of storage media and systems used and their technical requirements</li>
                        <li> Maintain three complete copies, with at least one copy in a different geographic location</li>
                        <li>Transfer all data from heterogeneous media (hard drives, flash drives, etc.) to a central storage system</li>
                    </ul></td>

                <td style="vertical-align: top;"><ul>
                        <li>Of the three copies, keep at least one in a geographic location with a different disaster threat</li>
                        <li>Routinely monitor your storage systems and media for obsolescence</li>
                    </ul></td>

                <td style="vertical-align: top;"><ul>
                        <li>Keep three copies in separate geographic locations, each with different disaster threats</li>
                        <li>Have a comprehensive plan in place to keep files and metadata on currently accessible media or systems</li>
                    </ul></td>
            </tr>
</table>

* **How high a priority this area is for your project?** Very
* **Your current level of sustainability practices.** Level 3. No crucial data on heterogeneous media. Complete copies on multiple machines (djb desktop and laptop, sometimes in different locations) and in the cloud (Dropbox, transitioning to GitHub).
* **Your desired level of sustainability practices (as a goal to be achieved within the next three years).** Level 3.
* **The resources and actions that will be required to meet your desired level.** Complete migration from Dropbox to GitHub to consolidate resource locations.

## Module C3: File formats and metadata

### File formats

Level 1 | Level 2 | Level 3 | Level 4
----|----|----|----
When possible, create files using a limited set of known open file formats | Maintain an inventory of all file formats used in your project | Routinely monitor your file formats for obsolescence issues | Perform format migrations, emulations, and other updating activities as needed

* **How high a priority this area is for your project?** Low
* **Your current level of sustainability practices.** Levels 1, 3, and 4; 2 is implicit.
* **Your desired level of sustainability practices (as a goal to be achieved within the next three years).** Level 4.
* **The resources and actions that will be required to meet your desired level.** At target level, so requires periodic verification, and possible intervention.

### Metadata

<table>
    <tr>
        <th>Level 1</th>
        <th>Level 2</th>
        <th>Level 3</th>
        <th>Level 4</th>
    </tr>
    <tr>
        <td style="vertical-align: top;">
            <ul>
                <li>Document your reliable sites of project documentation including a description of their contents </li>
            </ul>
        </td>
        <td style="vertical-align: top;"><ul>
                <li>Keep an inventory of file types and sizes </li>
                <li>Create and make available descriptive metadata, such as title, abstract, keywords, or other information that is useful for discovery</li>
            </ul>
        </td>
        <td style="vertical-align: top;"><ul>
                <li>Store administrative metadata, such as when files were created and with what technologies</li>
            </ul>
        </td>
        <td style="vertical-align: top;"><ul>
                <li>Store transformative metadata, such as a log of how files have been altered over time </li>
                <li>Store standard preservation metadata</li>
            </ul>
        </td>
    </tr>
</table>

* **How high a priority this area is for your project?** Low
* **Your current level of sustainability practices.** Level 1 in progress as part of migration to GitHub. Levels 2–4 are managed by GitHub (preservation metadata only where releases are published).
* **Your desired level of sustainability practices (as a goal to be achieved within the next three years).** Level 4.
* **The resources and actions that will be required to meet your desired level.** Complete GitHub migration.

## Module C4: Permissions and data integrity

### Permissions

<table>
    <tr>
        <th>Level 1</th>
        <th>Level 2</th>
        <th>Level 3</th>
        <th>Level 4</th>
    </tr>
    <tr>
        <td style="vertical-align: top;">
            <ul>
                <li>Permissions Identify which project members have login credentials to accounts and services used </li>
                <li>Identify which project members have read, write, move, and delete authorization to individual files</li>
            </ul>
        </td style="vertical-align: top;">
        <td><ul>
                <li>Restrict authorizations to only necessary team members </li>
                <li>Document access restrictions for services and files</li>
            </ul>
        </td>
        <td style="vertical-align: top;"><ul>
                <li>Maintain logs of who performs what actions on files, including deletions and preservation actions</li>
            </ul>
        </td>
        <td style="vertical-align: top;"><ul>
                <li>Perform routine audits of activity logs</li>
            </ul></td>
    </tr>
</table>

High priority; target is Level 2. With migration to GitHub, permission is controlled by GitHub and activity is logged at Level 3 automatically. Insofar as only David pushes to GitHub, all significant activity is implicitly attributable, and GitHub commit history adds date and time tracking, and therefore sequencing. Andrej has push access to GitHub repo, but does not commonly use it. Repo is public, so all have read access. Only David has write and admin permissions on Obdurodon.

### Data integrity

<table>
    <tr>
        <th>Level 1</th>
        <th>Level 2</th>
        <th>Level 3</th>
        <th>Level 4</th>
    </tr>
    <tr>
        <td style="vertical-align: top;">
            <ul>
                <li>Identify which project members have login credentials to accounts and
                    services used </li>
                <li>Identify which project members have read, write, move, and delete
                    authorization to individual files</li>
            </ul>
        </td>
        <td style="vertical-align: top;"><ul>
                <li>Be able to replace/repair corrupted data </li>
                <li>Create fixity information for stable project files</li>
            </ul>
        </td>
        <td style="vertical-align: top;"><ul>
                <li>Check fixity of stable content at fixed intervals</li>
            </ul>
        </td>
        <td style="vertical-align: top;"><ul>
                <li>Check fixity of stable content in response to specific events or
                    activities</li>
            </ul>
        </td>
    </tr>
</table>

Repair can normally be as easy as restoring from backup, but not if context has changed, so XML, schema, XSLT, etc. must be kept in sync. Fixity information is tricky because checksums don't distinguish significant from insignificant (informational from non-informational) change, so need to normalize before checksumming. 

Very important; target is Level 2. GitHub provides Level 2 conformance.

## Module C5: Digital Sustainability Action Plan

For each item in modules C2–C4 identify:

* Your chosen level of sustainability and the rationale for your decision
* The anticipated timeframe for attaining that sustainability level
* A catalog of individual actions you will take to reach your chosen level
* Specific team members who will be responsible for each of these sustainability actions
* A timeframe for completion of each action (should be fewer than three years)

|Access|||||
|----|----|----|----|----|
|1|2|3|4|5|

        <tr>
            <th colspan="5" style="font-size: larger;">Access</td>
        </tr>
        <tr>
            <th>Level</th>
            <td colspan="4">stuff</td>
        </tr>
        <tr>
            <th>Rationale for level</th>
            <td colspan="4">stuff</td>
        </tr>
        <tr>
            <th>Timeframe</th>
            <td colspan="4">stuff</td>
        </tr>
        <tr>
            <th colspan="5">Catalog of individual sustainability actions</td>
        </tr>
        <tr>
            <th>Technology</th>
            <th>Action</th>
            <th>Party responsible</th>
            <th>First step</th>
            <th>Timeframe for completion</th>
        </tr>
<table>
    <tbody color="gray;">
        <tr>
            <td colspan="5">[Template]</td>
        </tr>
        <tr>
            <td colspan="5">Level chosen (0 to 4)</td>
        </tr>
        <tr>
            <td colspan="5">Rationale for decision (including Level 0) [Includes options
                such as time constraints; staffing constraints; technology constraints;
                budget constraints; attention constraints; project contraints]</td>
        </tr>
        <tr>
            <td colspan="5">Timeframe for achievement of sustainability Level</td>
        </tr>
        <tr>
            <td colspan="5">Catalog of individual sustainability actions [Includes a list of
                all specific actions identified as being necessary to achieve your desired
                sustainability level, listed by technology]</td>
        </tr>
        <tr>
            <td>Technology</td>
            <td>Sustainability action</td>
            <td>Party responsible for sustainability action</td>
            <td>First step to be taken</td>
            <td>Timeframe for action completion</td>
        </tr>
    </tbody>
</table>



____

## Outcomes of workshop

### Awareness

* How project’s scope and intellectual goals relate to sustainability goals
* People and technologies on which the project depends, how they are connected, and how they are funded
* Knowledges that contribute to digital sustainability and specific tasks that can be taken to support project over time

### Documents

* List of sites of production
* Description of designated communities and significant properties
* Inventory of reliable sites of project documentation
* Spreadsheet mapping project team members, technologies used, and sources and duration of funding for each (B3)
* List of current and desired sustainability levels
* Action plan detailing specific sustainability actions and staff responsibilties for completing them (C5)

B3 and C5 are the deliverables; everything else is worksheets.


---

title: Brandopoly
date: 2014-12-12T12:00:00-08:00
excerpt: An enterprise-level SaaS app that made it easy for companies like Disney and HBO to control their brand identities.

permalink: /projects/brandopoly

section: Past Work
tags: [Brandopoly, SaaS, marketing, ABC, HBO]

license: Proprietary

---

In 2002, [Disney][1] and [HBO][2] came to [Bear Brook][3] with a problem: despite having clear brand identities and standards, it was difficult to enforce them across all of their marketing and sales teams. Disney, for example, had relationships with hundreds of [ABC Television][4]-affiliated stations, most of which it did not have direct ownership and had their own marketing and art teams. This lead to a number of different interpretations and violations of their brands and properties.

Bear Brook conducted numerous interviews and focus groups with various Disney and HBO teams and identified the core issue: in the regular course of their work, marketing and sales teams were sending out thousands of different pieces of material a year—each tailored to a specific goal or client—and ensuring every piece met corporate brand standards put too much stress on each team's budgets.

In 2003, Bear Brook came up with a solution called Brandopoly, a web app that marketing and sales teams could access from anywhere and be able to generate promotional and marketing materials on the fly. Instead of periodically getting a set of brand guidelines and having to start from scratch creating materials that complied to them, a salesperson could log into Brandopoly, find the exact piece of material they need, customize it to their specific need, and download a finished piece ready for printing. The whole process from log-in to download took seconds, down from the hours or days it normally took.

Both HBO and Disney were convinced: HBO placed their entire sales team on Brandopoly, while Disney gave Brandopoly to their entire network of ABC Television affiliates. Brandopoly became one of the main marketing and promotional tool for ABC Television for the next 10 years.

Here's the promotional video we did for one of the last updates of Brandopoly in 2013:

<iframe width="100%" height="373" src="//www.youtube.com/embed/fcv89phqglw" frameborder="0" allowfullscreen></iframe>

## Technology

From the start, Brandopoly consisted of two main parts: the front-end web app (called the brand management system or "BMS") and a set of back-end tools to create the customizable materials (called the compiler):

### Front-end (BMS)

The BMS's main purpose was to authenticate users and to provide the means for users to find the customizable materials they were looking for:

* User authentication was a normal user name and password system, however Disney opted to integrate Brandopoly directly into their intranet, so Brandopoly also supported a single sign-on system for them, allowing users to access Brandopoly as part of their regular intranet access. User validation during registration was done via a white-list of approved email domains.

* Content discovery was initially done through a categorization and curation system managed by Bear Brook with input from each client. As search tools matured over the years, a faceted search system (running off of [Apache Solr][5]) and a recommendation engine was added to supplement the categorization and curation.

Back in 2002, there weren't very many tested, off-the-shelf frameworks or content management systems available, so the BMS was developed with its own custom, (now-classic) ASP framework. By 2004, the BMS was ported to a LAMP stack, again as using its own framework. In 2009, given the maturity of available off-the-shelf components, the BMS was rewritten as a [Drupal][6] 6 application, allowing for less maintenance costs and a number of new ways to provide content for Brandopoly users afforded by having access to Drupal's contrib ecosystem. In 2011, the BMS was ported once again to Drupal 7.

### Back-end (Compiler)

The ultimate goal for the back-end was to be able to allow graphic designers with no programming knowledge to be able to use their existing tool-set (i.e. Adobe InDesign, Illustrator, and Photoshop) to create customizable materials for Brandopoly. Unfortunately, this wasn't feasible or cost-effective when Brandopoly was first developed. 

Instead, Brandopoly partnered with companies that provided their own vertically-integrated templating systems. Brandopoly employed a team of designers and producers that would work with clients to create the materials they needed whenever they needed them using these custom tools.

Once completed, the templates would then be compiled and published to the BMS. The dream of being able to use a regular production workflow was never lost, and in 2011, we rewrote the backend to use Adobe's [Scene7][7] engine. With the rewrite, Designers could now use InDesign to lay out templates and import them directly into Scene7 for use on the BMS.

Layouts and templates were just one part of the overall customization process: Brandopoly took customization one step further and provide a custom rules engine and domain-specific language to provide "smart" customized materials: materials could be configured to complete automatically based on a single user choice. For example, if an ABC affiliate wanted to customize a one-sheet for a new show, they could select the show and all the information about the show and who they are—the promotional copy, show times, and station logo—could be filled in automatically and be ready for download immediately. Later on, to reduce complexity and the designer learning curve, Brandopoly's custom DSL was replaced by Drupal's Rules module.

## Screenshots

<figure>
    <img src="/assets/images/brandopoly/front-page.png" alt="Front page for signed-in users">
    <figcaption>Front page for signed-in users</figcaption>
</figure>

<figure>
    <img src="/assets/images/brandopoly/faceted-search.png" alt="Faceted search">
    <figcaption>Faceted search</figcaption>
</figure>

<figure>
    <img src="/assets/images/brandopoly/custom-ad.png" alt="Ad customization">
    <figcaption>Ad customization. The array of gray buttons are designer and admin-level controls.</figcaption>
</figure>

<figure>
    <img src="/assets/images/brandopoly/custom-powerpoint.png" alt="PowerPoint customization">
    <figcaption>PowerPoint customization. The array of gray buttons are designer and admin-level controls.</figcaption>
</figure>

<figure>
    <img src="/assets/images/brandopoly/asset-download.png" alt="Front page for signed-in users">
    <figcaption>Asset download. The array of gray buttons are designer and admin-level controls.</figcaption>
</figure>


[1]: http://disney.com/ "Disney"
[2]: http://hbo.com/ "HBO"
[3]: http://bearbrook.com/ "Bear Brook"
[4]: http://abc.go.com/ "ABC Television"
[5]: http://lucene.apache.org/solr/ "Apache Solr"
[6]: http://drupal.org/ "Drupal"
[7]: http://www.adobe.com/solutions/web-experience-management/scene7.html "Adobe Scene7"
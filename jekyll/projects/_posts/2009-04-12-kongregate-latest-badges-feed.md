---

title: Kongregate Latest Badges Feed
date: 2009-04-12T20:53:57-07:00
excerpt: A Feed43 pattern for creating a badge feed for Kongregate.
note: Kongregate no longer provides badge information in a format that is easily parseable.

permalink: /projects/kongregate-latest-badges-feed

tags: [Kongregate, Feed43, RSS]

license: MIT

layout: post

---

[Kongregate][1] is a great site for online Flash gaming, combining the ease of use of Flash with the addiction of an achievement system. However, for some reason, they don't provide an RSS feed of the latest badges added to the site. So, I've created a feed using [Feed43][2] you can use to view badges as they come in.

Feed URL: `http://feed43.com/2506827300517453.xml`

If you're interested in how I got the right parameters for this feed, read on.

I've protected the specific feed listed here so I don't have to go and recreate it should some jokester mess with it, but I'll outline the parameters I used here so you can recreate or tweak it for your own use:

## Part 1 — Specify Source Address (URL)

* Address: *http://kongregate.com/badges*
* Encoding: leave blank

Click the switch to advanced mode link to continue on.

## Part 2 — Define Extraction Rules

{% raw %}
* Global Search Pattern: leave blank
* Item (repeatable) Search Pattern:
```
<div class="view_badgeinfo"{*}href="{%}"{*}src="{%}"{*}<dd class="badge_name">{%}</dd>{*}<dd class="badge_difficulty">{%}</dd>{*}<dt class="achievement_description">{%}</dt>{*}</div>
```
* RSS Feed Properties:
  * Feed Title: *Kongregate - Latest Badges*
  * Feed Link: *http://kongregate.com/badges*
  * Feed Description: *Kongregate: Play Free Games Online*
* RSS Item Properties
  * Item Title Template: `{%3} {%4}`
  * Item Link Template: `{%1}`
  * Item Content Template: `{%5}`
{% endraw %}



And that's it!

[1]: http://kongregate.com "Kongregate"
[2]: http://feed43.com "Feed43"

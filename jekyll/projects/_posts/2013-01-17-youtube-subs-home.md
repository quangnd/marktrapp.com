---

title: YouTube Subs as Home
date: 2013-01-07T16:52:40-08:00
excerpt: A Safari extension to set the YouTube home page to the subscriptions feed.

permalink: /projects/youtube-subs-home

tags: [extension, Safari, YouTube, GPLv2 license]

license: GPLv2 only

layout: project
highlighting: true

repository: https://github.com/itafroma/youtube-subs-as-home
downloads:
    - title: YouTube Subs as Home 1.0.3
      file: YouTubeSubsAsHome-1.0.3.safariextz

---

One of the most annoying things about the late 2012 vintage of YouTube is that the home page is an amalgam of your subscriptions (not in reverse chronological order, of course) and YouTube's recommendations. I'd rather just have the home page be my subscriptions feed, so when I click on the YouTube logo, it takes me there instead of a page I don't care about.

This is easily fixed by a single line of JavaScript:

```javascript
document.getElementById('logo-container').href = '/feed/subscriptions'
foo();
```

However, if you're the set-it-and-forget-it type, I wrote a small extension for Safari that fixes this problem and a couple of additional annoyances. More specifically, it changes following:

* Clicking the YouTube logo will take you to your subscriptions feed.
* Clicking What to Watch in the guide menu will take you directly to the highlights feed instead of the home page.
* If you navigate to www.youtube.com or youtube.com directly, you will automatically be redirected to your subscriptions feed.

## Copyright and license

This project is copyrighted 2013 myself where applicable. It is licensed via the [GPL (v2 only)][1].

[1]: http://www.gnu.org/licenses/gpl-2.0.html "GNU General Public License, version 2"

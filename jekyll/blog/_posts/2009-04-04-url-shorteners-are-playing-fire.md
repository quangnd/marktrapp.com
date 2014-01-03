---

title: URL Shorteners Are Playing with Fire
date: 2009-04-04T09:24:08-07:00
excerpt: URL shorteners, due to their very nature, may be on borrowed time. One step by Google and the entire industry collapses like the house of cards it is.

categories: [commentary]
tags: [Dave Winer, Digg, Google, Jason Kottke, Joshua Schachter, URL shorteners]

license: none

layout: post

---

Yesterday, Joshua Schachter had an [excellent piece][1] on the perils of the URL shortener: it’s clear, concise, and scathing. [Jason Kottke][2] and [Dave Winer][3] had a few suggestions on how to mitigate the problem, or get us on the right track to eventually deprecating the use of URL shorteners.

I agree with Schachter’s assessment, and I think Kottke and Winer are on the right track, but I think the URL shortener problem is far greater than what Schachter enumerates: no longer satisfied with controlling the initial click, URL shorteners have decided to add toolbars to promote ther content or to sell adspace: the most notable and recent addition to this group is Digg’s toolbar, [DiggBar][4]. Dubious utility aside, they are trampling in the garden of an angry god.

## The 800lb Gorilla: Google

For better or for worse, all things link-related must pass Google’s standards. Google’s search engine depends on high quality, relevant results determined, in no small part, in how the web links together. It’s something Google protects with its blacklisting policy: you do something Google doesn’t like, and [your links disappear from Google’s index][5]. It’s as if they didn’t exist at all.

Although it sounds like the 21st Century equivalent of Big Brother, they do at least give a clear indication of what is not acceptable, so you can avoid doing it if you want to play nice with Google. You follow those, you’re probably in favor with Google.

## The Doorway Page

But in reflecting upon the topic of toolbar URL shorteners, there’s one set of policies that caught my attention, on [cloaking, sneaky Javascript redirects, and doorway pages][6]:

> Doorway pages are typically large sets of poor-quality pages where each page is optimized for a specific keyword or phrase. In many cases, doorway pages are written to rank for a particular phrase and then funnel users to a single destination.
>
> Whether deployed across many domains or established within one domain, doorway pages tend to frustrate users, and are in violation of our webmaster guidelines.
>
> Google’s aim is to give our users the most valuable and relevant search results. Therefore, we frown on practices that are designed to manipulate search engines and deceive users by directing them to sites other than the ones they selected, and that provide content solely for the benefit of search engines. Google may take action on doorway sites and other sites making use of these deceptive practice, including removing these sites from the Google index.

It seems to me the toolbar URL shorteners are treading dangerously close to Google’s definition of a “doorway page:” all it takes is Google to classify them as such and Digg, of all sites, disappears from Google’s index. Think of that concept: Digg, by far, gets most of its traffic from organic search results. Why would they even risk it?

## Wrapping Up

While I agree with Schachter, Kottke, and Winer about the problems of URL shortening, I think those of us against the practice of URL shorteners (and at least for me personally, especially the use of toolbar URL shorteners) could soon have a powerful friend in Google. One step by Google towards classifying URL shorterners would mark the death of the practice: I’m not sure it’s worth the risk for any of us to use them.

## Update

In the intervening years since this post was written, URL shortening has been on a rollercoaster ride. Dozens of URL shortening services have cropped up and [just][7] as [many][9] have [died off][9]. In April of 2010, [Digg discontinued the DiggBar][10], killing off the largest of the “doorway page”-like URL shorteners, while in October of 2011, Twitter began [shortening all links][11] sent through its service, dwarfing all other URL shortening services combined.

[1]: http://joshua.schachter.org/2009/04/on-url-shorteners.html "On URL Shorteners"
[2]: http://www.kottke.org/09/04/url-shorteners-suck "URL shorteners suck"
[3]: http://scripting.com/stories/2009/04/03/joshIsRightUrlShortenersAr.html "Josh is right, URL shorteners are risky"
[4]: http://readwrite.com/2009/04/02/digg_launches_diggbar "Digg Launches New Toolbar - Makes Digging and Sharing Easier"
[5]: http://www.informationweek.com/fear-the-google-blacklist/d/d-id/1064610? "Fear The Google Blacklist"
[6]: https://support.google.com/webmasters/answer/66355?hl=en "Webmaster Tools - Cloaking"
[7]: http://mashable.com/2009/08/09/trim-shuts-down/ "Tr.im URL Shortener Shuts Down; Short Links to Die?"
[8]: http://mashable.com/2009/10/04/cli-gs-shut-down/ "Cli.gs URL Shortener To Shut Down"
[9]: http://www.afterdawn.com/news/article.cfm/2013/10/13/yahoo_buys_url_shortener_bread_shuts_down_service "Yahoo buys URL shortener Bread, shuts down service"
[10]: http://techcrunch.com/2010/04/06/diggs-kevin-rose-diggbar-is-bad-for-the-internet-so-were-killing-it/ "Digg's Kevin Rose: DiggBar Is Bad For The Internet, So We’re Killing It"
[11]: https://dev.twitter.com/discussions/2806 "All URLs regardless of their length are now automatically wrapped with t.co"

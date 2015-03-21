---

title: What’s changed and what to expect
date: 2014-01-04T20:40:00-08:00
excerpt: Some thoughts about the changes to this blog and what will change in the future.

section: Meta

license: none

---

Travel back to 2007 and 2008. Obama hadn‘t been elected, everyone was upset with the [*Sopranos* series finale][1], and the [Great Recession][2] was just beginning to hit. Back then, the whole “web 2.0” thing was in full swing, and it seemed like every other day someone was launching a new social network. Twitter was just taking off with the masses, and most assumed Facebook was unbeatable. Google was still experimenting with [Jaiku][3]. [Plurk][4] was a thing.

And I was into all of it. I must’ve had 100 or more accounts on every social site out there. And I loved to talk about them: what they [did right][5], what they [did wrong][6], and [how people should be using them][7]. Hobnobbing with other people into social media and [getting mentioned][8] on lists of people to follow: it was all good stuff.

Now, with the benefit of 20/20 hindsight, it all seems silly, but it was under that atmosphere this blog was created in 2008 and most of the posts were written.

And around 2010, I grew out of it: I had transitioned to a role that minimized my time to focus on the whole social media rat race, and I started focusing on other interests. Blog posts slowed to a trickle, then stopped almost altogether: just one blog post about something I felt passionately about once a year and that was it.

There hasn’t been a dearth of topics I wanted to talk about, but I never felt like I had time until now. So there’s going to be some changes:

## What’s changed already

The first thing to go was [Drupal][9]. When I first created this site, I was getting into a lot of professional Drupal development, so I created the site in Drupal 6(!). The more I’ve used Drupal, the more I think it’s great at really specific types of large projects and really bad at everything else. Unless you’re heavily invested in the Drupal community and need to dogfood your work, using Drupal for a personal blog is probably overkill and more trouble than it’s worth.[^1]

Instead, I found myself looking for something I can just use a text editor to update and maintain. I thought about writing my own blog system like many programmers wind up doing, but I put it off so long that luckily a solution that’s good enough came along in 2012: [Jekyll][10]. With a bit of practice with Ruby, I was able to get what I wanted out of it and create the site you see now.

Because it’s easy to keep everything in a VCS, I decided to open source the whole thing: you can find the [repository on Github][11]. The [README][12] explains a bit more about how to install it and what the licensing is. I don’t seriously expect anyone to create mirrors of marktrapp.com, but it’s all there to take inspiration from if you wanted to do something similar to what you see here.

Now that the whole site is on a public repository, I’ve also added links to the revisions and history for every blog post and project page on the right sidebar. There’s also a link to suggest changes in case I make a mistake: I’m not sure if it’ll get much use, but it’ll be an interesting experiment.

Finally, I’ve unpublished a few blog posts that were poorly thought-out or really time-specific. Like the rest of the blog, those posts will still be available in the source repository as historical artifacts, [marked with the `hidden` tag][13].

## Plans for the future

Like I said, I want to write more, but on less timely or “in the news“ subjects. There will likely be a lot of technical posts about programming or management, but I also want to write about interests I have but don’t get to talk about very often: science fiction, fantasy, gaming, and maybe even a bit about the technical aspects of Christianity.[^2] It’s always a risk to talk about disparate topics in one place. But I don’t see myself maintaining multiple blogs, so want to try it out and see what happens.

I also plan on cleaning up and open-sourcing a lot of personal projects I have been tinkering with over the years. They’ll always show up under [Projects][14], but also on my [Github profile][15].

If all that sounds interesting, cool: I hope I can keep you interested. Otherwise, if they don’t or you are still somehow following me after all these years for my snarky quips about social media, I apologize ahead of time and wouldn’t be offended if you moved on.

Either way, here’s to a productive new year.

[^1]: It didn’t help that my website was still running Drupal 6, but I have a good deal of experience with Drupal 7 and it would not have made things any easier. Drupal 8, still in alpha, is even more complicated and overkill for all but the most complex of website projects.
[^2]: I do mean *technical*: I neither want to, nor am I equipped to, proselytize or preach.

[1]: http://en.wikipedia.org/wiki/Made_in_America_(The_Sopranos)#Interpretations_of_the_final_scene "Wikipedia particle on the interpretations of the final scene of the Sopranos series finale"
[2]: http://en.wikipedia.org/wiki/Great_Recession "Wikipedia article on the Great Recession"
[3]: http://en.wikipedia.org/wiki/Jaiku "Wikipedia article on Jaiku"
[4]: http://en.wikipedia.org/wiki/Plurk "Wikipedia article on Plurk"
[5]: https://marktrapp.com/blog/2009/04/06/real-time-killed-web-20-star/ "Real-time killed the web 2.0 star"
[6]: https://marktrapp.com/blog/2009/10/29/twitter-lists-make-twitter-dangerous-use/ "Twitter lists make Twitter dangerous to use"
[7]: https://marktrapp.com/blog/2009/01/03/armchair-entrepreneuring/ "Armchair Entrepreneuring"
[8]: http://scobleizer.com/2008/09/26/the-scoble-top-tech-bloggerfriendfeedsocial-media-list/ "The Scoble Top Tech Blogger/FriendFeed/Social Media List"
[9]: https://drupal.org "Drupal project page"
[10]: http://jekyllrb.com "Jekyll project page"
[11]: https://github.com/itafroma/marktrapp.com "Github repository for marktrapp.com"
[12]: https://github.com/itafroma/marktrapp.com/blob/production/README.md "README for marktrapp.com"
[13]: https://github.com/search?l=Markdown&q=hidden+repo%3Aitafroma%2Fmarktrapp.com&type=Code "Github search for hidden posts"
[14]: https://marktrapp.com/projects "Projects page"
[15]: https://github.com/itafroma "My Github profile"

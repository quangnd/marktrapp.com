---

title: BuddyFeed, a Native FriendFeed Client
date: 2009-01-16T04:56:52-08:00
excerpt: BuddyFeed is a promising native iPhone client for FriendFeed, but there are a few things it fails to handle which probably makes it a non-starter for most people, even for its relatively small price tag of 99 cents.
note: This app is no longer available.

published: false
section: Social Media
tags: [BuddyFeed, FriendFeed, iPhone, review]

license: none

---

One of the things that’s been missing from FriendFeed has been a native iPhone client. Sure, there’s the [iPhone version of the website][1], and there’s [FFToGo][2], but they both miss a lot of administrative features of FriendFeed and don’t provide the lustery UI of a native app. Recently, a third-party FriendFeed iPhone app came out called [BuddyFeed][3]. It’s promising, but there are a few things it fails to handle which probably makes it a non-starter for most people, even for its relatively small price tag of 99 cents. It also has a few UI failures that really need to be addressed.

## Overview

Like all good third-party FriendFeed clients, BuddyFeed asks for your username and remote key, indicating it’s working off the standard, [third-party API FriendFeed provides][4] and not off of some magical scraping technique. This is great for users who are [wary of giving their authentication information][5] to third parties, but it also highlights just how far BuddyFeed is able to go: if FriendFeed doesn’t provide it, BuddyFeed can’t do it. A FriendFeed client written by FriendFeed itself probably won’t have those same restrictions.

The UI is pretty standard iPhone app fare: which is a Good Thing. Most functions are available from a single click or within 2 clicks. You can subscribe and unsusbscribe from people (something you can’t do on the FriendFeed iPhone website or FFToGo), get to your rooms, see your own feed, see your likes and comments, and post messsages (including messages while using the built-in iPhone camera). However, there are two glaring omissions:

## No hiding, no lists

Two of FriendFeed’s main features for filtering your stream, hiding and lists, are completely missing from BuddyFeed. I’ve seen these missing from other third-party FriendFeed apps, so I wonder how much that has to do with the third-party API BuddyFeed uses. Regardless of the cause, the lack of hide support breaks FriendFeed in a big way, and the lack of lists is a sorely missed feature from FriendFeed proper.

## Quirky User Interface

BuddyFeed also suffers from some really odd UI quirks. In order to see comments and likes, or to make your own comment or like, you can’t just feed item a story, you have to touch the feed item in the lower right hand corner, in an unmarked area. If you don’t, the feed item goes to whatever it was linked to (for example, an external webpage).

The other big failure is the choice of icon for the comment function: it’s a “go back” arrow. It took me a while, and a blind guess, to divine that the arrow meant “comment.” It really needs to be changed.

## Conclusion

BuddyFeed looks pretty promising, and the lack of lists and the odd UI choices are forgivable, but the lack of hide support is not. If you use FriendFeed at all on a regular basis, the lack of hide is probably going to stop this show.

## Update

Robin Lu, the developer of BuddyFeed, just sent me this response:

> Hi Mark,
>
> Great thanks for trying the app and giving all the suggestions.
>
> 1. The “hide” setting will be honored in the next version.
> 2. “List” support will be added for the next version.
> 3. The icon is the native one for “Reply”. You may find the same icon in the “Mail” for replying the mail. Maybe I should change it to the one as “Post”.
>
> Best Regards, Robin Lu

Sounds good to me. Here’s to the next version!

[1]: http://friendfeed.com/iphone "FriendFeed for iPhone website"
[2]: http://fftogo.com/ "FFToGo website"
[3]: http://www.codewalrus.com/buddyfeed/ "BuddyFeed website"
[4]: http://friendfeed.com/api/ "FriendFeed API"
[5]: https://marktrapp.com/blog/2009/01/07/testing-testing-1-2-3 "Testing, Testing, 1-2-3"

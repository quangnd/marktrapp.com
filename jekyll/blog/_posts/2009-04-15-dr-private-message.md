---

title: Dr. Private Message
date: 2009-04-15T09:54:42-07:00
excerpt: "Or: How I learned to stop worrying and love the web. We ought not to fear because the problem of private messages is too hard: we ought to fear because we’ve already solved them yet won’t use that knowledge."

section: Social Media
tags: [Rob Diana, John Bredehoft, federation, private messages, Alexander van Elsas, commentary]

license: none

layout: post

---

Today, Alexander Van Elsas had a sort of [95 Thesis/20 Questions amalgam][1] about a host of issues involving the state of the internet today. One set of questions provoked a couple points of discussion from [Rob Diana][2] and [John Bredehoft][3]:

> ### Networks and destinations
> 1. If everything becomes open and connected, what will happen to the big destinations?
> 2. Why is the web rapidly evolving into uncountable databases with connections, instead of one database where everything connects?
> 3. If all services and destinations become open, then what is the point in being a destination site in the first place?
> 4. Why are we creating webs within webs, instead of one network that connects it all?

Rob Diana [suggests][4] that your email inbox might be the gateway for all of these siloed communication systems, or that the messages from these systems might be pushed to one specific user destination (be it email or something else, like a cell phone).

John Bredehoft, in a comment to Rob’s post, argued that we need to have multiple destinations, as each destination is a context in and of itself: one communicates with FriendFeed friends on FriendFeed, or Facebook friends on Facebook, or email friends through email, to ensure maximal participation.

John and Rob touch on two parts of the greater communications problem, but there’s something unsatisfying in both of their answers, especially as it relates to Alexander’s final question: why are we creating webs within webs, instead of one network that connects it all? I think the answer to this question is likely a house of cards: we should be creating a network by which we can tie these all together. A revolution? Not really: this is the foundation of many of the oldest communication systems on the block: DNS, telephony, and email.

## United Federation of Messages

*Federation*, a term that seemed to come into vogue with the rise of XMPP, describes a concept that’s been around for decades, long before web 2.0, and long before there was an internet. It basically entails the following:

* There is one standard, vetted by the community, by which all participants should conform. Some parts of the standard should be baseline: all participants must implement it. Other parts of the standard might be implemented by many or few of the participants.
* All destinations have a largely unique piece of information to identify themselves to the greater network of participants. For email, it’s your email address. For DNS, it’s a name server. For telephony, it’s a phone number.
* The standard must identify the logical path a participant must take in order to reach a uniquely identified destination. In most instances, this is a concept called *routing* and it identifies computers (routers) that will relay messages to other computers to ensure messages reach the proper destination.

Federation works brilliantly. Because of these three criteria, I can set up a computer made of scrap parts in my bedroom that can send email to anyone in the world and serve DNS. It doesn’t matter who participates: everyone has more or less equal access to everyone else. This is a concept called *network neutrality*. You may have heard about political issues involving this: it’s currently a right protected by most governments because of the value of federation.

## Facebook is not the standard

Somehow, the concepts of network neutrality and federation have been lost with the rise of web 2.0: even though everyone talks about “open APIs”, “transparency”, and other buzzwords, nothing really talks to each other. Each system implements its own standard, and leaves it up to everyone else to figure out if and how they want to communicate with that system.

To use email as an example: imagine having 100 competing systems of email where none of them talk to each other. You have to have 100 different email addresses in order for it to work. Some enterprising individuals have come up with ways to link email addresses together (so you can have one email address), but it only works on about 5 of the email systems, and requires you registering yet another email addresses (so now you have 101).

We’re into silly territory, but this is the state of the web, and more importantly, messaging, today. But this problem has already been solved, over and over again: there’s no reason to come up with a completely new method for handling the multitude problem.

## Where has the cabal gone?

Attempts at interoperability, via “standards” like OpenID, OpenSocial, OpenMicroBlogging, are primitive and re-imagine tried and true concepts. A lot of times, the advocacy of such technology feels like a guy marveling at his ability to make a fire (which he claims he invented, and calls it OpenMiracleLight) a thousand years after fire was perfected and turned into all sorts of useful things, like heating and electricity.

Back in the 70s and 80s, there were tons of smart people who came up with the standards for the backbones of technology we use today: what happened to them? Why isn’t their work being used to progress the web?

They say those who don’t learn from history are doomed to repeat it: why do we need to keep resolving the same problems?

[1]: http://vanelsas.wordpress.com/2009/04/03/questions/ "Questions"
[2]: http://regulargeek.com/ "Rob Diana’s website"
[3]: http://empoprise-bi.blogspot.com/ "John Bredehoft’s website"
[4]: http://regulargeek.com/2009/04/15/with-all-this-openness-where-is-the-destination/ "With All This Openness Where Is The Destination?"

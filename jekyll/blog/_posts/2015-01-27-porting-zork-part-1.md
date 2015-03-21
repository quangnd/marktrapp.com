---

title: "Porting Zork — Part 1: Introduction"
date: 2015-01-27T02:00:00-07:00
excerpt: The first part in a series on porting Zork to modern languages.

section: Programming
tags: [Zork, MDL, Infocom, porting]

license: none

---

The classic text adventure game [*Zork*][1] has had a special place in my heart for a long time: I've been hard pressed to think of a game I might have even played before delving into the white house and succumbing to the appetite of a [grue][2]. Regardless of whether it is the first game I played, I credit it—at least in part—for sparking my interests in gaming, artificial intelligence, language, and programming.

As an ode to it and the influence it's had on me, I've always wanted to do something involving *Zork*. I've tossed around various ideas—creating my own adventure game, writing a [Z-machine][3] parser—and ultimately decided on porting it from its original incarnation into other languages as a way to both understand the original creators' design. It'd also be nice to have a more interesting "hello world"-type project for playing around with languages I'm not familiar with than the bog-standard "write a blog platform".

I've created a [repository on Github][4] to track this project and this series of blog posts will act as my implementation notes throughout the porting process.

## Background

*Zork* was written between 1977 and 1979 by four members of MIT's Laboratory for Computer Science Dynamic Modeling System ([MIT-DMS][5]): [Tim Anderson][6], [Marc Blank][7], [Bruce Daniels][8], and [Dave Lebling][9]. Eventually, they (and a number of other [implementers][10]) would go on to form [Infocom][11], a company that specialized in text adventure games in the style of *Zork*.

While *Zork* has been ported countless times, it was originally written in the [MIT Design Language][12] (MDL, pronounced "muddle"). Designed in 1971, MDL is a functional language reminiscent of Common Lisp and Scheme. However, unlike those languages, MDL has been obsolete since the early '80s and lacks a lot of the syntax sugar and language constructs we take for granted today.

The MDL source code has been floating around the Internet for the past few decades, and I've [included it in my repository][13] for reference purposes.

## Porting goals

In porting, my intention is to create as faithful an adaptation as possible without going too overboard. I'll discuss some specific examples later on, but in general:

- Data structures will be maintained as close to the original source as possible.
- Program flow will be maintained as close to the original source as possible.
- If the MDL source code contains subroutines that are simply userland definitions of language constructs that already exist in the target language, I will use the target language's construct instead of porting MDL emulation of it.
- MDL language constructs that do not exist in the target language—but should not affect program flow—will not be ported.

The end result should match the original *Zork* feature-for-feature, if not necessarily bug-for-bug.

## Process

Of course, I have to start somewhere, and I've decided to port *Zork* first to PHP, a language I'm deeply familiar with. In order to understand the MDL code, I'll be using the reference manual *The MDL Programming Language* by S. W. Galley and [Greg Pfister][14].

The original source code is split into 19 files, each containing a mixture of subroutines, forms, and expressions. Right now, porting each file one-by-one seems like a great way to split everything up. If I find a cross-reference to another file, I'll port the minimum amount of relevant code to resolve the cross-reference.

The first file I've ported is the shortest of them all: [`prim.mud`][15]. It contains a few subroutines for manipulating *Zork*'s basic data structures.

Continue on to part 2: "[Data structures][16]".

[1]: http://en.wikipedia.org/wiki/Zork "Wikipedia article on Zork"
[2]: http://en.wikipedia.org/wiki/Grue_%28monster%29#Zork_lore "Wikipedia article on grues in Zork lore"
[3]: http://en.wikipedia.org/wiki/Z-machine "Wikipedia article on Z-machine"
[4]: https://github.com/itafroma/zork-php "Github repository for the Zork porting project"
[5]: http://pdp-10.trailing-edge.com/mit_emacs_170_teco_1220/01/info/mit-dm.txt.html "Information on MIT-DMS"
[6]: http://en.wikipedia.org/wiki/Tim_Anderson_(Zork) "Wikipedia article on Tim Anderson"
[7]: http://www.infocom-if.org/authors/blank.html "Infocom author page on Marc Blank"
[8]: http://en.wikipedia.org/wiki/Bruce_Daniels "Wikipedia article on Bruce Daniels"
[9]: http://www.infocom-if.org/authors/lebling.html "Infocom author page on Dave Lebling"
[10]: http://en.wikipedia.org/wiki/Implementer_(video_games) "Wikipedia article on implmenters"
[11]: http://www.infocom-if.org/company/company.html "Infocom company history"
[12]: http://en.wikipedia.org/wiki/MDL_(programming_language) "Wikipedia article on MDL"
[13]: https://github.com/itafroma/zork/tree/master/src/mdl "Zork MDL source code"
[14]: http://perilsofparallel.blogspot.com "Greg Pfister's blog"
[15]: https://github.com/itafroma/zork/blob/master/src/mdl/prim.mud "prim.mud source code"
[16]: https://marktrapp.com/blog/2015/01/27/porting-zork-part-2/ "Porting Zork — Part 2: Data structures"

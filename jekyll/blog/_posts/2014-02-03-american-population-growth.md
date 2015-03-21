---

title: Visualizing US city and state growth with Wormtrails
excerpt: A few thoughts and observations using the Wormtrails library to visualize US census data.
note: The full-size versions of the graphs in this blog post are gigantic and very mobile unfriendly. You’ve been warned!

section: Programming
tags: [Lisp, Common Lisp, Wormtrails, Zach Beane, US Census, graphs]

license: none

---

A couple of weeks ago, [Kevin Fox][1] tweeted a link to [Peakbagger.com][2]’s “[Historical Metropolitan Populations of the United States][3]” and asked [if there was a way to improve it][4]. I immediately thought of [Zach Beane][5]’s [movie box office streamgraphs][6] that went viral a couple of years ago. Fortunately, Beane open-sourced the library used to create them, [*Wormtrails*][7]. Less fortunately for me, it was written in Common Lisp, a language I haven’t used in almost a decade.

But after a few hours of refamiliarization, I was able to cobble together a wrapper library, which I uncreatively call [*Wormtrails CSV*][8], that takes a CSV file as input and outputs a chart that resembles Beane’s movie box office graphs.

## State census data

The first test of this new library was a relatively simple one: using decennial US Census Data, I plotted the populations of the original 13 states over time:

<figure>
    <a href="original-13-states"><img src="/assets/images/wormtrails/states-original-13-thumb.png" alt="Wormtrails graph of the population of the original 13 US states over time"></a>
    <figcaption>Wormtrails graph of the population of the original 13 US states over time. <a href="original-13-states">Full size</a>.</figcaption>
</figure>

With this example, you can see some obvious properties like the gradual population expansion over time and New York’s relative population dominance since the early 19th century. There is one interesting feature: Georgia seemed to be destined to be in the bottom tier when compared to the other original 13 states, but its fortune did a 180 in the 1970s, overtaking New Jersey in the last census to become the 3rd most populous state of the original 13.

Another interesting feature is the sharp drop in New Jersey’s ranking, which leads to an important caveat with *Wormtrails*-style graphs. Even though they have a superficial resemblance to a line graph that tracks absolute numbers, the position of a particular “worm” at any point along the x-axis merely denotes its ranking amongst the other “worms” at the same point. New Jersey did not suddenly have a population drop-off between 2000 and 2010: in fact, its population grew. It’s merely that the populations of Georgia and North Carolina grew faster, leading to their populations being higher than New Jersey’s in 2010 but not in 2000.

With the first basic test done, I decided to see what it would look like with all 50 states:

<figure>
    <a href="all-states"><img src="/assets/images/wormtrails/states-thumb.png" alt="Wormtrails graph of the population of all 50 US states over time"></a>
    <figcaption>Wormtrails graph of the population of all 50 US states over time. <a href="all-states">Full size</a></figcaption>
</figure>

This one is really wacky and hard to read, but quite colorful. The additional color comes from how the *Wormtrails* library colors worms: the worms that first appear in the first time period (in this case, the 1790 census) are colored different shades of red. It then varies the hue for worms that first appear later. In this example, states that were first counted in 1820 are colored yellow, those that were first in 1850 are green, and so on.

Like the first example, we can see some interesting trends:

* California, Texas, and Florida experienced massive relative population growth beginning in the Great Depression: first California in the 1930s, then Texas 2 decades later, followed by Florida a decade after that.
* Georgia’s relative growth turnaround is more pronounced when compared to 49 other states, and it’s joined by Arizona and Washington that also experienced relative growth shifts in the 1970s.

However, comparing this second example to the coloring used in Beane‘s box office graphs, it seems at first blush there might be something wrong: why do his graphs look aesthetically ordered whereas the state graph looks like a unicorn had a bad lunch? The difference is that box office receipts for a particular movie are relatively ephemeral: movies drop off the charts faster than the *Wormtrails* shifts hues.

In comparison, there’s rarely ever any negative populationg growth amongst states, and because this example tracks all 50 states, none of them ever drop off the chart. By the time the graph reaches the 2010 census, reds are mixing with greens, blues with yellows, purples with oranges, and it’s total anarchy.

So I decided to see what would happen if the graph was limited to just the top 10 states over time:

<figure>
    <a href="top-10-states"><img src="/assets/images/wormtrails/states-top-10-thumb.png" alt="Wormtrails graph of the population of the top 10 US states over time"></a>
    <figcaption>Wormtrails graph of the population of the top 10 US states over time. <a href="top-10-states">Full size</a></figcaption>
</figure>

This example is a bit less crazy than the one with all the states, but it’s still a jumble of colors. It’s easy to infer from this that by 1870, once a state gets into the top 10, it stays there, with the exception of a number of states dancing about the bottom of the top 10.

## Metropolitan population data

States aside, the real reason for this exercise was to reimagine Peakbagger.com’s city population charts:

<figure>
    <a href="peakbagger-cities"><img src="/assets/images/wormtrails/peakbagger-cities-thumb.png" alt="Wormtrails graph of Peakbagger.com’s US metro populations"></a>
    <figcaption>Wormtrails graph of Peakbagger.com’s US metro populations. <a href="peakbagger-cities">Full size</a></figcaption>
</figure>

Right away, I dropped Peakblogger.com’s metro data before 1790: the difference between the start and end of the graph is so large that they’d be invisible. Even anything prior to 1910 is unreable by scanning. The two biggest takeaways from this illustration are:

* The US urban population has ballooned tremendously since the country’s inception, and it seems to have had exponential growth right from the start. There’s definitely a noticeable bump in the 1950 census, but beyond that there aren’t any other noticeable anomalies to urban growth. Intuitively, I would’ve expected to see a spike during the 19th century immigration waves and during the industrialization period at the turn of the 20th century.
* While other cities have come, gone, and swapped ranks, New York is, and almost always has been, king.

Because of the scaling issues, I wanted to see what would happen if the timeline was split in two. Here’s 1790–1890:

<figure>
    <a href="peakbagger-cities-1790-1890"><img src="/assets/images/wormtrails/peakbagger-cities-1790-1890-thumb.png" alt="Wormtrails graph of Peakbagger.com’s US metro populations, 1790–1890"></a>
    <figcaption>Wormtrails graph of Peakbagger.com’s US metro populations, 1790–1890. <a href="peakbagger-cities-1790-1890">Full size</a></figcaption>
</figure>

While New York dominates the graph as before, there are still some interesting aspects that weren’t readily apparent on the full graph. For example, a number of upstate New York cities make the list for a few decades: Albany, Buffalo, Rochester, and Syracuse. While Albany was fairly populous from the start, the others no doubt are in the top 20 due to the completion and subsequent use of the Erie Canal. Chicago’s entry around the same time is almost certainly causally connected.

Now to look at 1900–2010:

<figure>
    <a href="peakbagger-cities-1900-2010"><img src="/assets/images/wormtrails/peakbagger-cities-1900-2010-thumb.png" alt="Wormtrails graph of Peakbagger.com’s US metro populations, 1900–2010"></a>
    <figcaption>Wormtrails graph of Peakbagger.com’s US metro populations, 1900–2010. <a href="peakbagger-cities-1900-2010">Full size</a></figcaption>
</figure>

New York doesn’t dominate as much, especially once Los Angeles’s population picks up during the Great Depression. Rust Belt cities like Cincinnati, Cleveland, and Pittsburgh drop off the list entirely between 1970 and 1990. And the top cities at the start of the 20th century mostly stayed that way until the latter half, when Texan, Floridian, and Western cities start to populate the 10–20 spots.

One last example: what *would* happen if the scale was increased to allow the earlier cities to be seen? I decided to increase the scale to the maximum SBCL would allow before exhausting its heap:

<figure>
    <a href="peakbagger-cities-full-scale"><img src="/assets/images/wormtrails/peakbagger-cities-full-scale-thumb.png" alt="Wormtrails graph of Peakbagger.com’s US metro populations at max scale"></a>
    <figcaption>Wormtrails graph of Peakbagger.com’s US metro populations at max scale. <a href="peakbagger-cities-full-scale">Full size</a></figcaption>
</figure>

Totally unreadable, but hilarious.

[1]: http://fury.com "Kevin Fox’s website"
[2]: http://peakbagger.com
[3]: http://www.peakbagger.com/pbgeog/histmetropop.aspx "Historical Metropolitan Populations of the United States"
[4]: https://twitter.com/kfury/status/424368704948686848 "Kevin Fox’s tweet about Peakbagger.com’s charts"
[5]: http://xach.com "Zach Beane’s website"
[6]: http://www.xach.com/moviecharts/ "Movie box office charts"
[7]: https://github.com/xach/wormtrails "Wormtrails repository on GitHub"
[8]: https://marktrapp.com/projects/wormtrails-csv/ "Wormtrails CSV project page"

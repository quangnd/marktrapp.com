---

title: "Years down the drain: Facebook’s broken UI"
date: 2014-03-29T22:10:00-07:00
excerpt: Facebook’s workflow for deleting posts makes it easy to delete far more than you’d ever want.

section: Social Media
tags: [Facebook, user interface, user experience]

license: none

---

Today, I irreversably lost three years of posts and comments on Facebook. Three years of memories, discussions, and conversations: lost to the ether. How? I missed the target area for a button by a single pixel.

Periodically, I like to clean up my Facebook timeline and remove boring posts that didn’t get any activity. This requires navigating to my timeline and performing the following steps:

1. Hover over the post to delete to expose the a downward facing chevron.
2. Click on the chevron to get a drop-down menu.
3. Click *Delete* to expose a confirmation modal dialog.
4. Click the **Delete** button in the dialog.
5. Find the next post to delete and go back to step 1.

Pretty simple, right? Almost. Here’s what the confirmation dialog looks like when you delete a post that was imported via a third-party service, like Twitter:

<figure>
    <img src="/assets/images/facebook-delete-confirmation.png" alt="Facebook’s delete confirmation dialog">
    <figcaption>Facebook’s delete confirmation dialog</figcaption>
</figure>

That’s right: on the *confirmation* dialog to delete a *single* post, there is a checkbox next to **Cancel** that initiates a unrelated, far more destructive action that deletes everything. That action has no undo and no separate confirmation: if you check it, Facebook will delete everything posted by Twitter ever.

That’s pretty bad UI to begin with, but it gets worse: the entire gray bar at the bottom of the dialog checks that option. If you misclick either the **Cancel** or **Delete** buttons by a single pixel, you will check the [history eraser option][1]. Here’s a video demonstration:

<iframe width="100%" height="190" src="//www.youtube-nocookie.com/embed/psRBJ4mswNI?rel=0" frameborder="0" allowfullscreen></iframe>

You can probably guess what happened: when performing a routine delete post action, I quickly misclicked the **Delete** button then clicked it again, not realizing until it was pressed that my misclick checked the “delete everything” option.

And sure enough, a few minutes later, all of my posts from Twitter—which constituted the vast majority of my activity through Facebook—were deleted.

I looked around, and found the Facebook support page that tersely explains that [deletions are permanent][2]. But alas! This is a special case! Surely there’s some way to contact Facebook support and plead my case? Nope: even GetHuman [has not been able to find any way][3] to contact Facebook for support issues.

This is broken. There are a number of ways this could’ve been mitigated:

* Don’t include a massively destructive option in a confirmation dialog for deleting a single option.
* If someone checks the massively destructive option, provide a second confirmation dialog confirming that option.
* Alternatively, provide an undo option.
* Confine the target area of the massively destructive option to the checkbox itself, not the entire bottom third of an unrelated confirmation dialog.
* All of the above.

But instead, we’re left with a crappy UI and my Facebook activity is a lot less extant. Disappointing. If you’re on Facebook’s UI team, please fix this.[^1] If you’re working on your own UI, please use Facebook’s current delete workflow as a great example of what *not* to do.

[^1]: And maybe see if my posts could be restored? Had to try.

[1]: https://www.youtube.com/watch?v=NITBfc1EOBo&t=27s "Ren and Stimpy: The Button"
[2]: https://www.facebook.com/help/120994304648896?sr=1&sid=0scNG3ZYTQL1VlJjM "Facebook support: Can I retrieve deleted messages?"
[3]: http://gethuman.com/contact/Facebook/ "GetHuman profile for Facebook"

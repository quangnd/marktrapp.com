---

title: OAuth for Dummies
date: 2009-09-17T10:30:09-07:00
excerpt: OAuth is a tricky beast, but once the general workflow is worked out, it’s more tedious than difficult.
note: This article applies to OAuth 1.0 and 1.0a. Your mileage will vary when using OAuth 1.1 or 2.0.

section: Programming
tags: [OAuth, how-tos]

license: none

---

One of the projects I’ve been working on instead of updating this blog has been a set of modules for [Drupal][1] that allow [FriendFeed][2] users do all sorts of interesting things. While I’m not ready to release the details of those projects, one of the biggest mind-benders I’ve experienced in my work has been [OAuth][3], a technology FriendFeed uses as its preferred authentication mechanism in the latest version of its API.

It took me a while to figure out how exactly OAuth works: either the information on the web is very bare, or I’m just very dense. But I did eventually get a working OAuth client up and running, and if you’ve been struggling to wrap your head around the OAuth concept, hopefully the workflows I provide here can help you.

One can easily get overwhelmed with all the stuff you have to do when using OAuth, so I’m going to present the workflow several times, starting with a very high level overview. Each successive explanation will add more detail such that, if I did my job right, repetition will help reinforce everything.

This guide should be helpful for any OAuth scenario, but for explanation’s sake, I’m going to use the following terminology conventions:

* MyApp, or the client: this is the web site that wants to have access to a user’s private resources.
* John, or the user: this is the user who is using MyApp and wants to allow it to access his private resources.
* FriendFeed, or the server: this is the web site where John is a member and stores his private resources.

## The 100,000-foot View: Basics

OAuth, at its very heart, is just a fancy way to authenticate with a server. When it’s all said and done, you are given essentially a user name and password, and you use that pair to access a user’s private resources. The spin that OAuth adds to basic authentication is based on two parts:

1. OAuth never divulges the user’s actual user name and password to the client.
2. The user can go back to the original application and revoke the client’s access to their content.

If you’ve ever had to create a guest account on your computer or temporarily give a spare set keys to someone so they could water your plants, you know the basic idea. You are allowing someone else to access something private, but you’re in control of when and how they access it.

## The 50,000-foot View: What the User Sees

So far so good. Now, we need to talk about how that access is granted. If you were getting your plants watered, you’d just meet up with someone and physically hand over the keys: a relatively secure transaction. OAuth attempts to replicate and expand upon that level of security by providing a means to explicitly say “I want this client to have access to my stuff” and a means for the client to prove who it purports itself to be. It’d be like if you ran a background check on your friend before you gave them your keys, and kept looking at their ID as you handed them off.

So how does an OAuth client do these things? With a lot of handshaking. A lot. To the point where, if someone shook your hand that much, you’d be thinking about a restraining order. But let’s hold off on what the client does and just outline what the user experiences:

1. The user, John, visits the client, MyApp, where he sees MyApp can do cool things with his private information stored on a server, FriendFeed.
2. MyApp advertises these cool things, and beckons John to “sign in with FriendFeed”: essentially, to allow MyApp access to John’s FriendFeed account.
3. John clicks on the sign-in button, which initiates a negotiation process between MyApp, John, and FriendFeed.
4. MyApp performs, shall we say, “deep magic” to prove to FriendFeed it is who it purports to be.
5. FriendFeed agrees, and MyApp then sends John off to FriendFeed.
6. On FriendFeed, John is asked whether or not he wants to allow MyApp access to his private data.
7. If John says “yes,” FriendFeed sends him back to MyApp.
8. MyApp does some more deep magic, and finally receives a specially made ultimate set of keys, which it can now use to access John’s private data.

Once MyApp has this last set of keys, all hope is not lost for John: at any time, he can go back to FriendFeed and revoke MyApp’s set of keys. For further information, I suggest watching the classic Seinfeld episode, “The Keys:”

<iframe width="420" height="315" src="//www.youtube-nocookie.com/embed/Dz2IrS6AlzA?rel=0" frameborder="0" allowfullscreen></iframe>

## The 10,000 Foot View: the Client’s Deep Magic

If you have seen “The Keys,” you might remember a scene where Elaine and Jerry are confusing themselves about who gets what key. I’ve found OAuth to be just as confusing: there’s a lot of handshaking, a lot of key passing, a lot of agreement, and in the end, everyone’s left confused as to what just happened. This is where the client’s deep magic comes in. Before MyApp can access John’s private resources on FriendFeed, it needs to do 4 things:

1. It needs to register with FriendFeed and receive its first set of keys: a *consumer key* and a *consumer secret*. This is done by the developer going to a special webpage (in FriendFeed’s case, [this page is within their API documentation][4]).
2. Once John clicks on “sign-in to FriendFeed,” MyApp then needs to take the first set of keys it received (the consumer key and consumer secret) and use them to sign a special request to FriendFeed for a new set of keys, called a *request token*.
3. Once MyApp has the request token, it needs to send John back to FriendFeed with the request token. There, John is asked to allow or deny MyApp’s request to access to his data.
4. Once John allows MyApp access to his data, FriendFeed sends John back to MyApp and tells it that the request token is “authorized.” MyApp then needs to take the request token and use it to sign a new request to FriendFeed for a third and final set of keys, called the *access token*.

Once MyApp has the access token, it can then use it to sign requests to private resources on John’s behalf: it now has access to John’s private data to do whatever it needs to do.

## The 1,000-foot View: Implementation

 If you’ve gotten this far and understand what’s happening, you’re in great shape: most of the conceptual work is done. Now, let’s discuss how to actually implement all the different parts. At this point, you’re going to want a library to do the heavy lifting for you. OAuth has its own set of [official libraries][5], and they’re likely a good starting point for many languages.

When you registered your application with the server, you should’ve been given a bunch of information. At a minimum, you’ll need the following to continue (if you don’t have this information, check with the server’s API documentation to fill in the missing pieces):

* A consumer key
* A consumer secret
* A request token URL
* An authorize URL
* An access token URL

The basic methodology in working with OAuth is that you make requests just like you would unauthenticated, but with several parameters attached that’ll act as a way to prove the request is legitimate. These parameters include:

* The *consumer key* and *consumer secret*.
* A *token* and a *token secret*. These are the keys I’ve been talking about. You’ll use a specific set of keys depending on where you are in the handshaking process.
* A *nonce* (short for number used once). This is a random string or number that’s used for exactly one request.
* A *timestamp*
* An *OAuth version number*: it’s currently either 1.0 or 1.0a: consult the server’s API documentation to figure out which one to use (it’s likely 1.0a)
* A *signature method*, explained below
* A *signature*, also explained below

If you’re using a library, it’s likely most of this information is abstracted and you don’t need to worry about anything other than supplying the correct token, token secret, request URL, and signature method. Check the library’s documentation and especially the examples of the client to see how to build the signed request URL.

But let’s talk about the the last two parameters, the signature and signature method, To prevent a variety of attacks, it’s a good idea, and in many cases required, to sign all requests with an encrypted signature. There are currently three signature methods that I know to do this: HMAC-SHA1 (seems to be the standard), RSA-SHA1, and PLAINTEXT (insecure, should not be used unless all the other parts of the handshake are encrypted). The signature method is merely one of those strings: HMAC-SHA1, RSA-SHA1, or PLAINTEXT.

To get the signature, however, is much tougher. This is where the library comes in especially handy. Most libraries will take the request URL, the token and token secret, the method by which you’re requesting the URL (GET or POST), and the signature method and provide the correct signature. Easy as pie.

### Getting the request token

The general starting point for the user is to have a nice little button that, when clicked, performs the OAuth handshaking and signs the user into the server. So, what you’ll need to do is link the sign-in button to a page on your server that’ll retrieve the first element of the handshake process: the request token.

To get the request token, you’ll make a signed GET request to the request token URL and parse the results you get back. For the request token, you’ll sign the request using the consumer key and the consumer secret. Since you don’t have any tokens, you’ll omit the token and token secret parameters.

If you did it right, the request token URL will provide a new token pair: an `oauth_token` and an `oauth_token_secret`. This is the request token: you’ll use this for everything else in the handshake process.

### Getting the user’s consent

Once you have the request token and token secret, you’re going to need to get the user’s explicit consent to allow access to his data. Store the token secret somehow (maybe a secure cookie or somesuch), and redirect the user to the authorize URL with certain parameters:

* The request token (just add `oauth_token=<token>`, where `<token>` is the actual token)
* The callback URL: this may be optional or flat out ignored due to security concerns. If it’s not allowed in the authorization URL, you’ll usually specify its value when you register the application with the server. The callback URL is where the server should send the user once he consents.

If you did it right, the user will be redirected to the server, which will display a page asking the user to allow you access to his data. Once the user clicks the button to allow access, the server will redirect back to you at the callback URL with the request token as a parameter.

### Getting the access token

At this point, the server has acknowledged the request token you have is authenticated, and can be used to get the final set of keys, the access token. Make a signed request just like you did with the request token, but to the access token URL. Since we now have a token and token secret (you remembered to store the token secret you got back when you got the request token, right?) to use, add those parameters back.

If you did everything right, you should receive a new `oauth_token`, a new `oauth_token_secret`, and some additional information from the server that’ll likely identify who the user is on the server. Trash the request tokens (they’re useless now), and store the information you just received: this is your access information, and will be valid until the user revokes your access.

### Accessing Private Resources

Once you have received the access token, it’s pretty straightforward. Make requests to private resources, but sign the requests just like you did with the request token and access token. Instead of omitting the token and token secret or using the request token, use the access token.

## The Ground-Floor View: Details, Details!

I wanted to go through and discuss the conceptual and basic implementation parts to provide a good foundation to do OAuth work. I’ve glossed over some of the finer points, but you should be in a good place to understand the OAuth spec as well as considerations people will discuss. A good place to start getting into the details of OAuth is the [spec itself][6], which explains in far greater detail all the moving parts and options.

Here are 3 things to consider:

1. You’re probably going to want to have your own user structure on your application, so you can tie an access token to an account and keep the user from having to keep re-authenticating your app.
2. The access token and access token secret are functionally equivalent to a user name and password, and should be treated as such. Keep the information secure.
3. You’ll need to do something if you try to access a private resource with a revoked or invalid access token. Maybe check for that and run through the handshake process again?

Hopefully, you’re thinking about all the ways you can use OAuth to do good work, like extend Twitter, FriendFeed, or Facebook. If there are any points that are confusing, or if you’re an OAuth wizard and see I made some glaring mistakes, let me know in the comments.

## Update

[Benjamin Golub][7] points to a really neat tool, Google’s [OAuth Playground][8], for creating and testing out signed requests. Definitely check it out to understand how request signing works and what types of responses you should be expecting when  you request a token.

[1]: http://drupal.org "Drupal community website"
[2]: http://friendfeed.com "FriendFeed website"
[3]: http://oauth.net "OAuth protocol website"
[4]: http://friendfeed.com/api/applications "FriendFeed API application registration"
[5]: https://code.google.com/p/oauth/ "OAuth library repository"
[6]: http://oauth.net/documentation/spec "OAuth specification"
[7]: http://www.benjamingolub.com/ "Benjamin Golub‘s website"
[8]: https://developers.google.com/oauthplayground/ "OAuth Playground"

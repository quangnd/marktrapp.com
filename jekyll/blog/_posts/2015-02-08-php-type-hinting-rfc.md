---

title: "PHP's type hinting RFC is good enough"
date: 2015-02-08T15:30:00-07:00
excerpt: "The type-hinting RFC for PHP is not perfect, but it's a reasonable compromise and should not be dismissed so easily."

section: Programming
tags: [PHP, type hinting]

license: none

---

There's currently an RFC undergoing a vote by the PHP internals team for [userland scalar type-hinting][1], or the ability to specify the types of the parameters your functions and methods have. It looks like it is set to fail, by the slimmest of margins, as a compromise that has only seemed to unite proponents of strong-typing and proponents of weak-typing to its opposition.

If you asked me—generally in the strong-typing camp—a few days ago, I would've said "good riddance." But after rereading the RFC and following the arguments being made on the [internals mailing list][2] and elsewhere, I think this RFC's failure will be a shame as I think this may be the best, most reasonable attempt at proving type-hinting we can hope for given the disparate views on the future of PHP. In other words, this RFC is good enough—not simply an unworkable compromise-by-committee attempt doomed to failure—regardless of what side you fall on.

## Background

In PHP, functions and method calls are split into two large bins: internal functions—provided by the PHP runtime and extensions primarily written in C—and userland functions that are written in PHP. Up to this point, there's actually be a very large disparity between how they handle function parameters. For userland functions, there is [partial type-hinting][3], but only for certain non-scalar types: arrays, objects, and callables. If you wanted to ensure that a parameter receives a specific *scalar* type (i.e., an integer, boolean, string, or float), you had to resort to something like the following:

```php
function foo($bar) {
    if (!is_int($bar)) {
        throw new \InvalidArgumentException('$foo must be an integer.');
    }

    return $bar * 2;
}
```

Alternatively, you could do:

```php
function foo($bar) {
    $baz = (int) $bar;

    return $baz * 2;
}
```

Neither of these are ideal because now the caller has to understand the internal workings of the function instead of coding to the contract (i.e. the function signature) and the program will either break (in the case of the first example) or lead to silent data loss (in the case of the second example) if the caller doesn't pass parameters exactly as the function is implemented. This has disastrous implications when used in methods that implement an interface: one implementation could include the `is_int()` check or the `(int)` cast while another doesn't, leading to a violation of the [Liskov Substitution Principle][4].

On the other hand, internal functions actually have type hinting built in. If you ever looked at the PHP manual, you'll notice this type hints in the description of a function or method. For example, here's [`substr()`][5]:

```php
string substr ( string $string , int $start [, int $length ] )
```

This isn't just for documentation: internally, `substr()` expects a string for the first parameter, an int for the second, and an int for the optional third parameter. But because PHP's a weakly-typed language, internal functions generally don't break if you don't pass exactly what they're looking for. For example, if you passed `'1'` to the second parameter of `substr()`, internally, that value will be cast to an integer and will be treated as the integer `1`.

This is similar to the second userland example above, but the crucial difference is that the caller (i.e. the person writing PHP code) *knows* that the second parameter for `substr()` is an integer. In other words, the caller can send garbage data into the function and must expect that the data will be cast to the type specified in the function signature.

## The RFC

Regardless of how one feels about strong- vs. weak-typing, this disparity should seem weird. It should seem especially weird when userland *can* type-hint, but only for non-scalar types. That's where the scalar type hinting RFC comes in. If the RFC is implemented, by default userland functions can do exactly the same thing that internal functions have been doing all along[^1]:

```php
function foo(int $bar) : int {
    return $bar * 2;
}

var_dump(foo(2));   // int(4)
var_dump(foo(2.5)); // int(4)
var_dump(foo('2')); // int(4)
```

## Where the RFC seems to go wrong for strong-typing proponents

This brings userland functions in line with internal functions and is a huge win...right? If you're a fan of PHP's weak-typing, absolutely. But there's still a disparity. Consider the following function instead:

```php
function baz(array $qux) : string {
    return implode(', ', $qux);
}

var_dump(baz([1, 2, 3])); // string(7) "1, 2, 3"
var_dump(baz("1, 2, 3")); // Catchable fatal error: Argument 1 passed to baz()
                          // must be of the type array, string given
```

PHP *doesn't* implicitly cast non-scalar types. Instead, it throws an `E_RECOVERABLE_ERROR`. If you are like me from a few days ago and/or are a proponent of strong-typing, the proposal introduces consistency with internal functions and methods, but creates a giant inconsistency between various type hints. Some will perform implicit casting while some will throw errors. The implementors of the original, non-scalar type hints were correct in their assumption that they shouldn't be silently casted and instead should throw an error so the caller knows they messed up. Why do the scalar type hints behave differently? Everything should throw an error.

If you're a proponent of weak-typing, the argument that seems to be most prevalent revolves around PHP's history: PHP has *always* been a weakly-typed language, and if you want a strongly-typed language, use Java or Hack. The fact that non-scalar types don't perform implicit casting could be argued to be a momentary lapse of judgment and should be fixed.

This argument is wholly unconvincing, and the authors of the RFC were insightful enough to realize that you can't just tell a substantial portion of PHP's audience to "shove off." Instead, what they did was introduce a compromise: an optional [declare()][6] construct that switches PHP into treating all type hints as strict. Now, you'd get:

```php
declare(strict_types=1);

var_dump(foo(2));   // int(4)
var_dump(foo(2.5)); // Catchable fatal error: Argument 1 passed to baz() must be
                    // of the type int, float given
var_dump(foo('2')); // Catchable fatal error: Argument 1 passed to baz() must be
                    // of the type int, string given
```

Moreover, this directive actually works for calls to internal functions:

```php
declare(strict_types=1);

var_dump(substr('Foo', 1, 2));   // string(2) "oo"
var_dump(substr('Foo', '1', 2)); // Catchable fatal error: Argument 2 passed to
                                 // substr() must be of the type int, string given
```

So now if you're a fan of strict-typing, just add `declare(strict_types=1)` at the top of all your files and you get it. Otherwise, leave it off and PHP works the same way as it always has. Everything's cool now, right?

## Where the RFC seems to go wrong for everybody

No, everything's not cool.

If you believe PHP should remain a weakly-typed language, adding a directive to disrupt that—and now including internal functions!—is a bridge too far. What happens when all the library authors start adding `declare(strict_types=1)` to their code? You won't be able to avoid it! PHP is now Java!

If you believe PHP should become a strongly-typed language, having to include a `declare(strict_types=1)` directive to every single file is so much work to fix what appears to be an inherent design flaw. If the weak-typing proponents want to live in the past, *they're* the ones should have to add garbage at the top of all *their* files.

And regardless of what side you happen to fall on, `declare(strict_types=1)` looks suspiciously like an INI configuration option, which the PHP community has universally declared was a really Bad Idea. Does no one remember the horrors of [magic quotes][7]?

## Why the RFC is good enough

Compromises are supposed to be a give-and-take process: nobody gets everything they want, but everybody gets part of they want in exchange for giving up something else. If this RFC was merely a compromise proposal, I think I'd still be in the camp that says this is unworkable and unfortunately if type-hinting is every going to be in PHP, one side is going to have to realize PHP is not (or will no longer be) the language for them.

But there's something really clever with this proposal. Let's go back to the type-hinted implementation of `foo()`:

```php
function foo(int $bar) : int {
    return $bar * 2;
}
```

As the implementor for the function `foo()`, I only care that `$bar` is an integer. I do not know, nor do I care, how the parameter is generated. The hint indicates to everyone—PHP and the caller—that as long as `$bar` is an integer, I'm happy. In other words, callers could do `foo((int) '2')` or they could do `foo(2)` and it does not matter for my implementation. This is how functions and methods *should* work: as the caller programs to the contract, you as the implementor isn't going to have a problem.

That's one major point of contention resolved: regardless of how PHP handles the calling of the function, the function is always going to get what it needs.

The second major point of contention is in the calling. If you're a proponent of strong-typing, you want to know when you mess up. If you're a proponent of weak-typing, you want PHP to figure it out for you. In principle, `declare(strict_types=1)` has no effect on the function implementation and the caller gets to decide. There's no threat of being forced to use strong-typing if you don't want to, because even if libraries you depend on switch to strong-typing, your calls to that library's API are governed by *your* use of `declare(strict_types=1)`, not theirs.

This is where I think the "PHP is a dynamic language" argument becomes more compelling to strong-typing proponents like myself. Yes, if you want everything to break if you don't pass exactly the right types, you have to add `declare(strict_types=1)` to all your files. But I don't think that's too high a price to pay to be able to allow PHP to function as a weakly-typed language, particularly since the function and method implementations themselves are guaranteed to get what they need. And even strong-typing proponents benefit from opt-in: it means you can convert code over to strict typing gradually instead of having absolutely everything break immediately.[^2]

## The RFC is not perfect

Even discounting the perpetual war between strong and weak typing proponents, there are still a number of issues with the RFC, particularly in [how the mechanics of `declare()` work][8]. These quirks could wind up making the results of this RFC add a ton of crazy edge cases to PHP. But these are not insurmountable, and there's now talk of [avoiding the `declare()` mechanics altogether][9].

Assuming these problems are resolved, this RFC is a net win for PHP and it'd be a real shame if philosophical issues about purity kill it. Perfect is not only the enemy of the good, but also of the good enough.

[^1]: Note the return type declaration is a feature of PHP7 and was [passed separately][10] from the scalar type hinting RFC.
[^2]: I might add that this ability to mix and match strong and weak typing was considered a benefit of HHVM's handling of Hack and PHP.

[1]: https://wiki.php.net/rfc/scalar_type_hints "PHP RFC: Scalar Type Hints"
[2]: http://news.php.net/php.internals "PHP internals mailing list"
[3]: http://php.net/manual/en/language.oop5.typehinting.php "PHP manual page for type hinting"
[4]: http://en.wikipedia.org/wiki/Liskov_substitution_principle "Wikipedia article on the Liskov Substitution Principle"
[5]: http://php.net/manual/en/function.substr.php "PHP manual page for substr()"
[6]: http://php.net/manual/en/control-structures.declare.php "PHP manual page for declare()"
[7]: http://php.net/manual/en/security.magicquotes.php "PHP manual page for magic quotes"
[8]: http://news.php.net/php.internals/82106 "php-internals: Rasmus's analysis of the Scalar Type Hints RFC"
[9]: http://news.php.net/php.internals/82162 "php-internals: Syntactical change to Scalar Type Hints RFC"
[10]: https://wiki.php.net/rfc/return_types "PHP RFC: Return Type Declarations"

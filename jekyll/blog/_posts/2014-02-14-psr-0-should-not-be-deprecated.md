---

title: PSR-0 should not be deprecated
excerpt: While PSR-4 supersedes PSR-0’s autoloading specification, PSR-0’s folder hierarchy requirements still have value and should not be thrown away.

section: Programming
tags: [PHP, PHP-FIG, PSR-0, deprecation]

license: none

---

In “[PHP-FIG: Autoloaders, Amendments and The "15th Standard"][1]”, Phil Sturgeon discusses the differences between the two [PHP-FIG][2] autoloading standards and suggests that [PSR-0][3] should be deprecated in favor of [PSR-4][4].

His reasoning for this is compelling: anything you could do with PSR-0 you can do with PSR-4 with the exception of using PEAR-style namespaces.[^1] If I prefer the verbose directory structure required by PSR-0, I can still use it in PSR-4 by mapping the namespace prefix to a folder within my class folder hierarchy. In other words, this:

```json
"psr-0": {
    "Itafroma": "src"
}
```

becomes this:

```json
"psr-4": {
    "Itafroma\\Project": "src/Itafroma/Project"
}
```

This is totally correct: it is trivial to convert all PSR-0 projects that do not use PEAR-style namespaces to PSR-4 while still supporting the terse folder hierarchy that is the impetus behind PSR-4 in the first place.

However, PSR-0 is more than this implementation detail: in addition to its autoloader specification, PSR-0 implicitly defines a contract to how object-oriented code should be organized. By declaring my library as PSR-0 compliant, as a consumer of that library you know—without having to look at the autoloader configuration—where my files are. If you want to use `Itafroma\Project\MyClass`, you know that the class source code will necessarily be in `path/to/my/library/Itafroma/Project/MyClass.php`.

With PSR-4, on the other hand, you cannot know where the file is without checking the autoloader configuration. Did I decide to use a PSR-0 style verbose folder hierarchy? Or did I decide to just stick all my classes in `src`? Or maybe I decided that I wanted my folder hierarchy to completely different from the namespace: you can find the class in `fun/Potatoes/CoolStuff/MyClass.php`. Perhaps I’m just going to assume you’re going to use Composer to consume my libary and map `Itafroma\Project` directly to my library’s root.

I can do any of those things and still be PSR-4 compliant. This is not a bug or a defect of PSR-4: it’s a feature.  Large projects like Drupal [insisted][5] that its contributors wouldn’t stand for verbose folder hierarchies and wanted the flexibility to determine their own structure. And for ostensibly non-interoperable code like CMS modules, that may very well be the case. Because of that, I don’t begrudge PSR-4’s existence and it’s almost certainly here to stay.

However, in cases like Drupal[^3] there are additional, project-specific standards that require or strongly encourage a specific folder hierarchy. For example, in Drupal 8 every module namespace (i.e. `Drupal\my_module`) is mapped to the module’s `lib/` folder.

For everyone else? The folder hierarchy standard *is* PSR-0: there are no others with adoption as widespread as PSR-0. By deprecating it, we’re effectively left with no hierarchy standard. To know what I decided to use, you have check to see if I specified an autoloader hint (like the `autoload` key in `composer.json`) or, worse, manually look for the the class and infer the namespace-folder mapping from there.

And that sucks. So please, don’t throw out the baby with the bathwater and just leave PSR-0 alone.

## Update

I had a [conversation with Phil on Twitter][6] and there are a couple of things to clarify.

First, pushing back on PSR-0 deprecation isn’t about forcing people to use the same folder structure, but about preserving the viability of the implicit foldier hierarchy guidelines in PSR-0. My concern was that by deprecating PSR-0, it would signal that the hierarchy guidelines were to be avoided even though PSR-4 only provided a replacement for PSR-0’s autoloader specification and was silent on organization.

Second, Phil [assured][7] that by deprecation, it would simply mean that PSR-4 would be recommended over PSR-0, and it’s not disavowal of PSR-0: everything still using PSR-0 should continue to be able to do so “forever”.

In effect, it would be to deprecate PSR-0’s autoloader in favor of PSR-4, but say nothing about the folder hierarchy guidelines. If you want to structure your library to be PSR-0 compliant (in addition to being PSR-4 compliant), the PHP-FIG would not be saying that you’re doing it wrong. That’s something I can agree with.

## Update 2

Despite Phil Sturgeon's assurances that PSR-0 would not be disavowed, the PHP-FIG has effectively done so anyway. The note at the top of PSR-0 makes no indication that the deprecation might only apply to the autoloader and not the folder hierarchy recommendation:

> **Deprecated** - As of 2014-10-21 PSR-0 has been marked as deprecated. PSR-4 is now recommended as an alternative.

And on the new PHP-FIG new site, launched late in 2015, PSR-0 is [segregated from other PSRs][8]. According to the [discussion on the PHP-FIG mailing list][9], the purpose of this segregation was to indicate PHP-FIG's position that the PSR is "obsolete" or "unaccepted", both of which would seem to support that PHP-FIG, as part of its deprecation of PSR-0, has disavowed it. I continue to hold the position that this is a mistake.

[^1]: In essence, incorporating the namespace in to the class name to deal with the lack of namespace support in PHP 5.2.
[^2]: Or, if you roll your own autoloader, manually map my library’s namespace to whatever the folder structure is.
[^3]: Or WordPress, Joomla!, or any other system that has a large, disparate contributor base.

[1]: http://philsturgeon.co.uk/blog/2014/02/phpfig-autoloaders-amendments-and-the-15th-standard "PHP-FIG: Autoloaders, Amendments and The “15th Standard”"
[2]: http://www.php-fig.org/ "PHP-FIG website"
[3]: http://www.php-fig.org/psr/psr-0/ "PSR-0: Autoloading Standard"
[4]: http://www.php-fig.org/psr/psr-4/ "PSR-4: Autoloading Standard"
[5]: https://drupal.org/node/1971198 "[policy] Drupal and PSR-0/PSR-4 Class Loading"
[6]: https://twitter.com/philsturgeon/status/434112525006028800 "it was measured and well written. Good stuff. I still feel like “if you’ve made it confusing, you’ve done it wrong.” is true. :)"
[7]: https://twitter.com/philsturgeon/status/434117621055643648 "it's not so much disavow, just: you should use PSR-4 but PSR-0 is around if you want it. Composer won’t delete it, etc."
[8]: http://www.php-fig.org/psr/ "PHP Standards Recommendations"
[9]: https://groups.google.com/forum/#!topic/php-fig/LJP7dcgh7uQ "List deprecated PSRs separately on http://www.php-fig.org/psr/?"

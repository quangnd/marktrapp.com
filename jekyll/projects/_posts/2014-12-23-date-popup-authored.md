---

title: Date Popup Authored
date: 2014-12-23T21:00:00-08:00
excerpt: A Drupal module to provide a datepicker control for the Authored On field found on node submission forms.

permalink: /projects/date-popup-authored

section: Personal Projects
tags: [Jekyll, Ruby, GPLv2 license]

license: GPLv2 or later

repository: https://drupal.org/project/date_popup_authored

---

Date Popup Authored provides a [jQuery UI][1]-based datepicker for the "Authored on" date field found on node submission forms. This allows content editors to pick a human-understandable date and not have to type the exact date format of the default *Authored on* field.

## Installation and configuration

Install as you would any other Drupal module. See the [Drupal handbook page on installing contributed modules][2] for further information.

You can change the behavior of the date-picker by going to the settings page for each content type.

## Caveats

Since Date Popup Authored allows you to choose a date format that's less specific than the default date format Drupal uses for the Authored on field, it will insert default data if you use a more simplified date format.

For example, if the date format you've configured doesn't include a time, when the node is saved, the Authored on time will be set to 12:00AM. Similarly, if you don't include the ability to choose a month, the Authored on month will be set to January (i.e. month 1).

So, if you care about the time a post is authored, make sure you allow the user to set it in the date format. See installation for more information.

## Future development

### Drupal 6

The Drupal 6 version of Date Popup Authored is unmaintained except for any potential security fixes. Once Drupal 8 is released, the Drupal 6 version will become completely unsupported.

### Drupal 7

There are currently no to-do items for the Drupal 7 version, but if you run into any issues, feel free to file a bug report or support request in the [Drupal.org issue queue][3].

### Drupal 8

The functionality this module provides is being considered for core inclusion:

- [#1835016: Polyfill date input type][4]
- [#471942-30: Use Date Popup on 'Authored on' field][5]
- [#504524: Extend Authored on field with jQuery UI Date Picker][6]

Because of this, hopefully a Drupal 8 version will not be needed.

## Acknowledgments

Date Popup Authored was inspired by the hacks provided by [brice][7] and [Rob Loach][8] in the Date module issue, "[Use Date Popup on 'Authored on' field][9]." It contains additional fixes to account for problems found in their solution, new configuration options, Drupal 7 support, and a full test suite.

## Copyright and license

This module is copyright © 2011—2015 Mark Trapp. All rights reserved. As required by [Drupal.org's licensing guidelines][10], it is made available via the [GPLv2 license][11] or later.

[1]: https://jqueryui.com "jQuery UI website"
[2]: https://drupal.org/node/895232 "Installing modules (Drupal 7)"
[3]: https://www.drupal.org/project/issues/date_popup_authored "Date Popup Authored issue queue"
[4]: https://www.drupal.org/node/1835016 "#1835016: Polyfill date input type"
[5]: https://www.drupal.org/comment/6788664#comment-6788664 "#471942-30: Use Date Popup on 'Authored on' field"
[6]: https://www.drupal.org/node/504524 "#504524: Extend Authored on field with jQuery UI Date Picker"
[7]: https://drupal.org/user/446296 "brice's Drupal.org profile"
[8]: https://drupal.org/u/robloach "Rob Loach's Drupal.org profile"
[9]: https://drupal.org/node/471942 "Use Date Popup on 'Authored on' field"
[10]: https://www.drupal.org/licensing/faq "Drupal.org Licensing FAQ"
[11]: http://www.gnu.org/licenses/old-licenses/gpl-2.0.html "GNU General Public License, version 2"

---

title: "Porting Zork — Part 2: Data structures"
date: 2015-01-27T04:00:00-07:00
excerpt: "The second part in a series on porting Zork to modern languages: implementing the more basic data structures."

section: Programming
tags: [Zork, MDL, Infocom, porting]

license: none

---

Continuing on from the introduction to porting *Zork* in [part 1 of this series][1], I've decided to tackle one of the smaller files, [`prim.mud`][2], first. `prim.mud` contains four subroutines (referred to as `SUBR`s in MDL): `<MSETG>`, `<PSETG>`, `<FLAGWORD>`, `<NEWSTRUC>`, and `<MAKE-SLOT>`. These subroutines manipulate the global state at a basic level:

- [`<MSETG>`][3] is a wrapper around MDL's `<SETG>`, which sets the value of a global variable (or `ATOM` in MDL parlance)
- [`<PSETG>`][4] sets the value of a global variable and adds that variable to a global "PURE-LIST"
- [`<FLAGWORD>`][5] creates a named [bit field][6]
- [`<NEWSTRUC>`][7] is essentially a userland version of a [C struct][8]
- [`<MAKE-SLOT>`][9] adds properties to items and rooms within a Zork game

`prim.mud` also contains one pre-defined global variable, `SLOTS`, which simply contains a list of properties created by `<MAKE-SLOT>`.

## \<MSETG\>

Porting `<MSETG>` was straightforward, but I immediately ran into a few things that didn't translate one-to-one into PHP.

`<MSETG>` prevents a variable from being redeclared or modified: in essence, it's a constant creator. It does this by creating the variable in the global scope, then "locking" it with a `<MANIFEST>` call. The `<MANIFEST>` call doesn't necessarily prevent the variable from being redeclared: instead it hints to the compiler that assurances have been taken to prevent that. In this case, `<MSETG>` explicitly throws an error if the variable is redeclared.

On its face, `<MSETG>` seems pretty close to PHP's [`define()`][10], but this comparison has some problems:

- `define()` does not actually prevent constants from being redeclared. When you redeclare a constant, PHP only throws an `E_NOTICE`.
- `<MSETG>` adds the variable to the global scope and is accessed just like other global variables. In PHP, constants are not the same as global variables and are accessed using different methods (via an unsigiled name and via the `$GLOBALS` superglobal, respectively).

Instead of replacing calls to `<MSETG>` with calls to `define()`, I implemented it straight in userland code, with one design change: rather than use [`trigger_error()`][11] for the error call, I threw an exception. Errors in MDL are added to a stack and can be, in a sense, "caught". You can do this with `E_RECOVERABLE_ERROR`s in PHP, but it's a bit of a kludge. `<ERROR>` calls in MDL are also named, something regular PHP errors don't have but exceptions do.

## \<PSETG\>

`<PSETG>` was also a straightforward port. Like `<MSETG>`, I threw an exception instead of calling `trigger_error()`. The big issue right now is that what `PURE-LIST` and `PURE-CAREFUL` are is unclear: they're only referenced in `<PSETG>` and *The MDL Programming Language* makes no reference of them. I suspect they are compiler or debug related and may wind up being removed entirely later on.

## \<FLAGWORD\>

`<FLAGWORD>` was a bit more interesting. Without code comments and very little knowledge of MDL, piecing together what the subroutine took some time. About 75% of the way in, I realized what it was doing: creating a simple bit field. In PHP, this is a quick operation:

```php
$flags = ['foo', 'bar', 'baz'];
$bit = 1;
$bitfield = [];
foreach ($flags as $flag) {
    $bitfield[$flag] = $bit;
    $bit <<= 1;
}
```

In MDL, there is no `foreach`-like construct. Instead, the flags are walked through using `<MAPF>` which is essentially equivalent to PHP's [`array_walk_recursive()`][12]. This makes sense, given MDL's Lisp-like underpinnings: recursively iterating would handle a nested list like `<FOO <BAR BAZ> QUX>` just fine, but PHP's `foreach` would choke, treating `['BAR', 'BAZ']` as a single element and failing because you can't use an array as a key. I've used `array_walk_recursive()` in my port, but it doesn't look like any calls to `<FLAGWORD>` rely on  nested list support and I'll probably wind up replacing it with a much-faster `foreach`.

Like `<PSETG>`, `<FLAGWORD>` has a check to a symbol not referenced anywhere else and may just be a compiler-related thing.

## \<NEWSTRUC\>

`<NEWSTRUC>` was a similar experience to `<FLAGWORD>`. It's 41 lines of code to essentially create a `struct`:

```c
struct foo {
    int prop1;
    int prop2;
    char *prop3;
}
```

The way structs are emulated is pretty interesting: the end result is a list where each odd element in the list corresponds to each variable within the struct and each even element is the variable's type. Here's the room "struct", for example:

```mdl
<NEWSTRUC ROOM
    VECTOR
    RID
    PSTRING                        ;"room id"
    RDESC1
    STRING                         ;"long description"
    RDESC2
    STRING                         ;"short description"
    REXITS
    EXIT                           ;"list of exits"
    ROBJS
    <LIST [REST OBJECT]>           ;"objects in room"
    RACTION
    RAPPLIC                        ;"room-action"
    RBITS
    FIX                            ;"random flags"
    RPROPS
    <LIST [REST ATOM ANY]>>
```

PHP's a dynamic language, so most of `<NEWSTRUC>`'s type checking is unnecessary. Once that's stripped out, the resulting data structure is pretty silly so I opted to use PHP's native way of emulating structs: classes with public properties. The above `ROOM` struct can be implemented in PHP as:

```php
class Room {
    public $rid, $rdesc1, $rdesc2, $rexits, $robjs, $raction, $rbits, $rprops;
}
```

It would've been nice to create classes dynamically so the `newstruc()` function signature could still be used, but PHP's dynamic class generation is limited to using `eval()` and strings. Instead, I opted to [disable `newstruc()`][13] and will port all calls to `<NEWSTRUC>` to straight classes.

## \<MAKE-SLOT\>

The final subroutine in `prim.mud`, `<MAKE-SLOT>` is the only one in the file to have a code comment:

> MAKE-SLOT -- define a funny slot in an object

I have no idea what this means. After porting, I've determined that that `<MAKE-SLOT>` does is add a named property (or "slot") to room and item objects at runtime. Once a "slot" is created, every existing and future instance of a room or item will have it.

`<MAKE-SLOT>` is the first subroutine I've run into that cross-references another file's code, so as part of its implementation of I ported `<OPUT>` and `<OGET>` from `defs.mud`. I'll talk more about them later in the series, but they're essentially wrappers around PHP's associated array assignment that ensure the correct object property is referenced (`Room::$rprops` for rooms and `Object::$oprops` for items).

[1]: http://marktrapp.com/blog/2015/01/27/porting-zork-part-1/ "Porting Zork — Part 1: Introduction"
[2]: https://github.com/itafroma/zork-mdl/blob/master/prim.mud "prim.mud source code"
[3]: https://github.com/itafroma/zork-mdl/blob/ffd99fada4c4e8f46b7ae6fe15722b920560d011/prim.mud#L2-L8 "<MSETG> implementation"
[4]: https://github.com/itafroma/zork-mdl/blob/ffd99fada4c4e8f46b7ae6fe15722b920560d011/prim.mud#L10-L19 "<PSETG> implementation"
[5]: https://github.com/itafroma/zork-mdl/blob/ffd99fada4c4e8f46b7ae6fe15722b920560d011/prim.mud#L21-L33 "<FLAGWORD> implementation"
[6]: http://en.wikipedia.org/wiki/Bit_field "Wikipedia article on bit fields"
[7]: https://github.com/itafroma/zork-mdl/blob/ffd99fada4c4e8f46b7ae6fe15722b920560d011/prim.mud#L35-L75 "<NEWSTRUC> implementation"
[8]: http://en.wikipedia.org/wiki/Struct_(C_programming_language) "Wikipedia article on C structs"
[9]: https://github.com/itafroma/zork-mdl/blob/ffd99fada4c4e8f46b7ae6fe15722b920560d011/prim.mud#L81-L102 "<MAKE-SLOT> implementation"
[10]: http://php.net/manual/en/function.define.php "PHP manual on define()"
[11]: http://php.net/manual/en/function.trigger-error.php "PHP manual on trigger_error()"
[12]: http://php.net/manual/en/function.array-walk-recursive.php "PHP manual on array_wlk_recursive()"
[13]: https://github.com/itafroma/zork-php/blob/d1a0bb34cc99ac30e95f0c024160151e920b8814/src/php/prim.php#L108-L124 "newstruc() implementation"

---

title: Setting up a Common Lisp environment on OS X with Sublime Text 3
date: 2014-01-19T21:05:00-08:00
excerpt: Some basic instructions for setting up a basic, but functional Common Lisp environment without resorting to Emacs.
note: This is a basic guide for setting up what was a functional environment for me after a few hours of messing around with it. If there are better ways to do this stuff, definitely [let me know](/contact).

section: Programming
tags: [Lisp, Common Lisp, Sublime Text]

license: none

---
This weekend, I wanted to mess around with a couple of Lisp libraries, but I didn’t really have a good starting point. My preliminary research seemed to indicate I was going to have to tough it out and use Emacs, but after a few hours I was able to piece together a working environment using the tools I was already comfortable with: [Sublime Text][1] 3 on OS X.

## Setting up OS X for development

The first step is to set up OS X for development if you haven’t already. This involves two parts: installing the OS X Command Line Tools (CLT) and installing [Homebrew][2]. The former is required for any type of development, as OS X no longer includes devtools by default. The latter is a package manager for OS X.

1. Open a Terminal and run `xcode-select --install`. A dialog will appear that’ll allow you to install the CLT.
2. Once the CLT is intalled, head over to the Homebrew website and follow the installation instructions there.

Once done, you’ll be able to run `brew` from a Terminal to access Homebrew.

## The Common Lisp (CL) environment

There are once again two things you need to get a reasonable CL environment: you’ll need a way to compile and execute CL files and a way to manage any dependencies you may require. The former is going to be handled by the [SBCL compiler][3] and the latter will be handled by [Quicklisp][4].

1. Install SBCL using Homebrew: `brew install sbcl`
2. Install [rlwrap][5]: `brew install rlwrap`[^1]
3. Download Quicklisp from its website. Either follow the installation instructions there and skip to the next section, or continue on.
4. Launch SBCL with the `quicklisp.lisp` file you just downloaded: `rlwrap sbcl --load quicklisp.lisp`
5. At the prompt, type `(quicklisp-quickstart:install)` and press <kbd>Return</kbd>. Quicklisp will run through its installation routine.
6. Once complete, type `(ql:add-to-init-file)` and press <kbd>Return</kbd>. This will ensure Quicklisp loads every time you launch SBCL.

Now that SBCL and Quicklisp is installed, you can either use SBCL’s [REPL][6] directly or write your own Lisp files and execute them by running `sbcl --load <file>`. If you want to use any of the [libraries that are Quicklisp-enabled][7], you can do so with `(ql:quickload "libraryname")`. If you want to use a library not provided through the Quicklisp package manager, you can either symlink or drop them into `~/quicklisp/local-releases`.

## Sublime Text 3 (ST3) configuration

How you set up ST3 is largely going to be personal preference, but when I started toying with CL, I really wanted a quick way to access SBCL’s REPL and a way to throw Lisp files at the compiler using a build system:

1. If you don’t have it already, install [Package Control][8].
2. Open the ST3 command palette by selecting it from the Tools menu or by pressing <kbd>⌘ Command</kbd> + <kbd>⇧ Shift</kbd> + <kbd>P</kbd>.
3. Select `Package Control:Add Repository`. You can find it by simply typing `add r` and letting ST3 autocomplete.
4. Copy and paste the URL to the [SublimeREPL package repository][9] into the prompt.[^2]
5. Open the ST3 command palette again.
6. Select `Package Control:Install Package`. You can find it by typing `install` to trigger ST3’s autocompletion.
7. Type or select *SublimeREPL* from the list of packages.

Once installed, you can access to SBCL’s REPL by going to the *Tools* menu, then selecting *SBCL* from the *SublimeREPL → Common Lisp* submenu.

### REPL key binding

Accessing the REPL by navigating into a sub-submenu is kind of a drag, so I set up a key binding. You can access your ST3 key bindings by going to the *Sublime Text* menu and selecting *Key Bindings — User* from the *Preferences* submenu. There, you can add a new key binding:

```json
[
    {
        "keys": ["super+ctrl+h"],
        "command": "repl_open",
        "args": {
            "type": "subprocess",
            "encoding": "utf8",
            "cmd": ["sbcl", "-i"],
            "cwd": "$file_path",
            "external_id": "lisp",
            "syntax": "Packages/Lisp/Lisp.tmLanguage"
        }
    }
]
```

The above will open the SBCL REPL by pressing <kbd>⌘ Command</kbd> + <kbd>⌃ Control</kbd> + <kbd>H</kbd>.[^3]

### Build System

The last part of ST3 I configured was a build system. You can create one by going to the *Tools* menu and selecting *New Build System…* from the *Build System* submenu. There, copy and paste the following into the file created:

```json
{
    "shell_cmd": "/usr/local/bin/sbcl --disable-debugger --load $file",
    "working_dir": "$file_path"
}
```

Save the file as `SBCL.sublime-build`. Now, you can select *SBCL* from the *Build System* submenu and quickly compile and execute your currently active CL file by pressing <kbd>⌘ Command</kbd> + <kbd>B</kbd>.[^4]

## Next steps

Once you have a working environment, you’re free to play around with CL. I’d suggest looking more into [Quicklisp][4] and especially Zach Beane’s blog post, “[Making a small Lisp project with quickproject and Quicklisp][10]”.

[^1]: This step is optional, but SBCL has pretty awful support for the OS X Terminal. Using `rlwrap` with SBCL will allow such luxuries as being able to use the arrow keys and the delete key while running SBCL in REPL mode.
[^2]: Steps 3 and 4 are necessary because the current version of SublimeREPL published to the default channel does not include support for SBCL.
[^3]: More information on configuring ST3 key bindings can be found in its [unoffical documentation][11].
[^4]: More information on configuring ST3 build systems can also be found in its [unofficial documentation][12].

*[CL]: Common Lisp
*[CLT]: Command Line Tools
*[ST3]: Sublime Text 3

[1]: http://www.sublimetext.com "Sublime Text website"
[2]: http://brew.sh "Homebrew website"
[3]: http://www.sbcl.org "Steel Bank Common Lisp website"
[4]: http://www.quicklisp.org "Quicklisp website"
[5]: http://linux.die.net/man/1/rlwrap "rlwrap(1) man page"
[6]: https://en.wikipedia.org/wiki/Read–eval–print_loop "Wikipedia article on REPLs"
[7]: http://www.quicklisp.org/beta/releases.html "Quicklisp beta releases"
[8]: https://sublime.wbond.net/installation "Installation - Package Control"
[9]: https://github.com/wuub/SublimeREPL "SublimeREPL repository"
[10]: http://xach.livejournal.com/278047.html "Making a small Lisp project with quickproject and Quicklisp"
[11]: http://docs.sublimetext.info/en/latest/customization/key_bindings.html "Key Bindings"
[12]: http://docs.sublimetext.info/en/latest/reference/build_systems.html "Build Systems (Batch Processing)"

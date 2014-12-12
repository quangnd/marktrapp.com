---

title: EnderRain
date: 2012-04-22T03:09:47-07:00
excerpt: A Minecraft mod that disables Enderman teleporting when it’s raining.
note: Minecraft 1.4 and later includes the ability to use [game rules](http://minecraft.gamepedia.com/Command_Block#Game_Rules) which makes this mod largely obsolete for my purposes, even if updated. While it won't prevent endermen from teleporting into your base, `/gamerule mobGriefing true` will prevent endermen from wrecking it once there.

permalink: /projects/enderrain

section: Personal Projects
tags: [Endermen, Minecraft]

license: none

downloads:
    - title: EnderRain Standard 1.2.5
      file: EnderRain-Standard-1.2.5.zip
    - title: EnderRain Invulnerable 1.2.5
      file: EnderRain-Invulnerable-1.2.5.zip

---

One of the most annoying "features" of [Minecraft][1] are Endermen's reaction to weather effects: if they get caught out in the rain, they take damage (great!) and randomly teleport within a 32 block radius of their location (boo!). This causes situations where Endermen will randomly appear in your normally ultra-secure lair and steal your stuff.

This mod disables this behavior, and comes in two flavors:

* **EnderRain Standard:** Endermen no longer teleport randomly when in the rain, but still take damage. Adds a nice random "I win" element to a bad encounter with Endermen.
* **EnderRain Invulnerable:** Endermen no longer teleport randomly when in the rain and no longer take damage in the rain. For those who want to keep Endermen balanced roughly the way they are.

In either case, Endermen's behavior when hitting a body of water remains the same (they take damage and randomly teleport).

To use this mod, download the appropriate class file and patch your `minecraft.jar` file like you would any other mod. You can find instructions readily available all over the web, but if you're on a Mac, you'd do something like:

1. Download the version of EnderRain you want and unzip the downloaded file: you should have a file called `jg.class`.
2. Open Finder and in the **Go** menu, select **Go to Folder…**.
3. In the dialog that appears, type `~/Library/Application Support/minecraft/bin` and press the **Go** button.
4. Rename the `minecraft.jar` file to `minecraft.zip`. Finder will ask you if you are sure you want to change the extension. Press the **Use .zip** button.
5. Open (e.g., double-click) the `minecraft.zip` file to extract its contents into a folder called `minecraft`.
6. Drag the `jg.class` file from step 1 into the `minecraft` folder and let Finder overwrite the existing file.
7. Rename the `minecraft` folder to `minecraft.jar`. Finder will ask you if you are sure you want to add the extension: press the **Add** button.
8. Launch Minecraft!

## Implementation notes

* Developed for single-player Minecraft 1.2.5. Will not work in any other version.
* Modifies the EntityEnderman class (`jg.class` file): not compatible with any other mod that modifies that class. Unless you're using a mod that also directly modifies Endermen behavior, you should be fine (but no promises!).

## Development notes

This was a simple hack: assuming you deobfuscated the Minecraft source with [MCP][2] 6.2, the relevant sections are the conditions on lines 138 and 197 in `EntityEnderman.java`. On line 138, `EntityEnderman::onLivingUpdate()` checks to see if the Enderman is wet: if it is, the Enderman takes drowning damage. And on line 197, there's an identical conditional: if true, the Enderman deselects its target and teleports randomly. Changing one or both conditionals from `isWet()` to `isInWater()` will have the Enderman entity only check to see if it's in water and ignore whether it's in rain.

## Legal mumbo-jumbo

Not affiliated with or endorsed by [Mojang][3], the creators of Minecraft. Since this is a modification of their protected work, I cannot and do not claim any copyright to it. I do, however, affirm it qualifies as [Fair Use][4] under [17 U.S.C. § 107][5].

[1]: http://minecraft.net "Minecraft"
[2]: http://mcp.ocean-labs.de "Mod Coder Pack"
[3]: http://mojang.com "Mojang"
[4]: http://en.wikipedia.org/wiki/Fair_use "Wikipedia article on Fair Use"
[5]: http://www.law.cornell.edu/uscode/text/17/107 "Limitations on exclusive rights: Fair Use"

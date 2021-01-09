# v1.4-RC1 A Banging Update

What's New?

- New: Menu bar for the Playlist Editor.
- New: Improved Headbanging for the Ryuko and Satsuki Visualizer (instead of responding to any audio activity, it responds to lower frequencies).
- New: A few new Color themes for the Skin and the classic Visualizers.
- New: Progress bar in the Playlist Editor that also acts as a VU Meter.
- New: Some windows (but not all) have a sunken border, so they look more like Win32 programs.
- New: "Debloated" version of this Skin, now referred to as the Lite edition.
- New: Adjusted the Ragyo Visualizer's Spectrum Analyzer.
- Fixed: Gradient generation for the Spectrum Analyzer was broken in the newest WACUP Beta and Preview builds (Winamp users won't be affected).
- Fixed: Possible crash that could occur if a playlistplus object used the same ID as a generic text object (caused a weird conflict in the script, which caused the player to crash), fixed by replacing all playlistplus objects with regular text objects.
- Fixed: Tooltips now actually appear under the cursor.

- New (but not mentioned in the previous release):
- Minor UI adjustments (looks a bit more aesthetically pleasing).
- Newer Playlist Editor, made to resemble the Windows Explorer.

# v1.3.2-Lite: It's so great we skipped one version revision!

What's New?

Not a whole bunch, this is pretty much a stripped down version of the skin, which now includes a few features from master and removes a few things as well, see if you can spot 'em.

- No extra visualizers
- Beta Playlist Editor
- A few new Winamp Visualizer color themes
- The Winamp Visualizer in its own window (carrying the same set of color visualizers the Main Window has)

# v1.3: Colorful Update Part 2
What's New?

- New: Some minor UI adjustments
- New: Flipped the way the two Zero Two's were looking, now they stare at each other
- New: Slightly improved Ragyo's shadowy Spectrum Analyzers (less dark, more bright)
- New: FPS menu options and lots of separate color schemes for the Visualizer
- New: "More Windows" color theme (thanks to @mirzi1 for the contribution!)
- New: Optimized the top secret Headbanging algorithm for a slightly more realistic headbanging experience
- New: Optimized the VU meter in the VU Meter window, the HL2 Hud window and the glowing light in Ragyo's hair to be faster/slower
- New: "Crimson" color theme kindly contributed by my friend Apache
- New: Clicking in the Satsuki and Ryuko Visualizer now changes the visualizer mode of the 4 vis objects
- Fixed: Improved Wasabi tooltips for 99% windows emulation accuracy
- Fixed: Improved the Modern Skinned (and Classic Skinned) scrollbars to look more windows-like (moreso the Modern Skinned ones)
- Fixed: The clutterbar going blank when disabling alpha in the Modern Skin options (thanks to Victhor for the hint!)

# v1.2: Colorful Update
What's New?

- New: Gammagroups that actually represent what Windows once had to offer with Windows Classic (with more or less accuracy, should still cover everything).
- New: Split up the image parts to allow for better color editing (including one UI detail where one line is always at ```64,64,64```).
- New: Themes! Including those that were present in Windows 9x/2000/XP, including Classic theme coloring of the Aero theme in Windows 7 and from popular Winamp Skins as well! (Not a whole bunch though)
- New: Title Bar Beam gradient can be colored independently and a lot more as well
- New: Recreation of the Sound Recorder from Win9x/WinXP
- New: The infamous Thinger from Winamp 3, just slightly tweaked for a more Windows-like experience (even the included icons are swapped out during skin load, which no one seems to have done before...) Thanks to @midi-in for the suggestion!
- New: Slightly reworked the winshade modes of the Main Window, Equalizer and the Playlist Editor. The grabber in all three of them was moved to the very right of the window, which allows for the Main Window's seeker to have more room to expand on, and overall for a more cleaner look for the windows in general.
- New: Ported the visualizers from the other two now defunct flavors of Nullsoft Winamp 2000 SP4, they now carry the icons representative from where they came from.
- New: Added Source Filmmaker render of Satsuki Kiryuuin banging her head to the music, as opposed to having 2 Ryuuko's mirroring each other (which looked weird anyway).
- New: The GoldSrc/Source microphone test VU Meter now found its way into the skin as well, but in stereo instead!
- Fixed: Changed the "Half-Life 2 HUD"'s window icon to be from HL2 instead of showing the WACUP icon.
- Fixed: There's like a shit ton of under the hood fixes that even I forgot what they are and what they do, it makes making color themes easier, but the regular user won't notice. :)
- Misc: Tweaked the balance bar slightly
- Misc: Slightly adjusted the other visualizers for more snappier responsiveness. (Doesn't work on all machines and will definitely eat away one core's performance, though it's not terrible on overall performance)
- Misc: Probably broke Winamp 5.666 compatibility somewhere.

# v1.1
What's New?

The first major release of Winamp 2000 SP4 to drop the subversion numbering system to stay in sync with the features Winamp Classic Modern would offer with each 1.xx release, however, as per request of the creator of WCM (and the developer of WACUP himself) to drop that system, I've decided to jump straight to version 1.1 for this release. This is also the first release of WA2kSP4 to include its sister branches, namely the REVOCS Media Player branch (a nod to the anime series Kill La Kill, which originally started out as a testbed for new things to try out, ultimately it turned into its own thing of itself) and the A.P.E Media Player branch (a nod to the anime series Darling in the FranXX), under the hood they're the same thing but on the surface somewhat different.

This release of Winamp 2000 SP4 however may be the last for this year (unless something urgent needs fixing), as there isn't a lot that could be added or fixed, what may take priority however is the ability for this skin to support color themes as in its current state, most of the things existing were taken over from WCM and have not been touched in a long time now.

- New: Inclusion of 2 new flavors of this Modern Skin.
- New: Massive UI overhaul within the Main Player window.
- New: Made the songticker background be its seperate thing.
- New: Made the posbar backgronud be its seperate thing.
- New: Winamp Modern Beat Visualizer reimplemented thanks to @jberg.
- New: Added a Half-Life 2 like Heads Up Display featuring a crosshair visualizer and a subtitle box displaying the currently playing song.
- New (REVOCS Media Player): Added 2 new visualizers featuring the characters Ragyo Kiryuuin and Ryuuko Matoi, with Ragyo's hair lighting up to the beat, with Ryuuko herself bobbing her head to the beat.
- New: (A.P.E Media Player): Added a visualizer depicting Zero Two from Darling in the FranXX bobbing her head to the beat.
- New: About box to now resemble winver from Windows XP.
- New: Swapped out some static images (volume bar, balance bar, position bar background) with small resizable images using ```<grid/>```.
- Fixed: A bug where if a wasabi window was too small in width, the left hand side edge would disappear.
- Fixed: Media Library component was 2 pixels too tall.

# v1.03.7
What's New?

- New: Remade the bottom Playlist Editor area so it doesn't look all in one place (the buttons and total time display are still in one and there are no plans to seperate them in any way)
- New: Changed how the Visualizer in the Playlist Editor looks so it more or less simulates the Sound Recorder from Windows XP
- New: Remade the Video infobar so it almost looks like the Playlist Editor bottom area where things are seperated
- New: Added a Mini Visualizer to the Video infobar for your enjoyment (also emulates the Sound Recorder's Oscilloscope display more or less)
- New: Added the playstatus from the Main Window to the winshade mode of the Main Window
- Fixed: A long standing issue where the text of the Playlist Editor's winshademode was too big and green-ish
- Fixed: A long standing issue where the resizers were too big for the windows themselves (also added a right horizontal resizer for the rest of the windows)
- Misc: Slight remake of the playstatus in the Main Window

# v1.03.6
What's New?

- Removed: Got rid of the client edge that was inside the windows (essentially a sunken border) as that did not fit with the general 'aesthetic' of usual Win32 programs.

Known issues:

window resizers interfere with the titlebar too much, unintentionally resizing the window, when only wanting to move it around

shade text in playlist editor is green as well as the background being white instead of black

# v1.03.5
What's New?

- New: Adjusted Video window's info bar so it doesn't look like it's slapped on the spot
- New: Proper Winamp and WACUP detection, program icon and name will change whether or not the skin is being used in Winamp/WACUP
- New: Aligned songinfo and actioninfo to the left instead of that being centered
- New: Redone the songinfo area to look more like the address bar in Windows XP's explorer (even includes a winamp icon as a nod to windows explorer)
- New: Reduced font size on the stereo/mono, songinfo display and the shuffle button for UI consistency
- Fixed: Odd pink coloring that was present on the main window under the WACUP about button (and some other areas which were hard to spot)
- Fixed: fixed every line containing "alpha="253"" by changing their value to "255"
- Fixed: Changed generic window background color to the same grey-ish color that other windows have (ugly hack for the color editor)
- Misc: Minor UI adjustments (repositioning of certain things)

# v1.03.4
What's New?

- Fixed: Resized the components by one pixel due to miscalculations
- Fixed: Resized the volume sliders (thanks Victhor!)

# v1.03.3
What's New?

- Fixed: titlebar switcher not working in the equalizer when it was in winshade mode
- Fixed: repositioned the bottom playlist info display
- Fixed: ctrl + w not working in pledit, was fixed by updating skin.xml from victhor's skin.xml file found within Winamp Classic Modern v1.03
- Fixed: ctrl + v not working in the main window, was fixed by updating skin.xml from victhor's skin.xml file found within Winamp Classic Modern v1.03
- Fixed: double click on EQ does not switch to shade as it should, was fixed by updating skin.xml from victhor's skin.xml file found within Winamp Classic Modern v1.03
- Misc: Name change from Windows Classic Modern to Winamp 2000 SP4 x.xx.x

# v1.03.2
Thanks to Victhor pointing most of these issues out
What's New?

- Added: Horizontal cursor for resizing windows horizontally
- Fixed: Winamp/WACUP Preview playlist editor using the incorrect scrollbar and background color
- Fixed: Annoying grey gap found within the generic windows
- Fixed: wrong positioning of the titlebar icon and text
- Fixed: titlebar switcher not working in the main window
- Fixed: wrong selection background color that was being consistently used
- Removed: Color themes, no one needs them, they are bloat.

Known issues:

Playlist Editor being unable to emulate windows behaviour, thanks nullsoft, really loving that one

Modern Skin being unable to tile graphics, making it impossible to properly replicate the checkerboard effect found within Windows 7 and below when running Windows Classic

# v1.03.1
What's New?

Fixed: annoying black color that appeared whenever something used the alternate coloring thing, it was apparent when using WACUP playlists in the Media Library (wasn't tied to WACUP as it turns out, as the alternate coloring every second item in the media library was also used in Winamp)

# v1.03.0
Initial release.

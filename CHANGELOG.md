# v1.03.??? Upcoming (Far future)
What's New?

- New: Gammagroups that actually represent what Windows once had to offer with Windows Classic
- New: Split up the image parts to allow for better color editing
- New: Themes! Including those that were present in Windows 9x/2k/XP
- New: Titlebar beam gradient can be colored independently

# v1.03.8
What's New?

- New: Massive UI overhaul within the Main Player window
- New: Made the songticker background be it's seperate thing
- New: Made the posbar backgronud be it's seperate thing
- New: Winamp Modern Beat Visualizer reimplemented thanks to @jberg
- New: Added a Half-Life 2 like Heads Up Display featuring a crosshair visualizer and a subtitle box displaying the currently playing song
- New: About box to now resemble winver from Windows XP
- New: Swapped out some static images (volume bar, balance bar, position bar background) with small resizable images using <grid/>
- Fixed: A bug where if a wasabi window was too small in width, the left hand side edge would disappear

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

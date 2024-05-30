# ReloadedK's Engine - Gaph Fork

This is a fork of [ReloadedK's Godot Fangame Engine](https://github.com/ReloadedK-git/ReloadedKs-Godot-Fangame-Engine).
The intent of this fork is not to add gimmicks or major engine changes, but to have my QoL changes accessible in a public location.

<details>
<summary>Original description</summary>

# ReloadedK's Godot Fangame Engine

A Godot 4.x fangame engine, created by ReloadedK.

Project started with Godot v4.0.2, which can be adquired at https://godotengine.org/

You can check the [engine's documentation](https://github.com/ReloadedK-git/ReloadedKs-Godot-Fangame-Engine-Docs/blob/main/00_start.md).
</details>

---

# Changelog

### v1.13 (2024-04-17)

* Added HUD scaling to FPS display
* Added dev option for estimating FPS per physics frame rather than per second
* Added additional debug toggles as hardcoded keys in `Player`
* Fix bug with default `DynamicCamera` limits

### v1.12 (2024-04-09)

* Allowed HUD to update while paused, primarily for FPS display
* Changed delta-agnostic per-frame changes to be deltatime-based instead

### v1.11 (2024-04-09)

* Redesigned `scrGlobalSettings` from hardcoded variables to a dictionary
    * Helper functions are added to discourage direct editing of dict values
* Reworked `scrMenuSettings`:
    * Options are generated automatically from the global settings
    * Values are changed directly instead of being assigned at menu close
* Added docstrings to most scripts

### v1.10 (2024-04-07)

* Added window scaling, FPS display, and death/time stats in window title
* Have `objPlayer` emit signals on certain actions
* Refactored `objJumpSwitchSpike` to be one object with four directions, and swap on player jump signals rather than jump keypress

<details>
<summary>Original changelog (in reverse chronological order)</summary>

# Change-log
### v1.9 (01-02-24)

* Fixed small visual bug for ***objLaserDynamic***.
* Added sprite for ***objFadingBlock*** which acts as a visual indicator.
* Added a "sound_stop" function to the sound manager.
* Minor changes to ***rMenuFiles*** (mostly sfx related).
* Camera scrolling for ***rMenuSettings*** and ***rMenuControls*** is now handled automatically.
* Changed ***objCollectableItem*** to work with the updated item saving system.
* Older savefiles are now compatible with newer ones.
* Changed the way items/collectables are handled.
* Items/collectables will remain "collected" even when changing rooms, but a save still needs to be performed to store them permanently.
* Changed ***scrGlobalGame*** to accomodate the new items/collectables and pause system.
* Added support for multiple pause menus/screens.
* Updated ***objPauseMenuMain***.
* Added ***objPauseMenuItems*** and ***objPauseItem***.
* Added support for title screens.
* Added new ***rTitle*** room.

### v1.8 (09-01-24)

* Added a new main menu room.
* Separated menus based on their individual functions (main menu, file selection menu, options menu, controls menu).
* Added a time and death counter for each file.
* Changed the text displayed on the file menu's options.
* Made visual changes to ***rRoomSelection***.
* Locked background scenes for some rooms, including menus.
* Added a new testing room ***rTestingRoom04***.
* Made small tweaks to ***objPlayer*** to make vertical speeds more accurate to traditional fangame physics (credits to RndGuy).
* ***objSavePoint*** now uses its entire 32x32p sprite as a collision area for bullets.
* Added a new background, shader, sound effect and sprites.
* Optimized several collision checking nodes.
* Added a new collision check for ***objPlayer*** (for sheep blocks).
* Optimized the way ***objWater***, ***objTrigger*** and ***objMultiTrigger*** works.
* Removed ***sprWater*** and ***sprTrigger***, since they were no longer necessary.
* Removed script for ***objWater***.
* Checked the "local to scene" property for ***objWater***, ***objTrigger***, ***objMultiTrigger*** and ***objSignProximity***.
* Added several block-based gimmicks (***objFadingBlock, objBouncyBlock, objSpikeBlock***, ***objSheepBlocks***).
* Added manual zooming to ***objCameraDynamic*** and ***objCameraFixed***.
* Added ***objCollisionDialogSpawner***.
* Added extra dialog scene for ***objCollisionDialogSpawner***.
* Made changes to ***scrGlobalGame*** and ***scrPauseMenu*** due to the new dialog spawner.
* Updated licenses and credits.

### v1.7 (24-12-23)

* Added multi-trigger system.
* Added a simpler, collision activated text sign.
* Modified ***objHUD*** and added a notification popup when finding items or collectables.
* Cameras and HUD can be scaled now.
* Added raycast-based lasers (static and dynamic).
* Very minor edits to ***objPlayer***
* Fixed a major bug with ***objCollectableItem***, and slightly changed the way it works due to ***objHUD***'s updates.
* ***objBackgroundMenus*** now uses a scroll shader.
* Both ***objCameraDynamic*** and ***objCameraFixed*** have been updated to work with the new camera zoom scaling.
* Changed the font for the triggers and made the text easier to read.
* Added extra settings to the settings menu (Camera Zoom and HUD Scaling).
* Updated the settings and controls menu to allow for infinite options, alongside visual improvements.
* Camera zoom is now 1x by default.
* Added new rooms (***rRoomSelection***, ***rTestRoom03***).
* Minor updates to several objects.

### v1.6 (07-12-23)

* Engine ported to Godot v4.2 while maintaining compatibility with older versions.
* Modified ***objPlayer***. The xscale variable is now a boolean instead of a float. The function ***set_first_time_saving()*** is called from ***_physics_process()*** due to v4.2's changes.
* Jump particles generated from the player now use a timer to free themselves.
* Save points don't autostart their timers by default.
* Renamed some variables for ***objInvisibleBlock*** so they don't conflict with engine variable names.
* Modified ***objWarp***'s script to be compatible with v4.2.
* ***objHUD***'s debug mode mouse pointer now follows ***objPlayer***'s xscale, and is compatible with v4.2.
* Modified ***scrGlobalGame*** to work with v4.2.
* ***scrSettingsMenu*** now shows "Reset to Defaults" instead of "Reset".
* FileSystem folders are now colored.

### v1.5 (24-10-23)

* Small fix for the player script. The input for the controller stick doesn't need to go all the way to get detected.

### v1.4 (23-10-23)

* Numpad arrows and controller stick can be used to control the player or interact with different objects, if the setting is toggled on.
* Added an "extra keys" option in the settings menu.
* Added extra functionality to the player (movement, walljumping) and dialog sign (interaction).
* Added extra actions in the input map.

### v1.3 (30-09-23)

* Changed ***objInvisibleBlock***.
* Slightly reduced volume for ***sndBlockChange***.

### v1.2 (09-09-23)

* Window position is kept when switching from windowed to fullscreen mode.

### v1.1 (10-07-23)

* Updated to work with Godot 4.1.
* Changed default renderer to ***Compatibility***.
* Changed ***objMovingPlatform*** and ***objMovingBlock***.
* Minor change to ***objHUD***.

### v1.0 (09-07-23)

* Initial release.

</details>

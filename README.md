[![Haxelib Version](https://img.shields.io/badge/haxelib-v0.2.2-blue)](https://lib.haxe.org/p/hxWindowColorMode/) [![Github repository](https://img.shields.io/badge/github-repo-blue?logo=github)](https://github.com/TBar09/hxWindowColorMode-main)

hxWindowColorMode
====

hxWindowColorMode is a haxelib containing C++ functions for setting the window header & border to dark mode, light mode, and even custom colors!

With this library, you are able to:

- Set the window title bar (header) to dark / light mode.
- Set the window header and border to custom colors.
- Set the window title bar text to custom colors.
- Set the corner style of the window.

## Installation

For stable releases, use:
`haxelib install hxWindowColorMode`

If you want to get the latest Github releases of hxWindowColorMode, use:
`haxelib git hxWindowColorMode https://github.com/TBar09/hxWindowColorMode-main.git`

### OpenFL / Haxeflixel projects

Add this to "project.xml` in your project's source code.
```xml
<haxelib name="hxWindowColorMode"/>
```
### Haxe Projects

Add this to `build.hxml`.
```hxml
-lib hxWindowColorMode
```

## Docs / Usage

All of the librarys' functions exists within this module:
`import hxwindowmode.WindowColorMode;`

Here are the functions present in the haxelib currently (as of 0.2.2):

```haxe
/* FUNCTIONS */

// Sets the window to dark mode. (returns true if it was successful)
WindowColorMode.setDarkMode():Bool;

// Sets the window to light mode (default). (returns true if it was successful)
WindowColorMode.setLightMode():Bool;

// Shortcut to both setLightMode and setDarkMode (returns true if it was successful).
WindowColorMode.setWindowColorMode(isDark:Bool = true):Bool;

// Sets the header and/or border to a color of your choosing (Only Windows 11 supports this).
WindowColorMode.setWindowBorderColor(color:Array<Int>, setHeader:Bool = true, setBorder:Bool = true):Void;

// Sets the title text to a color of your choosing. (Only Windows 11 supports this).
WindowColorMode.setWindowTitleColor(color:Array<Int>):Void;

// Sets the window's corners, usually rounded or square shaped. (Only Windows 11 supports this).
// Refer to the `WindowCornerType` enum abstract for available fields.
WindowColorMode.setWindowCornerType(cornerType:WindowCornerType = DEFAULT):Void;

// (deprecated, use redrawWindowHeader) Resets the window.
WindowColorMode.resetScreenSize():Void;

// Resets the window. It is recommended to use this after running any of the functions above so the effect is drawn immediately.
// (Windows 11 doesn't need this, but it's needed on Windows 10, or else the effect won't take place until you unfocus/refocus the window).
WindowColorMode.redrawWindowHeader():Void;

// Checks whether the os is using dark mode. Shortcut to `!isLightTheme()`.
// NOTE: This gets the system's current settings for the theme, not the current window's theme. Use `isDarkMode` for that.
WindowColorMode.isDarkTheme():Bool;

// Checks whether the os is using light mode.
// NOTE: This gets the system's current settings for the theme, not the current window's theme. Use `isDarkMode` for that.
WindowColorMode.isLightTheme():Bool;

/* VARIABLES */

// Returns true if the window is in dark mode.
WindowColorMode.isDarkMode : Bool;

// Returns the current color of the header, empty if no color was set.
WindowColorMode.windowHeaderColor : Array<Int>;

// Returns the current color of the border, empty if no color was set.
WindowColorMode.windowBorderColor : Array<Int>;

// Returns the current color of the title text, empty if no color was set.
WindowColorMode.windowTitleColor : Array<Int>;

// Returns the current corner type of the window (Can also be Int).
WindowColorMode.windowCornerType : WindowCornerType;

// (Read-only) Returns if the current OS is under Windows 11.
WindowColorMode.isWindows10 : Bool;

// (Read-only) A special effect for `setWindowBorderColor` that will remove the drawing of the window border,
// making it possible to have a rounded window with no border.
WindowColorMode.WINDOW_COLOR_NONE : Array<Int> = [255, 255, 254];

// (Read-only) The effect for `setWindowBorderColor` and `setWindowTitleColor` that reset the colors to the system defaults.
WindowColorMode.WINDOW_COLOR_DEFAULT : Array<Int> = [255, 255, 255];
```

Here is an example of setting the window to dark mode when you press the TAB key.
```haxe
override function update(elapsed:Float) {
	super.update(elapsed);

	if(flixel.FlxG.keys.justPressed.TAB) {
		WindowColorMode.setDarkMode();
		if(WindowColorMode.isWindows10)
			WindowColorMode.redrawWindowHeader();
	}
}
```

Here is an example of setting just the window's header to red.
```haxe
WindowColorMode.setWindowBorderColor([255, 0, 0], true, false);
```

Here is an example of setting the window's header and border to green on create,
then turns blue on destroy, while also setting the window's title text to the original
color of the header (which was green).
```haxe
override function create() {
	//Set the header and border to green
	WindowColorMode.setWindowBorderColor([0, 255, 0], true, true);
}

override function destroy() {
	//Set title color to whatever was saved as the current header color.
	WindowColorMode.setWindowTitleColor(WindowColorMode.windowHeaderColor);

	//Set the header and border to blue
	WindowColorMode.setWindowBorderColor([0, 0, 255], true, true);
}
```

Note: Although this library already wraps conditionals (`#if #end`) around each function, it is still advised to wrap hxWindowColorMode methods in:
```haxe
#if(cpp && windows)
// hxWindowColorMode method here
#end
```
To avoid incompatabilities when dealing with projects with multiple targets.

For now, only the Windows C++ target is supported.
Support for Hashlink using `hdll` bindings aren't planned, but are interesting...

## Extras

- Originally made as a [Psych Engine library](https://gamebanana.com/tools/17992).
- If you want to know more on the lua script version, [read the docs here](https://github.com/AlsoGhostglowDev/Ghost-s-Trash-Bin/blob/main/docs/windowcolordocs.md).

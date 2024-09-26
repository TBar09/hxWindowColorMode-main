# hxWindowColorMode

hxWindowColorMode is a mini haxelib containing C++ functions for setting the window border to dark mode, light mode, and even other colors!

## Installation
Use the following command to install hxWindowColorMode into your haxelib library:

`haxelib install hxWindowColorMode`

### For OpenFL / Haxeflixel projects
Add this to "project.xml` in your project's source code.
```xml
<haxelib name="hxWindowColorMode"/>
```
### Haxe Projects
Add this to `build.hxml`.
```hxml
-lib hxWindowColorMode
```

## API / Usage

To use the library, import this in a class of your choice:
`import hxwindowmode.WindowColorMode;`


```haxe
	// FUNCTIONS //

	// Sets the window to dark mode.
	WindowColorMode.setDarkMode();

	// Sets the window to light mode (aka default).
	WindowColorMode.setLightMode();

	// Shortcut to both setLightMode and setDarkMode.
	WindowColorMode.setWindowColorMode(isDark:Bool = true);
	
	// Sets the header and/or border to a color of your choosing. (Only Windows 11 supports this).
	WindowColorMode.setWindowBorderColor(color:Array<Int>, setHeader:Bool = true, setBorder:Bool = true);

	// (deprecated) Resets the window. It is recommended to use this after running any of the functions above so the effect is drawn immediately.
	// (Windows 11 doesn't need this, but it's needed on Windows 10, or else the effect won't take place until you unfocus/refocus the window).
	WindowColorMode.resetScreenSize();

	// Resets the window. It is recommended to use this after running any of the functions above so the effect is drawn immediately.
	// (Windows 11 doesn't need this, but it's needed on Windows 10, or else the effect won't take place until you unfocus/refocus the window).
	WindowColorMode.redrawWindowHeader();

	// VARIABLES //
	WindowColorMode.isDarkMode // (Boolean) returns true if the window is dark mode.
	WindowColorMode.windowHeaderColor // (Array<Int>) returns the current color of the header.
	WindowColorMode.windowBorderColor // (Array<Int>) returns the current color of the border.
```

Here is an example of setting the window to dark mode when you press the TAB key.
```haxe
	override function update(elapsed:Float) {
		if(flixel.FlxG.keys.justPressed.TAB) {
			WindowColorMode.setDarkMode();
			WindowColorMode.redrawWindowHeader();
		}
	}
```

Here is an example of setting the window's header to red.
```haxe
	override function create() {
		WindowColorMode.setWindowBorderColor([255, 0, 0], true, false);
		WindowColorMode.redrawWindowHeader();
	}
```

## Extras

- The original submit was a lua script for Psych Engine, go check it out here: `https://gamebanana.com/tools/17992`
- The (lua script variant) functions will be added to Ghost Utilities V3 along with a new lua module. check it out here: `https://github.com/AlsoGhostglowDev/Ghost-s-Utilities`
- If you want to read up more on the lua script's documentation, read here: `https://github.com/AlsoGhostglowDev/Ghost-s-Trash-Bin/blob/main/docs/windowcolordocs.md`
- Functions will be added to a bigger haxelib dedicated to C++ and window functions.
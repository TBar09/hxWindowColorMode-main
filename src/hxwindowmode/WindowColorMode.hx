package hxwindowmode;

import hxwindowmode.backend.WindowBackend;

class WindowColorMode
{
	public static var isDarkMode:Bool = false; // If the window is currently dark mode or not.
	public static var windowHeaderColor:Array<Int> = []; // returns the current color of the header.
	public static var windowBorderColor:Array<Int> = []; // returns the current color of the border.
	
	// Shortcut to both setLightMode and setDarkMode.
	// isDark:Bool Do you want to set the window to dark mode?
	public static function setWindowColorMode(isDark:Bool = true)
    {
        WindowBackend.setWindowColorMode(isDark);
		isDarkMode = isDark;
    }
	
	// Sets the window to dark mode.
	public static function setDarkMode()
    {
        WindowBackend.setWindowColorMode(true);
		isDarkMode = true;
    }
	
	// Sets the window to light mode (aka default).
	public static function setLightMode()
    {
        WindowBackend.setWindowColorMode(false);
		isDarkMode = false;
    }
	
	// Sets the header and/or border to a color of your choosing. (Only Windows 11 supports this).
	// color:Array<Int> The color of the window border/header. organized as [R (0 to 255), G (0 to 255), B (0 to 255)]
	// setHeader:Bool = true Do you want to set the header to the specified color?
	// setBorder:Bool = true Do you want to set the border to the specified color?
	public static function setWindowBorderColor(color:Array<Int>, setHeader:Bool = true, setBorder:Bool = true)
    {
		if(color == null) color = [255, 255, 255];
        WindowBackend.setWindowBorderColor(color, setHeader, setBorder);
		if(setHeader) windowHeaderColor = color;
		if(setBorder) windowBorderColor = color;
    }
	
	// Resets the window. It is recommended to use this after running any of the functions above so the effect is drawn immediately.
	// (Windows 11 doesn't need this, but it's needed on Windows 10, or else the effect won't take place until you unfocus/refocus the window).
	public static function resetScreenSize()
    {
		if(flixel.FlxG.stage.window.maximized) {
			flixel.FlxG.stage.window.maximized = false;
			flixel.FlxG.stage.window.maximized = true;
		} else {
			flixel.FlxG.stage.window.maximized = true;
			flixel.FlxG.stage.window.maximized = false;
		}
		
		WindowBackend.updateWindow();
    }
}

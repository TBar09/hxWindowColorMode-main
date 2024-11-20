package hxwindowmode;

import hxwindowmode.backend.WindowBackend;

class WindowColorMode
{
	/**
	 * If the window is currently dark mode or not.
	 */
	public static var isDarkMode:Bool = false;
	
	/**
	 * Returns the current color of the header.
	 */
	public static var windowHeaderColor:Array<Int> = [];
	
	/**
	 * Returns the current color of the border.
	 */
	public static var windowBorderColor:Array<Int> = [];
	
	/**
	 * Returns the current color of the title text.
	 */
	public static var windowTitleColor:Array<Int> = [];
	
	/**
	 * Shortcut to both `setLightMode` and `setDarkMode`.
	 *
	 * @param   isDark    Do you want to set the window to dark mode?
	 */
	public static function setWindowColorMode(isDark:Bool = true)
    {
		#if cpp
        WindowBackend.setWindowColorMode(isDark);
		isDarkMode = isDark;
		#else
		trace('`setWindowColorMode` is not available on this platform!');
		#end
    }
	
	/**
	 * Sets the window to dark mode.
	 */
	public static function setDarkMode()
    {
		#if cpp
        WindowBackend.setWindowColorMode(true);
		isDarkMode = true;
		#else
		trace('`setDarkMode` is not available on this platform!');
		#end
    }
	
	/**
	 * Sets the window to light mode (aka default).
	 */
	public static function setLightMode()
    {
		#if cpp
        WindowBackend.setWindowColorMode(false);
		isDarkMode = false;
		#else
		trace('`setLightMode` is not available on this platform!');
		#end
    }

	/**
	 * Sets the header and/or border to a color of your choosing. (Only Windows 11 supports this).
	 *
	 * @param   color        The color of the window border/header. organized as [R (0 to 255), G (0 to 255), B (0 to 255)].
	 * @param   setHeader    Do you want to set the header to the specified color?
	 * @param   setBorder    Do you want to set the border to the specified color?
	 */
	public static function setWindowBorderColor(color:Array<Int>, setHeader:Bool = true, setBorder:Bool = true)
    {
		#if cpp
        WindowBackend.setWindowBorderColor(((color != null) ? color : [255, 255, 255]), setHeader, setBorder);
		if(setHeader) windowHeaderColor = ((color != null) ? color : [255, 255, 255]);
		if(setBorder) windowBorderColor = ((color != null) ? color : [255, 255, 255]);
		#else
		trace('`setWindowBorderColor` is not available on this platform!');
		#end
    }
	
	/**
	 * Sets the window title text to a color of your choosing. (Only Windows 11 supports this).
	 *
	 * @param   color        The color of the window border/header. organized as [R (0 to 255), G (0 to 255), B (0 to 255)].
	 */
	public static function setWindowTitleColor(color:Array<Int>)
    {
		#if cpp
        WindowBackend.setWindowTitleColor(((color != null) ? color : [255, 255, 255]));
		windowTitleColor = ((color != null) ? color : [255, 255, 255]);
		#else
		trace('`setWindowTitleColor` is not available on this platform!');
		#end
    }
	
	/**
	 * Resets the window. It is recommended to use this after running any of the functions above so the effect is drawn immediately.
	 * (Windows 11 doesn't need this, but it's needed on Windows 10, or else the effect won't take place until you unfocus/refocus the window).
	 */
	@:deprecated("resetScreenSize is deprecated, use redrawWindowHeader instead.")
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
	
	/**
	 * Resets the window. It is recommended to use this after running any of the functions above so the effect is drawn immediately.
	 * (Windows 11 doesn't need this, but it's needed on Windows 10, or else the effect won't take place until you unfocus/refocus the window).
	 */
	public static function redrawWindowHeader()
    {
		flixel.FlxG.stage.window.borderless = true;
		flixel.FlxG.stage.window.borderless = false;
    }
}

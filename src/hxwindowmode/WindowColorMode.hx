package hxwindowmode;

#if(cpp && windows)
import hxwindowmode.backend.WindowBackend;
#end

class WindowColorMode {

	/**
	 * If the window is currently dark mode or not.
	 */
	public static var isDarkMode(default, null):Bool = false;

	/**
	 * Returns the current color of the header.
	 */
	public static var windowHeaderColor(default, null):Array<Int> = [];

	/**
	 * Returns the current color of the border.
	 */
	public static var windowBorderColor(default, null):Array<Int> = [];

	/**
	 * Returns the current color of the title text.
	 */
	public static var windowTitleColor(default, null):Array<Int> = [];

	/**
	 * Returns the window corner type.
	 */
	public static var windowCornerType(default, null):Int = 0;

	/**
	 * Returns if the current running OS is windows 10.
	 * Useful for checking if you need to force redraw the window header.
	 */
	public static var isWindows10(get, never):Bool;
	public static function get_isWindows10():Bool {
		#if lime
		//could use some C++ code but this works too
		return (lime.system.System.platformLabel.toLowerCase().indexOf("windows 10") != -1);
		#else
		return true;
		#end
	}

	/**
	 * Shortcut to both `setLightMode` and `setDarkMode`.
	 *
	 * @param   isDark    Do you want to set the window to dark mode?
	 */
	public static inline function setWindowColorMode(isDark:Bool = true):Bool {
		#if(cpp && windows)
		var isChanged:Bool = WindowBackend.setWindowColorMode(isDark);
		if(isChanged) isDarkMode = isDark;
		return isChanged;
		#else
		trace('`setWindowColorMode` is not available on this platform!');
		return false;
		#end
	}

	/**
	 * Sets the window to dark mode.
	 */
	public static inline function setDarkMode():Bool {
		#if(cpp && windows)
		return WindowBackend.setWindowColorMode(true);
		#else
		trace('`setDarkMode` is not available on this platform!');
		return false;
		#end
	}

	/**
	 * Sets the window to light mode (aka default).
	 */
	public static inline function setLightMode():Bool {
		#if(cpp && windows)
		return WindowBackend.setWindowColorMode(false);
		#else
		trace('`setLightMode` is not available on this platform!');
		return false;
		#end
	}

	/**
	 * Sets the header and/or border to a color of your choosing. (Only Windows 11 supports this).
	 *
	 * @param   color        The color of the window border/header. organized as [R (0 to 255), G (0 to 255), B (0 to 255)].
	 * @param   setHeader    Do you want to set the header to the specified color?
	 * @param   setBorder    Do you want to set the border to the specified color?
	 */
	public static inline function setWindowBorderColor(color:Array<Int>, setHeader:Bool = true, setBorder:Bool = true) {
		#if(cpp && windows)
		var colorArray:Array<Int> = color != null ? color : [255, 255, 255];
		WindowBackend.setWindowBorderColor(colorArray, setHeader, setBorder);

		if(setHeader) windowHeaderColor = colorArray;
		if(setBorder) windowBorderColor = colorArray;
		#else
		trace('`setWindowBorderColor` is not available on this platform!');
		#end
	}

	/**
	 * Sets the window title text to a color of your choosing. (Only Windows 11 supports this).
	 *
	 * @param   color        The color of the window border/header. organized as [R (0 to 255), G (0 to 255), B (0 to 255)].
	 */
	public static inline function setWindowTitleColor(color:Array<Int>) {
		#if(cpp && windows)
		var colorArray:Array<Int> = color != null ? color : [255, 255, 255];
		WindowBackend.setWindowTitleColor(colorArray);
		windowTitleColor = colorArray;
		#else
		trace('`setWindowTitleColor` is not available on this platform!');
		#end
	}

	/**
	 * Sets the window's corners, usually rounded or square shaped. (Only Windows 11 supports this).
	 * Check out the `WindowCornerType` enum abstract for more info.
	 *
	 * @param   cornerType	 The corner type to use.
	 */
	public static inline function setWindowCornerType(?cornerType:Int = 0) {
		#if(cpp && windows)
		WindowBackend.setWindowCornerType(cornerType);
		windowCornerType = cornerType;
		#else
		trace('`setWindowCornerType` is not available on this platform!');
		#end
	}

	/**
	 * Resets the window. It is recommended to use this after running any of the functions above so the effect is drawn immediately.
	 * (Windows 11 doesn't need this, but it's needed on Windows 10, or else the effect won't take place until you unfocus/refocus the window).
	 */
	@:deprecated("resetScreenSize is deprecated, use redrawWindowHeader instead.")
	public static inline function resetScreenSize() {
		redrawWindowHeader();

		WindowBackend.updateWindow();
	}

	/**
	 * Resets the window. It is recommended to use this after running any of the functions above so the effect is drawn immediately.
	 * (Windows 11 doesn't need this, but it's needed on Windows 10, or else the effect won't take place until you unfocus/refocus the window).
	 */
	public static inline function redrawWindowHeader() {
		#if lime
		for (i in 0...2) lime.app.Application.current.window.borderless = !lime.app.Application.current.window.borderless;
		#end
	}
}

enum abstract WindowCornerType(Int) {
	var DEFAULT = 0;	//System defaults
	var DONOTROUND = 1; //No round corners
	var ROUND = 2;		//Round the corners
	var ROUNDSMALL = 3; //Round the corners with a smaller radius
}
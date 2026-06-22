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
	 * The current color of the header.
	 */
	public static var windowHeaderColor(default, null):Array<Int> = [];

	/**
	 * The current color of the border.
	 */
	public static var windowBorderColor(default, null):Array<Int> = [];

	/**
	 * The current color of the title text.
	 */
	public static var windowTitleColor(default, null):Array<Int> = [];

	/**
	 * The current window corner type applied on the window.
	 */
	public static var windowCornerType(default, null):WindowCornerType = DEFAULT;

	/**
	 * A special effect for `setWindowBorderColor` that will remove the drawing of the
	 * window border, making it possible to have a rounded window with no border.
	 */
	public static final WINDOW_COLOR_NONE:Array<Int> = [255, 255, 254];

	/**
	 * The effect for `setWindowBorderColor` and `setWindowTitleColor` that
	 * reset the window's colors to the system defaults.
	 */
	public static final WINDOW_COLOR_DEFAULT:Array<Int> = [255, 255, 255];

	/**
	 * Returns if the current running OS is windows 10.
	 * Useful for checking if you need to force redraw the window header.
	 */
	public static var isWindows10(get, never):Bool;

	@:noCompletion
	private static inline function get_isWindows10():Bool {
		#if(cpp && windows)
		return WindowBackend.getMajorWindowsVersion() < 11; //If current windows version is under Win 11
		#else
		return true;
		#end
	}

	/**
	 * Sets the active window to dark / light mode.
	 * Use `setLightMode` and `setDarkMode` as shortcuts to this.
	 *
	 * @param   isDark		Whether to set the window to dark mode.
	 *
	 * @return Whether the method was successful.
	 */
	public static inline function setWindowColorMode(isDark:Bool = true):Bool {
		#if(cpp && windows)
		var isChanged:Bool = WindowBackend.setWindowColorMode(isDark);
		if(isChanged) isDarkMode = isDark;

		return isChanged;
		#else
		return false;
		#end
	}

	/**
	 * Sets the window to dark mode.
	 *
	 * @return Whether the method was successful.
	 */
	public static inline function setDarkMode():Bool {
		return setWindowColorMode(true);
	}

	/**
	 * Sets the window to light mode.
	 *
	 * @return Whether the method was successful.
	 */
	public static inline function setLightMode():Bool {
		return setWindowColorMode(false);
	}

	/**
	 * Sets the header and/or border to a color of your choosing (Only Windows 11 supports this).
	 *
	 * @param   color			The color of the window border/header. organized as [R (0 to 255), G (0 to 255), B (0 to 255)].
	 * @param   setHeader		Whether to set the header to the specified color.
	 * @param   setBorder		Whether to set the border to the specified color.
	 */
	public static inline function setWindowBorderColor(color:Array<Int>, setHeader:Bool = true, setBorder:Bool = true) {
		#if(cpp && windows)
		var colorArray:Array<Int> = color != null ? color : [255, 255, 255];
		WindowBackend.setWindowBorderColor(colorArray, setHeader, setBorder);

		if(setHeader) windowHeaderColor = colorArray;
		if(setBorder) windowBorderColor = colorArray;
		#end
	}

	/**
	 * Sets the window title text to a color of your choosing (Only Windows 11 supports this).
	 *
	 * @param   color		The color of the window border/header. organized as [R (0 to 255), G (0 to 255), B (0 to 255)].
	 */
	public static inline function setWindowTitleColor(color:Array<Int>) {
		#if(cpp && windows)
		var colorArray:Array<Int> = color != null ? color : [255, 255, 255];
		WindowBackend.setWindowTitleColor(colorArray);

		windowTitleColor = colorArray;
		#end
	}

	/**
	 * Sets the window's corners, usually rounded or square shaped (Only Windows 11 supports this).
	 * Refer to the `WindowCornerType` enum abstract for available fields.
	 *
	 * @param   cornerType		The corner type to use.
	 */
	public static inline function setWindowCornerType(?cornerType:WindowCornerType = DEFAULT) {
		#if(cpp && windows)
		WindowBackend.setWindowCornerType(cornerType);
		windowCornerType = cornerType;
		#end
	}

	/**
	 * Resets the window. This is deprecated by `redrawWindowHeader`.
	 */
	@:deprecated("resetScreenSize is deprecated, use redrawWindowHeader instead.")
	public static inline function resetScreenSize() {
		#if(cpp && windows)
		redrawWindowHeader();
		WindowBackend.updateWindow();
		#end
	}

	/**
	 * Redraws the window header. It is recommended to use this after running any of the functions above so the effect is drawn immediately.
	 * (Windows 11 doesn't need this, but it's needed on Windows 10, or else the effect won't appear until you refocus the window).
	 */
	public static inline function redrawWindowHeader() {
		#if(desktop && lime)
		lime.app.Application.current.window.borderless = !lime.app.Application.current.window.borderless;
		lime.app.Application.current.window.borderless = !lime.app.Application.current.window.borderless;
		#end
	}

	/**
	 * Checks whether the os is using light mode.
	 * NOTE: This gets the system's current settings for the theme,
	 * not the current window's theme. Use `isDarkMode` for that.
	 *
	 * @return Whether the os is in light mode.
	 */
	public static inline function isLightTheme():Bool {
		#if(cpp && windows)
		return WindowBackend.isLightTheme();
		#else
		return false;
		#end
	}

	/**
	 * Checks whether the os is using dark mode.
	 * Shortcut to `!isLightTheme()`.
	 *
	 * @return Whether the os is in dark mode.
	 */
	public static inline function isDarkTheme():Bool {
		return !isLightTheme();
	}
}

enum abstract WindowCornerType(Int) from Int to Int {
	var DEFAULT = 0;	//System defaults
	var DONOTROUND = 1; //No round corners
	var ROUND = 2;		//Round the corners
	var ROUNDSMALL = 3; //Round the corners with a smaller radius
}

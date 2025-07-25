package hxwindowmode;

import hxwindowmode.backend.WindowBackend;

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
	 * Shortcut to both `setLightMode` and `setDarkMode`.
	 *
	 * @param   isDark    Do you want to set the window to dark mode?
	 */
	public static inline function setWindowColorMode(isDark:Bool = true) {
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
	public static inline function setDarkMode() {
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
	public static inline function setLightMode() {
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
	public static inline function setWindowBorderColor(color:Array<Int>, setHeader:Bool = true, setBorder:Bool = true) {
		#if cpp
		var colorArray:Array<Int> = color != null ? color : [255, 255, 255];
		WindowBackend.setWindowBorderColor(colorArray, setHeader, setBorder);
		if (setHeader || setBorder)
			windowHeaderColor = colorArray;
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
		#if cpp
		var colorArray:Array<Int> = color != null ? color : [255, 255, 255];
		WindowBackend.setWindowTitleColor(colorArray);
		windowTitleColor = colorArray;
		#else
		trace('`setWindowTitleColor` is not available on this platform!');
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
		for (i in 0...2)
			lime.app.Application.current.window.borderless = !lime.app.Application.current.window.borderless;
		#end
	}
}

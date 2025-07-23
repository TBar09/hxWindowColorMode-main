package hxwindowmode.backend;

@:buildXml("<include name='${haxelib:hxWindowColorMode}/src/hxwindowmode/backend/build.xml' />")
@:include("windowbackend.hpp")
@:allow(hxwindowmode.WindowColorMode)
extern class WindowBackend {
	@:native("nativeWindowColorMode::setWindowColorMode")
	private static function setWindowColorMode(isDarkMode:Bool):Void;

	@:native("nativeWindowColorMode::setWindowBorderColor")
	private static function setWindowBorderColor(color:Array<Int>, setHeader:Bool = true, setBorder:Bool = false):Void;

	@:native("nativeWindowColorMode::setWindowTitleColor")
	private static function setWindowTitleColor(color:Array<Int>):Void;

	@:native("nativeWindowColorMode::updateWindow")
	private static function updateWindow():Void;
}

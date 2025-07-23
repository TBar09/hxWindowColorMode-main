package hxwindowmode.backend;

@:buildXml("<include name='${haxelib:hxWindowColorMode}/src/hxwindowmode/backend/build.xml' />")
@:include("windowbackend.hpp")
@:allow(hxwindowmode.WindowColorMode)
extern class WindowBackend {
	@:native("setWindowColorMode")
	private static function setWindowColorMode(isDarkMode:Bool):Void;

	@:native("setWindowBorderColor")
	private static function setWindowBorderColor(color:Array<Int>, setHeader:Bool = true, setBorder:Bool = false):Void;

	@:native("setWindowTitleColor")
	private static function setWindowTitleColor(color:Array<Int>):Void;

	@:native("setWindowTitleColor")
	private static function updateWindow():Void;
}
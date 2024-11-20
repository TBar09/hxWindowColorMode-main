package hxwindowmode.backend;

#if windows
@:buildXml('
<target id="haxe">
    <lib name="dwmapi.lib" if="windows" />
</target>
')
@:cppFileCode('
#include <Windows.h>
#include <cstdio>
#include <iostream>
#include <tchar.h>
#include <dwmapi.h>
#include <winuser.h>
')
#elseif linux
@:cppFileCode("#include <stdio.h>")
#end
class WindowBackend
{
	#if windows
	@:functionCode('
        HWND window = GetActiveWindow();
		int isDark = (isDarkMode ? 1 : 0);
		
        if (DwmSetWindowAttribute(window, 19, &isDark, sizeof(isDark)) != S_OK) {
            DwmSetWindowAttribute(window, 20, &isDark, sizeof(isDark));
        }
        UpdateWindow(window);
    ')
	public static function setWindowColorMode(isDarkMode:Bool) {}
	
	@:functionCode('
        HWND window = GetActiveWindow();
		auto finalColor = RGB(color[0], color[1], color[2]);
		
		if(setHeader) DwmSetWindowAttribute(window, 35, &finalColor, sizeof(COLORREF));
		if(setBorder) DwmSetWindowAttribute(window, 34, &finalColor, sizeof(COLORREF));
		
        UpdateWindow(window);
    ')
	public static function setWindowBorderColor(color:Array<Int>, setHeader:Bool = true, setBorder:Bool = false) {}
	
	@:functionCode('
        HWND window = GetActiveWindow();
		auto finalColor = RGB(color[0], color[1], color[2]);
		
		DwmSetWindowAttribute(window, 36, &finalColor, sizeof(COLORREF));
        UpdateWindow(window);
    ')
	public static function setWindowTitleColor(color:Array<Int>) {}
	
	@:functionCode('UpdateWindow(GetActiveWindow());')
	public static function updateWindow() {}
	#end
}
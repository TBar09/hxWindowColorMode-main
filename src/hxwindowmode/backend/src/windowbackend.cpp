#include "windowbackend.hpp"

#ifdef HX_WINDOWS
#include <Windows.h>
#include <dwmapi.h>
#endif

bool nativeWindowColorMode::setWindowColorMode(bool isDarkMode)
{
	#ifdef HX_WINDOWS
	HWND window = GetActiveWindow();
	int isDark = (isDarkMode ? 1 : 0);
	bool hasChanged = (DwmSetWindowAttribute(window, 19, &isDark, sizeof(isDark)) == S_OK);

	if (!hasChanged)
	{
		hasChanged = (DwmSetWindowAttribute(window, 20, &isDark, sizeof(isDark)) == S_OK);
	}
	UpdateWindow(window);

	return hasChanged;
	#else
	return false;
	#endif
}

void nativeWindowColorMode::setWindowBorderColor(::Array<int> color, bool setHeader, bool setBorder)
{
	#ifdef HX_WINDOWS
	HWND window = GetActiveWindow();
	auto finalColor = RGB(color[0], color[1], color[2]);

	if(setHeader)
		DwmSetWindowAttribute(window, 35, &finalColor, sizeof(COLORREF));
	if(setBorder)
		DwmSetWindowAttribute(window, 34, &finalColor, sizeof(COLORREF));

	UpdateWindow(window);
	#endif
}

void nativeWindowColorMode::setWindowTitleColor(::Array<int> color)
{
	#ifdef HX_WINDOWS
	HWND window = GetActiveWindow();
	auto finalColor = RGB(color[0], color[1], color[2]);

	DwmSetWindowAttribute(window, 36, &finalColor, sizeof(COLORREF));
	UpdateWindow(window);
	#endif
}

void nativeWindowColorMode::setWindowCornerType(int cornerType)
{
	#ifdef HX_WINDOWS
	HWND window = GetActiveWindow();

	DwmSetWindowAttribute(window, 33, &cornerType, sizeof(cornerType));
	UpdateWindow(window);
	#endif
}

void nativeWindowColorMode::updateWindow()
{
	#ifdef HX_WINDOWS
	UpdateWindow(GetActiveWindow());
	#endif
}
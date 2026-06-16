#include "windowbackend.hpp"

#ifdef HX_WINDOWS
#include <Windows.h>
#include <dwmapi.h>
#include <vector>
#include <string>
#include <stdexcept>
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

	if (setHeader)
		DwmSetWindowAttribute(window, 35, &finalColor, sizeof(COLORREF));
	if (setBorder)
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

/**
 * @see https://stackoverflow.com/questions/51334674/how-to-detect-windows-10-light-dark-mode-in-win32-application
 */
bool nativeWindowColorMode::isLightTheme()
{
#ifdef HX_WINDOWS
	// The value is expected to be a REG_DWORD, which is a signed 32-bit little-endian
	auto buffer = std::vector<char>(4);
	auto cbData = static_cast<DWORD>(buffer.size() * sizeof(char));
	auto res = RegGetValueW(
		HKEY_CURRENT_USER,
		L"Software\\Microsoft\\Windows\\CurrentVersion\\Themes\\Personalize",
		L"AppsUseLightTheme",
		RRF_RT_REG_DWORD, // expected value type
		nullptr,
		buffer.data(),
		&cbData);

	if (res != ERROR_SUCCESS)
	{
		throw std::runtime_error("Error: error_code=" + std::to_string(res));
	}

	// convert bytes written to our buffer to an int, assuming little-endian
	auto i = int(buffer[3] << 24 |
				 buffer[2] << 16 |
				 buffer[1] << 8 |
				 buffer[0]);

	return i == 1;
#else
	return false;
#endif
}
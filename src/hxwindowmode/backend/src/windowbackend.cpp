#include "windowbackend.hpp"

#ifdef HX_WINDOWS
#include <Windows.h>
#include <dwmapi.h>
#endif

void setWindowColorMode(bool isDarkMode)
{
    #ifdef HX_WINDOWS
    HWND window = GetActiveWindow();
    int isDark = (isDarkMode ? 1 : 0);

    if (DwmSetWindowAttribute(window, 19, &isDark, sizeof(isDark)) != S_OK)
    {
        DwmSetWindowAttribute(window, 20, &isDark, sizeof(isDark));
    }
    UpdateWindow(window);
    #endif
}

void setWindowBorderColor(::Array<int> color, bool setHeader, bool setBorder)
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

void setWindowTitleColor(::Array<int> color)
{
    #ifdef HX_WINDOWS
    HWND window = GetActiveWindow();
    auto finalColor = RGB(color[0], color[1], color[2]);

    DwmSetWindowAttribute(window, 36, &finalColor, sizeof(COLORREF));
    UpdateWindow(window);
    #endif
}

void updateWindow()
{
    #ifdef HX_WINDOWS
    UpdateWindow(GetActiveWindow());
    #endif
}
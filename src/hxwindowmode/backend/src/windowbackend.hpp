#pragma once

#include <hxcpp.h>

void setWindowColorMode(bool isDarkMode);
void setWindowBorderColor(::Array<int> color, bool setHeader, bool setBorder);
void setWindowTitleColor(::Array<int> color);
void updateWindow();
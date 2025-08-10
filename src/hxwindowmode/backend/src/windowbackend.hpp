#pragma once

#include <hxcpp.h>

namespace nativeWindowColorMode
{
	bool setWindowColorMode(bool isDarkMode);
	void setWindowBorderColor(::Array<int> color, bool setHeader, bool setBorder);
	void setWindowTitleColor(::Array<int> color);
	void setWindowCornerType(int cornerType);
	void updateWindow();
}
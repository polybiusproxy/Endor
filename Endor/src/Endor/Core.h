#pragma once

#ifdef ENDR_PLATFORM_WINDOW
	#ifdef ENDR_BUILD_DLL
		#define ENDOR_API __declspec(dllexport)
	#else
		#define ENDOR_API __declspec(dllimport)
	#endif
#else
	#error Endor only supports Windows!
#endif
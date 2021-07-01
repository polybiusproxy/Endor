#pragma once

#include "Core.h"

namespace Endor
{
	class ENDOR_API Application
	{
	public:
		Application();
		virtual ~Application();

		void Run();
	};
}
#pragma once

#ifndef HXCPP_H
#include <hxcpp.h>
#endif

#include "stb_image.h"

namespace endor
{
    namespace stb_image
    {
        extern Dynamic load(::String filename, int req_comp);
    }
}
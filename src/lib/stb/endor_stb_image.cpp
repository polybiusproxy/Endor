#include <hxcpp.h>

#define STB_IMAGE_IMPLEMENTATION
#include "stb_image.h"

namespace endor
{
    namespace stb_image
    {
        Array<unsigned char> toHaxeBytes(unsigned char *bytes, int length);

        Dynamic load(::String filename, int req_comp)
        {
            int width, height, channels;
            unsigned char *data = stbi_load(filename, &width, &height, &channels, req_comp);

            if (!data)
                return null();

            if (req_comp == 0)
                req_comp = channels;

            Array<unsigned char> bytes = toHaxeBytes(data, width * height * channels);
            stbi_image_free(data);

            return toImageData(width, height, channels, bytes);
        }

        Dynamic toImageData(int width, int height, int channels, Array<unsigned char> data)
        {
            hx::Anon result = hx::Anon_obj::Create();

            result->Add(HX_CSTRING("width"), width);
            result->Add(HX_CSTRING("height"), height);
            result->Add(HX_CSTRING("channels"), channels);
            result->Add(HX_CSTRING("data"), data);

            return result;
        }

        Array<unsigned char> toHaxeBytes(unsigned char *bytes, int length)
        {
            Array<unsigned char> haxeBytes = new Array_obj<unsigned char>(length, length);
            memcpy(haxeBytes->GetBase(), bytes, length);

            return haxeBytes;
        }
    }
}
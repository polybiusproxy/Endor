#pragma once

#ifndef HXCPP_H
#include <hxcpp.h>
#endif

#include <vorbis/vorbisfile.h>

namespace endor
{
    namespace vorbis
    {
        extern OggVorbis_File vb_open(Array<unsigned char> data);
        extern Dynamic vb_info(OggVorbis_File vf);
    }
}
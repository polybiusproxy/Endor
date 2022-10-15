#pragma once

#ifndef HXCPP_H
#include <hxcpp.h>
#endif

#include <vorbis/vorbisfile.h>

namespace endor
{
    namespace vorbis
    {
        extern OggVorbis_File vb_open(::String filename);
        extern Dynamic vb_info(OggVorbis_File vf);
        extern Dynamic vb_read(OggVorbis_File vf);
    }
}
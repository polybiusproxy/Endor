#include <hxcpp.h>
#include <vorbis/vorbisfile.h>

namespace endor
{
    namespace vorbis
    {
        OggVorbis_File vb_open(Array<unsigned char> data)
        {
            OggVorbis_File vf;

            unsigned char *bytes = data->GetBase();
            // memcpy(bytes, data->GetBase(), data->length);

            if (ov_open_callbacks(bytes, &vf, NULL, 0, OV_CALLBACKS_NOCLOSE) < 0)
            {
                printf("[Endor] [libvorbis] Invalid OggVorbis stream\n");
            }

            return vf;
        }

        Dynamic vb_info(OggVorbis_File vf)
        {
            vorbis_info *vi = ov_info(&vf, -1);

            hx::Anon result = hx::Anon_obj::Create();
            result->Add(HX_CSTRING("channels"), vi->channels);
            result->Add(HX_CSTRING("samplingRate"), vi->rate);

            return result;
        }
    }
}
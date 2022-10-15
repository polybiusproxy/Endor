#include <hxcpp.h>
#include <vorbis/vorbisfile.h>
#include <windows.h>

#define BUFFER_SIZE 32768 // 32KB buffers

namespace endor
{
    namespace vorbis
    {
        Array<unsigned char> toHaxeBytes(unsigned char *bytes, int length);

        OggVorbis_File vb_open(::String filename)
        {
            OggVorbis_File vf;
            FILE *fp = fopen(filename, "rb");

            if (ov_open_callbacks(fp, &vf, NULL, 0, OV_CALLBACKS_NOCLOSE) < 0)
            {
                printf("[Endor] [libvorbis] Invalid OggVorbis stream\n");
                exit(-1);
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

        Dynamic vb_read(OggVorbis_File vf)
        {
            vorbis_info *vi = ov_info(&vf, -1);
            size_t dataLen = ov_pcm_total(&vf, -1) * vi->channels * 2;

            printf("[Endor] [libvorbis] Allocating %ld bytes...\n", dataLen);

            unsigned char *rawData = new unsigned char[dataLen];

            long size = 0;
            int sel = 0;
            while (size < dataLen)
            {
                long result = ov_read(&vf, (char *)rawData + size, dataLen - size, 0, 2, 1, &sel);

                if (result < 0)
                {
                    printf("[Endor] [libvorbis] FAULTY OGG FILE");
                    exit(-1);
                }
                else
                {
                    size += result;
                }
            }

            printf("[Endor] [libvorbis] Decoded audio file!\n");

            hx::Anon result = hx::Anon_obj::Create();
            result->Add(HX_CSTRING("data"), toHaxeBytes(rawData, size));
            result->Add(HX_CSTRING("dataLen"), size);

            printf("[Endor] [libvorbis] Converted to Haxe format!\n");

            ov_clear(&vf);

            return result;
        }

        Array<unsigned char> toHaxeBytes(unsigned char *bytes, int length)
        {
            Array<unsigned char> haxeBytes = new Array_obj<unsigned char>(length, length);
            memcpy(haxeBytes->GetBase(), bytes, length);

            printf("[Endor] [libvorbis] Converted bytes!\n");

            return haxeBytes;
        }
    }
}
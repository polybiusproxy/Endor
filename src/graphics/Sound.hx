package graphics;

import haxe.io.Path;
import haxe.io.Bytes;
import lib.openal.AL.*;
import lib.vorbis.Vorbis.*;
import sys.io.File;

class Sound
{
	static var sources:Array<Int> = [];
	static var buffers:Array<Int> = [];

	public function new(filename:String)
	{
		alListener3f(AL_POSITION, 0, 0, 1);
		alListener3f(AL_VELOCITY, 0, 0, 0);
		alListenerfv(AL_ORIENTATION, [0, 0, 1, 0, 1, 0]);

		alGenSources(1, sources);

		alSourcef(sources[0], AL_PITCH, 1);
		alSourcef(sources[0], AL_GAIN, 1);
		alSource3f(sources[0], AL_POSITION, 0, 0, 0);
		alSource3f(sources[0], AL_VELOCITY, 0, 0, 0);
		alSourcei(sources[0], AL_LOOPING, AL_TRUE);

		alGenBuffers(1, buffers);

		switch (Path.extension(filename))
		{
			case "wav":
				loadWAV(filename);
			case "ogg":
				loadOGG(filename);
		}
	}

	public function play()
	{
		alSourcei(sources[0], AL_BUFFER, buffers[0]);
		alSourcePlay(sources[0]);
	}

	function loadWAV(filename:String)
	{
		var file = File.read("res/audio/" + filename, true);
		var wav = new format.wav.Reader(file).read();

		var format:Int = switch (wav.header.channels)
		{
			case 1:
				switch (wav.header.bitsPerSample)
				{
					case 8:
						AL_FORMAT_MONO8;
					case 16:
						AL_FORMAT_MONO16;
					default:
						-1;
				}
			case 2:
				switch (wav.header.bitsPerSample)
				{
					case 8:
						AL_FORMAT_STEREO8;
					case 16:
						AL_FORMAT_STEREO16;
					default:
						-1;
				}
			default:
				-1;
		}

		trace('[OpenAL] Filename: ${filename} | Channels: ${wav.header.channels} | Sampling rate: ${wav.header.samplingRate} Hz');

		alBufferData(buffers[0], format, wav.data.getData(), wav.data.length, wav.header.samplingRate);
	}

	function loadOGG(filename:String)
	{
		var vf = vb_open("res/audio/" + filename);

		var ogg = vb_info(vf);
		var oggData = vb_read(vf);

		var format:Int = ogg.channels == 1 ? AL_FORMAT_MONO16 : AL_FORMAT_STEREO16;
		trace('[OpenAL] Filename: ${filename} | Channels: ${ogg.channels} | Sampling rate: ${ogg.samplingRate} Hz');

		var tmp = Bytes.ofData(oggData.data); // Use this, OpenAL doesn't like cpp::VirtualArray
		alBufferData(buffers[0], format, tmp.getData(), oggData.dataLen, ogg.samplingRate);
	}
}

package graphics;

import haxe.io.Bytes;
import haxe.io.BytesData;
import format.wav.Reader;
import sys.io.File;
import lib.openal.AL.*;

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
		alSourcei(sources[0], AL_LOOPING, AL_FALSE);

		alGenBuffers(1, buffers);

		loadWAV(filename);
	}

	public function play()
	{
		alSourcei(sources[0], AL_BUFFER, buffers[0]);
		alSourcePlay(sources[0]);
	}

	function loadWAV(filename:String)
	{
		var file = File.read("res/" + filename, true);
		var wav = new Reader(file).read();

		alBufferData(buffers[0], AL_FORMAT_STEREO16, wav.data.getData(), wav.data.length, wav.header.samplingRate);
	}
}

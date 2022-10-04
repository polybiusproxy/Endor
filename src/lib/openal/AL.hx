package lib.openal;

import cpp.Pointer;
import haxe.io.UInt8Array;
import cpp.UInt8;
import cpp.NativeArray;
import cpp.Star;
import haxe.io.BytesData;
import haxe.io.Bytes;
import cpp.ConstCharStar;

@:keep
@:include("AL/al.h")
@:buildXml("<include name='C:\\Users\\Win32\\Desktop\\Programming\\Haxe\\Endor\\src\\lib\\openal\\al.xml'/>")
extern class AL
{
	static inline var AL_FALSE = 0;
	static inline var AL_TRUE = 1;
	static inline var AL_PITCH = 0x1003;
	static inline var AL_POSITION = 0x1004;
	static inline var AL_VELOCITY = 0x1006;
	static inline var AL_LOOPING = 0x1007;
	static inline var AL_BUFFER = 0x1009;
	static inline var AL_GAIN = 0x100A;
	static inline var AL_ORIENTATION = 0x100F;
	static inline var AL_FORMAT_MONO8 = 0x1100;
	static inline var AL_FORMAT_MONO16 = 0x1101;
	static inline var AL_FORMAT_STEREO8 = 0x1102;
	static inline var AL_FORMAT_STEREO16 = 0x1103;

	@:native("alGetError")
	static function alGetError():Void;

	@:native("alSourcePlay")
	static function alSourcePlay(source:Int):Void;

	@:native("alBufferData")
	static function bufferData(buffer:Int, format:Int, data:Pointer<UInt8>, size:Int, freq:Int):Void;

	static inline function alBufferData(buffer:Int, format:Int, data:BytesData, size:Int, freq:Int):Void
	{
		bufferData(buffer, format, Pointer.arrayElem(data, 0), size, freq);
	}

	@:native("alGenSources")
	static inline function alGenSources(n:Int, sources:Array<Int>):Void
	{
		untyped __cpp__("alGenSources({0}, (ALuint*)&({1}[0]))", n, sources);
	}

	@:native("alGenBuffers")
	static inline function alGenBuffers(n:Int, buffers:Array<Int>):Void
	{
		untyped __cpp__("alGenBuffers({0}, (ALuint*)&({1}[0]))", n, buffers);
	}

	@:native("alListener3f")
	static function alListener3f(param:Int, value1:Float, value2:Float, value3:Float):Void;

	@:native("alListenerfv")
	static function _alListenerfv(param:Int, values:Star<Single>):Void;

	static inline function alListenerfv(param:Int, values:Array<Single>):Void
	{
		_alListenerfv(param, cast NativeArray.address(values, 0));
	}

	@:native("alSourcef")
	static function alSourcef(source:Int, param:Int, value:Float):Void;
	@:native("alSource3f")
	static function alSource3f(param:Int, param:Int, value1:Float, value2:Float, value3:Float):Void;
	@:native("alSourcei")
	static function alSourcei(source:Int, param:Int, value:Int):Void;
}

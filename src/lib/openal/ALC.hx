package lib.openal;

import cpp.ConstCharStar;
import cpp.Pointer;

@:keep
@:native("ALCdevice")
@:include("AL/alc.h")
extern class ALCdevice {}

@:keep
@:native("ALCcontext")
@:include("AL/alc.h")
extern class ALCcontext {}

@:keep
@:include("AL/alc.h")
@:buildXml("<include name='C:\\Users\\Win32\\Desktop\\Programming\\Haxe\\Endor\\src\\lib\\openal\\al.xml'/>")
extern class ALC
{
	static inline var ALC_DEVICE_SPECIFIER = 0x1005;

	@:native("alcOpenDevice")
	static function alcOpenDevice(devicename:ConstCharStar):Pointer<ALCdevice>;

	@:native("alcCreateContext")
	static function alcCreateContext(device:Pointer<ALCdevice>, attrlist:Int):Pointer<ALCcontext>;

	@:native("alcMakeContextCurrent")
	static function alcMakeContextCurrent(context:Pointer<ALCcontext>):Int;

	@:native("alcIsExtensionPresent")
	static function alcIsExtensionPresent(device:Pointer<ALCdevice>, extname:ConstCharStar):Int;

	@:native("alcGetString")
	static function alcGetString(device:Pointer<ALCdevice>, param:Int):ConstCharStar;
}

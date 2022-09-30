package lib.openal;

import cpp.ConstCharStar;
import cpp.Pointer;

@:keep
@:native("ALCdevice")
@:include("AL/alc.h")
extern class ALCdevice {}

@:keep
@:include("AL/alc.h")
@:buildXml("<include name='C:\\Users\\Win32\\Desktop\\Programming\\Haxe\\Endor\\src\\lib\\openal\\al.xml'/>")
extern class ALC
{
	@:native("alcOpenDevice")
	static function alcOpenDevice(devicename:ConstCharStar):Pointer<ALCdevice>;
}

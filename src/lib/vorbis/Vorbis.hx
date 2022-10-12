package lib.vorbis;

import cpp.Pointer;
import haxe.io.BytesData;

typedef Vorbis_Info =
{
	var channels:Int;
	var samplingRate:Int;
}

@:keep
@:native("OggVorbis_File")
@:include("vorbis/vorbisfile.h")
extern class OggVorbis_File {}

@:keep
@:include("endor_vorbis.h")
@:buildXml("<include name='C:\\Users\\Win32\\Desktop\\Programming\\Haxe\\Endor\\src\\lib\\vorbis\\libvorbis.xml'/>")
extern class Vorbis
{
	@:native("endor::vorbis::vb_open")
	static function vb_open(data:BytesData):OggVorbis_File;

	@:native("endor::vorbis::vb_info")
	static function vb_info(vf:OggVorbis_File):Vorbis_Info;
}

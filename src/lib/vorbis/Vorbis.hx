package lib.vorbis;

import haxe.io.BytesData;

typedef Vorbis_Info =
{
	var channels:Int;
	var samplingRate:Int;
}

typedef Vorbis_File =
{
	var data:BytesData;
	var dataLen:Int;
}

@:keep
@:native("OggVorbis_File")
@:unreflective
@:include("vorbis/vorbisfile.h")
extern class OggVorbis_File {}

@:keep
@:include("endor_vorbis.h")
@:buildXml("<include name='C:\\Users\\Win32\\Desktop\\Programming\\Haxe\\Endor\\src\\lib\\vorbis\\libvorbis.xml'/>")
extern class Vorbis
{
	@:native("endor::vorbis::vb_open")
	static function vb_open(filename:String):OggVorbis_File;

	@:native("endor::vorbis::vb_info")
	static function vb_info(vf:OggVorbis_File):Vorbis_Info;

	@:native("endor::vorbis::vb_read")
	static function vb_read(vf:OggVorbis_File):Vorbis_File;
}

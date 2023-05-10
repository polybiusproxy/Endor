package lib.stb;

import haxe.io.BytesData;

typedef ImageData =
{
	var width:Int;
	var height:Int;
	var channels:Int;
	var data:BytesData;
}

@:keep
@:include("endor_stb_image.h")
@:buildXml("<include name='E:\\Users\\Win32\\Desktop\\Programming\\Haxe\\Endor\\src\\lib\\stb\\stb.xml'/>")
extern class Image
{
	@:native("endor::stb_image::load")
	static function load(filename:String, req_comp:Int):ImageData;
}

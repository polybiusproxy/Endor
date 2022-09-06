package glad;

@:keep
@:include("glad/glad.h")
@:buildXml("<include name='C:/Users/Win32/Desktop/Programming/Haxe/Endor/src/glad/glad.xml'/>")
extern class GLAD
{
	static inline var GL_COLOR_BUFFER_BIT = 0x00004000;

	@:native("gladLoadGL")
	static function gladLoadGL():Int;

	@:native("glViewport")
	static function glViewport(x:Int, y:Int, width:Int, height:Int):Void;

	@:native("glClear")
	static function glClear(mask:Int):Void;

	@:native("glClearColor")
	static function glClearColor(red:Float, green:Float, blue:Float, alpha:Float):Void;
}

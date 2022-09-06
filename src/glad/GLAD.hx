package glad;

@:keep
@:include("glad/glad.h")
@:buildXml("<include name='C:/Users/Win32/Desktop/Programming/Haxe/Endor/src/glad/glad.xml'/>")
extern class GLAD
{
	@:native("gladLoadGL")
	static function gladLoadGL():Int;
}

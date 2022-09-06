package glad;

@:keep
@:include("glad/glad.h")
@:buildXml("<include name='C:/Users/Win32/Desktop/Programming/Haxe/Endor/src/glad/glad.xml'/>")
extern class GLAD
{
	static inline var GL_FRAGMENT_SHADER = 0x8B30;
	static inline var GL_VERTEX_SHADER = 0x8B31;
	static inline var GL_COLOR_BUFFER_BIT = 0x00004000;

	@:native("gladLoadGL")
	static function gladLoadGL():Int;

	@:native("glViewport")
	static function glViewport(x:Int, y:Int, width:Int, height:Int):Void;

	@:native("glAttachShader")
	static function glAttachShader(program:Int, shader:Int):Void;

	@:native("glCreateProgram")
	static function glCreateProgram():Int;

	@:native("glCreateShader")
	static function glCreateShader(type:Int):Int;

	@:native("glLinkProgram")
	static function glLinkProgram(program:Int):Void;

	@:native("glUseProgram")
	static function glUseProgram(program:Int):Void;

	@:native("glGetUniformLocation")
	static function glGetUniformLocation(program:Int, name:String):Int;

	@:native("glUniform1i")
	static function glUniform1i(location:Int, v0:Int):Void;

	@:native("glUniform1f")
	static function glUniform1f(location:Int, v0:Float):Void;

	@:native("glShaderSource")
	static function glShaderSource(shader:Int, count:Int, string:String, length:String):Void;

	@:native("glCompileShader")
	static function glCompileShader(shader:Int):Void;

	@:native("glDeleteShader")
	static function glDeleteShader(shader:Int):Void;

	@:native("glClear")
	static function glClear(mask:Int):Void;

	@:native("glClearColor")
	static function glClearColor(red:Float, green:Float, blue:Float, alpha:Float):Void;
}

package glad;

import cpp.ConstCharStar;
import cpp.Star;
import cpp.NativeArray;

@:keep
@:include("glad/glad.h")
@:buildXml("<include name='C:/Users/Win32/Desktop/Programming/Haxe/Endor/src/glad/glad.xml'/>")
extern class GLAD
{
	static inline var GL_FALSE = 0;
	static inline var GL_TRUE = 1;
	static inline var GL_TRIANGLES = 0x0004;
	static inline var GL_FLOAT = 0x1406;
	static inline var GL_DEBUG_OUTPUT_SYNCHRONOUS = 0x8242;
	static inline var GL_ARRAY_BUFFER = 0x8892;
	static inline var GL_STATIC_DRAW = 0x88E4;
	static inline var GL_FRAGMENT_SHADER = 0x8B30;
	static inline var GL_VERTEX_SHADER = 0x8B31;
	static inline var GL_DEBUG_OUTPUT = 0x92E0;
	static inline var GL_COLOR_BUFFER_BIT = 0x00004000;

	@:native("gladLoadGL")
	static function gladLoadGL():Int;

	@:native("glViewport")
	static function glViewport(x:Int, y:Int, width:Int, height:Int):Void;

	@:native("glEnable")
	static function glEnable(cap:Int):Void;

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
	static inline function glShaderSource(shader:Int, count:Int, string:ConstCharStar):Void
	{
		untyped __cpp__("glShaderSource({0}, {1}, &({2}), NULL)", shader, count, string);
	}

	@:native("glCompileShader")
	static function glCompileShader(shader:Int):Void;

	@:native("glDeleteShader")
	static function glDeleteShader(shader:Int):Void;

	@:native("glGenVertexArrays")
	static inline function glGenVertexArrays(n:Int, arrays:Array<Int>):Void
	{
		untyped __cpp__("glGenVertexArrays({0}, (GLuint*)&({1}[0]))", n, arrays);
	}

	@:native("glBindVertexArray")
	static function glBindVertexArray(array:Int):Void;

	@:native("glVertexAttribPointer")
	static function glVertexAttribPointer(index:Int, size:Int, type:Int, normalized:Bool, stride:Int,
		pointer:Int /** Using the integer type because I don't see a proper translation of "const void*" **/):Void;

	@:native("glEnableVertexAttribArray")
	static function glEnableVertexAttribArray(index:Int):Void;

	@:native("glDrawArrays")
	static function glDrawArrays(mode:Int, first:Int, count:Int):Void;

	@:native("glGenBuffers")
	static inline function glGenBuffers(n:Int, buffers:Array<Int>):Void
	{
		untyped __cpp__("glGenBuffers({0}, (GLuint*)&({1}[0]))", n, buffers);
	}

	@:native("glBindBuffer")
	static function glBindBuffer(target:Int, buffer:Int):Void;

	@:native("glBufferData")
	static function bufferData(target:Int, size:Int, data:Star<Float>, usage:Int):Void;

	static inline function glBufferData(target:Int, data:Array<Single>, usage:Int):Void
	{
		bufferData(target, data.length * untyped __cpp__("sizeof(float)"), cast NativeArray.address(data, 0), usage);
	}

	@:native("glClear")
	static function glClear(mask:Int):Void;

	@:native("glClearColor")
	static function glClearColor(red:Float, green:Float, blue:Float, alpha:Float):Void;
}

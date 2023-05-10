package lib.glad;

import glm.Mat4;
import haxe.io.BytesData;
import cpp.ConstCharStar;
import cpp.Star;
import cpp.NativeArray;

@:keep
@:include("glad/glad.h")
@:buildXml("<include name='E:\\Users\\Win32\\Desktop\\Programming\\Haxe\\Endor\\src\\lib\\glad\\glad.xml'/>")
extern class GLAD
{
	static inline var GL_FALSE = 0;
	static inline var GL_TRUE = 1;
	static inline var GL_TRIANGLES = 0x0004;
	inline static var GL_SRC_ALPHA = 0x0302;
	inline static var GL_ONE_MINUS_SRC_ALPHA = 0x0303;
	inline static var GL_BLEND = 0x0BE2;
	static inline var GL_UNPACK_ALIGNMENT = 0x0CF5;
	static inline var GL_TEXTURE_2D = 0x0DE1;
	static inline var GL_UNSIGNED_BYTE = 0x1401;
	static inline var GL_UNSIGNED_INT = 0x1405;
	static inline var GL_FLOAT = 0x1406;
	static inline var GL_RED = 0x1903;
	static inline var GL_RGB = 0x1907;
	static inline var GL_RGBA = 0x1908;
	static inline var GL_VENDOR = 0x1F00;
	static inline var GL_RENDERER = 0x1F01;
	static inline var GL_VERSION = 0x1F02;
	static inline var GL_LINEAR = 0x2601;
	static inline var GL_LINEAR_MIPMAP_LINEAR = 0x2703;
	static inline var GL_TEXTURE_MAG_FILTER = 0x2800;
	static inline var GL_TEXTURE_MIN_FILTER = 0x2801;
	static inline var GL_TEXTURE_WRAP_S = 0x2802;
	static inline var GL_TEXTURE_WRAP_T = 0x2803;
	static inline var GL_REPEAT = 0x2901;
	static inline var GL_CLAMP_TO_EDGE = 0x812F;
	static inline var GL_DEBUG_OUTPUT_SYNCHRONOUS = 0x8242;
	static inline var GL_ARRAY_BUFFER = 0x8892;
	static inline var GL_ELEMENT_ARRAY_BUFFER = 0x8893;
	static inline var GL_STATIC_DRAW = 0x88E4;
	static inline var GL_FRAGMENT_SHADER = 0x8B30;
	static inline var GL_VERTEX_SHADER = 0x8B31;
	static inline var GL_SHADING_LANGUAGE_VERSION = 0x8B8C;
	static inline var GL_DEBUG_OUTPUT = 0x92E0;
	static inline var GL_COLOR_BUFFER_BIT = 0x00004000;

	@:native("gladLoadGL")
	static function gladLoadGL():Int;

	@:native("glViewport")
	static function glViewport(x:Int, y:Int, width:Int, height:Int):Void;

	@:native("glEnable")
	static function glEnable(cap:Int):Void;

	@:native("glPixelStorei")
	static function glPixelStorei(pname:Int, param:Int):Void;

	@:native('glBlendFunc')
	static function glBlendFunc(sfactor:Int, dfactor:Int):Void;

	@:native("glGetString")
	inline static function glGetString(name:Int):String
	{
		return untyped __cpp__("::String((const char*)glGetString({0}))", name);
	}

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

	@:native('glUniform3f')
	static function glUniform3f(location:Int, v0:cpp.Float32, v1:cpp.Float32, v2:cpp.Float32):Void;

	inline static function glUniformMatrix4fv(location:Int, count:Int, transpose:Bool, value:Mat4):Void
	{
		untyped __cpp__("glUniformMatrix4fv({0}, {1}, {2}, (const GLfloat*)&({3}[0]))", location, count, transpose, value.toFloatArray());
	}

	static inline function glShaderSource(shader:Int, count:Int, string:ConstCharStar):Void
	{
		untyped __cpp__("glShaderSource({0}, {1}, &({2}), NULL)", shader, count, string);
	}

	@:native("glCompileShader")
	static function glCompileShader(shader:Int):Void;

	@:native("glDeleteShader")
	static function glDeleteShader(shader:Int):Void;

	static inline function glGenVertexArrays(n:Int, arrays:Int):Void
	{
		untyped __cpp__("glGenVertexArrays({0}, (GLuint*)&({1}))", n, arrays);
	}

	@:native("glBindVertexArray")
	static function glBindVertexArray(array:Int):Void;

	@:native("glVertexAttribPointer")
	static inline function glVertexAttribPointer(index:Int, size:Int, type:Int, normalized:Bool, stride:Int,
			pointer:Int /** Using the integer type because I don't see a proper translation of "const void*" **/):Void
	{
		untyped __cpp__("glVertexAttribPointer({0}, {1}, {2}, {3}, ({4} * sizeof(float)), (void*)(({5} == 0) ? {5} : {5} * sizeof(float)))", index, size,
			type, normalized, stride, pointer);
	}

	@:native("glEnableVertexAttribArray")
	static function glEnableVertexAttribArray(index:Int):Void;

	@:native("glDrawArrays")
	static function glDrawArrays(mode:Int, first:Int, count:Int):Void;

	@:native("glDrawElements")
	static function glDrawElements(mode:Int, count:Int, type:Int, indices:Int /** No pointers here, this isn't used anyways **/):Void;

	static inline function glGenTextures(n:Int, textures:Int):Void
	{
		untyped __cpp__("glGenTextures({0}, (GLuint*)&({1}))", n, textures);
	}

	@:native("glBindTexture")
	static function glBindTexture(target:Int, texture:Int):Void;

	@:native("glActiveTexture")
	static function glActiveTexture(texture:Int):Void;

	static inline function glTexImage2D(target:Int, level:Int, internalFormat:Int, width:Int, height:Int, border:Int, format:Int, type:Int,
			data:BytesData):Void
	{
		untyped __cpp__("glTexImage2D({0}, {1}, {2}, {3}, {4}, {5}, {6}, {7}, (const void*)&({8}[0]))", target, level, internalFormat, width, height, border,
			format, type, data);
	}

	@:native("glGenerateMipmap")
	static function glGenerateMipmap(target:Int):Void;

	@:native("glTexParameteri")
	static function glTexParameteri(target:Int, pname:Int, param:Int):Void;

	static inline function glGenBuffers(n:Int, buffers:Int):Void
	{
		untyped __cpp__("glGenBuffers({0}, (GLuint*)&({1}))", n, buffers);
	}

	@:native("glBindBuffer")
	static function glBindBuffer(target:Int, buffer:Int):Void;

	@:native("glBufferData")
	@:noCompletion
	static function _bufferData(target:Int, size:Int, data:Star<Float>, usage:Int):Void;

	// i love undocumented haxe features, dont you love using features that are barely documented and pray for them to work
	static inline function glBufferData<T>(target:Int, data:Array<T> /** arg must be Array<Single> **/, usage:Int):Void
	{
		_bufferData(target, data.length * untyped __cpp__("sizeof(float)"), cast NativeArray.address(data, 0), usage);
	}

	@:native("glClear")
	static function glClear(mask:Int):Void;

	@:native("glClearColor")
	static function glClearColor(red:Float, green:Float, blue:Float, alpha:Float):Void;
}

package glfw;

import cpp.Pointer;

@:keep
@:native("GLFWwindow")
@:include("glfw3.h")
extern class GLFWwindow {}

@:keep
@:native("GLFWmonitor")
@:include("glfw3.h")
extern class GLFWmonitor {}

@:keep
@:include("glfw3.h")
@:buildXml("<include name='C:/Users/Win32/Desktop/Programming/Haxe/Endor/src/glfw/glfw.xml'/>")
extern class GLFW
{
	static inline var GLFW_TRUE = 1;
	static inline var GLFW_CONTEXT_VERSION_MAJOR = 0x00022002;
	static inline var GLFW_CONTEXT_VERSION_MINOR = 0x00022003;
	static inline var GLFW_OPENGL_PROFILE = 0x00022008;
	static inline var GLFW_OPENGL_CORE_PROFILE = 0x00032001;

	@:native("glfwInit")
	static inline function glfwInit():Int
	{
		forceInclude();
		return untyped __cpp__("glfwInit()");
	}

	@:native("glfwTerminate")
	static function glfwTerminate():Void;

	@:native("glfwWindowHint")
	static function glfwWindowHint(hint:Int, value:Int):Void;

	@:native("glfwCreateWindow")
	static function glfwCreateWindow(width:Int, height:Int, title:String, monitor:Pointer<GLFWmonitor>, share:Pointer<GLFWwindow>):Pointer<GLFWwindow>;

	@:native("glfwMakeContextCurrent")
	static function glfwMakeContextCurrent(window:Pointer<GLFWwindow>):Void;

	@:native("glfwSwapBuffers")
	static function glfwSwapBuffers(window:Pointer<GLFWwindow>):Void;

	@:native("glfwWindowShouldClose")
	static function glfwWindowShouldClose(window:Pointer<GLFWwindow>):Int;

	@:native("glfwPollEvents")
	static function glfwPollEvents():Void;

	@:native("void")
	public static function forceInclude():Void;
}

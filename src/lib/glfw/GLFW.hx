package lib.glfw;

import cpp.ConstCharStar;
import cpp.Star;
import cpp.Function;
import cpp.Pointer;

@:keep
@:native("GLFWwindow")
@:include("glfw3.h")
extern class GLFWwindow {}

@:keep
@:native("GLFWmonitor")
@:include("glfw3.h")
extern class GLFWmonitor {}

typedef GLFWframebuffersizefun = Pointer<GLFWwindow>->Int->Int->Void;

@:keep
class GLFWFramebufferSizeHandler
{
	static var listeners = new Map<String, GLFWframebuffersizefun>();

	static public function nativeCallback(win:Star<GLFWwindow>, width:Int, height:Int)
	{
		var cb = listeners.get('win' + win);

		if (cb != null)
			cb(cast win, width, height);
	}

	public static function setCallback(win:Star<GLFWwindow>, func:GLFWframebuffersizefun)
	{
		listeners.set('win' + win, func);
	}
}

/**
 * Some of the code was taken from linc_glfw (ex. callbacks).
 */
@:keep
@:include("glfw3.h")
@:buildXml("<include name='C:\\Users\\Win32\\Desktop\\Programming\\Haxe\\Endor\\src\\lib\\glfw\\glfw.xml'/>")
extern class GLFW
{
	static inline var GLFW_TRUE = 1;
	static inline var GLFW_FALSE = 0;
	static inline var GLFW_CONTEXT_VERSION_MAJOR = 0x00022002;
	static inline var GLFW_CONTEXT_VERSION_MINOR = 0x00022003;
	static inline var GLFW_OPENGL_DEBUG_CONTEXT = 0x00022007;
	static inline var GLFW_OPENGL_PROFILE = 0x00022008;
	static inline var GLFW_OPENGL_CORE_PROFILE = 0x00032001;

	@:native("glfwInit")
	static inline function glfwInit():Int
	{
		forceInclude();
		return untyped __cpp__("glfwInit()");
	}

	static inline function glfwSetFramebufferSizeCallback(window:Pointer<GLFWwindow>, callback:GLFWframebuffersizefun):Void
	{
		GLFWFramebufferSizeHandler.setCallback(window.ptr, callback);
		untyped __global__.glfwSetFramebufferSizeCallback(window, Function.fromStaticFunction(GLFWFramebufferSizeHandler.nativeCallback));
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

	@:native("glfwSetWindowTitle")
	static function glfwSetWindowTitle(window:Pointer<GLFWwindow>, title:ConstCharStar):Void;

	@:native("glfwPollEvents")
	static function glfwPollEvents():Void;

	@:native("void")
	public static function forceInclude():Void;
}

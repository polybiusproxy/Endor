package engine;

import haxe.PosInfos;
import haxe.Log;
import lib.glfw.GLFW.GLFWwindow;
import lib.glfw.GLFW.*;
import lib.glad.GLAD.*;
import cpp.Pointer;

class Endor
{
	public static var window:Pointer<GLFWwindow>;

	public static function init(resolution:Array<Int>, title:String)
	{
		Log.trace = function(data:Dynamic, ?info:PosInfos)
		{
			Sys.println("[Endor] " + data);
		}

		trace("Initializing...");

		if (glfwInit() != GLFW_TRUE)
		{
			trace("[GLFW] GLFW initialization failed!");
			Sys.exit(-1);
		}

		trace("[GLFW] Initialized!");

		glfwWindowHint(GLFW_CONTEXT_VERSION_MAJOR, 4);
		glfwWindowHint(GLFW_CONTEXT_VERSION_MINOR, 6);
		glfwWindowHint(GLFW_OPENGL_PROFILE, GLFW_OPENGL_CORE_PROFILE);

		window = glfwCreateWindow(resolution[0], resolution[1], title, null, null);

		glfwMakeContextCurrent(window);
		glfwSetFramebufferSizeCallback(window, framebufferSizeCallback);

		if (gladLoadGL() != GLFW_TRUE)
		{
			trace("[OpenGL] OpenGL initialization failed!");
			Sys.exit(-1);
		}

		trace("[OpenGL] Initialized!");
	}

	static function framebufferSizeCallback(window:Pointer<GLFWwindow>, width:Int, height:Int)
	{
		glViewport(0, 0, width, height);
	}
}

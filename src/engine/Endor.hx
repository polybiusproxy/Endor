package engine;

import lib.openal.ALC.ALCcontext;
import lib.openal.ALC.ALCdevice;
import lib.openal.ALC.*;
import lib.openal.AL.*;
import haxe.PosInfos;
import haxe.Log;
import lib.glfw.GLFW.GLFWwindow;
import lib.glfw.GLFW.*;
import lib.glad.GLAD.*;
import cpp.Pointer;

class Endor
{
	public static var window:Pointer<GLFWwindow>;

	static var device:Pointer<ALCdevice>;
	static var context:Pointer<ALCcontext>;

	public static function init(resolution:Array<Int>, title:String)
	{
		Log.trace = function(data:Dynamic, ?info:PosInfos)
		{
			Sys.println("[Endor] " + data);
		}

		trace("Initializing...");

		if (glfwInit() != GLFW_TRUE)
		{
			trace("[GLFW] Initialization failed!");
			Sys.exit(-1);
		}

		trace("[GLFW] Initialized!");

		glfwWindowHint(GLFW_CONTEXT_VERSION_MAJOR, 4);
		glfwWindowHint(GLFW_CONTEXT_VERSION_MINOR, 6);
		glfwWindowHint(GLFW_OPENGL_PROFILE, GLFW_OPENGL_CORE_PROFILE);

		window = glfwCreateWindow(resolution[0], resolution[1], title, null, null);

		glfwMakeContextCurrent(window);
		glfwSetFramebufferSizeCallback(window, framebufferSizeCallback);

		device = alcOpenDevice(null);
		if (device == null)
		{
			trace("[OpenAL] Unable to open default device!");
			Sys.exit(-1);
		}

		trace("[OpenAL] Device: " + alcGetString(device, ALC_DEVICE_SPECIFIER));

		context = alcCreateContext(device, 0);
		alcMakeContextCurrent(context);

		if (gladLoadGL() != GLFW_TRUE)
		{
			trace("[OpenGL] Initialization failed!");
			Sys.exit(-1);
		}

		trace("[OpenGL] Initialized!\n");

		trace("[OpenGL] Vendor: " + glGetString(GL_VENDOR));
		trace("[OpenGL] Rendering Device: " + glGetString(GL_RENDERER));
		trace("[OpenGL] Version: " + glGetString(GL_VERSION));
		trace("[OpenGL] GLSL Version: " + glGetString(GL_SHADING_LANGUAGE_VERSION) + "\n");
	}

	static function framebufferSizeCallback(window:Pointer<GLFWwindow>, width:Int, height:Int)
	{
		glViewport(0, 0, width, height);
	}
}

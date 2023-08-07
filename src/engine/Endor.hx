package engine;

#if HXCPP_TELEMETRY
import hxtelemetry.HxTelemetry;
#end

import render.Shader;
import render.Model;
import lib.openal.ALC.ALCcontext;
import lib.openal.ALC.ALCdevice;
import lib.openal.ALC.*;
import haxe.PosInfos;
import haxe.Log;
import lib.glfw.GLFW.GLFWwindow;
import lib.glfw.GLFW.*;
import lib.glad.GLAD.*;
import cpp.Pointer;

class Endor
{
	public static var models:Array<Model> = [];
	public static var shaders:Array<Shader> = [];

	public static var window:Pointer<GLFWwindow>;

	static var device:Pointer<ALCdevice>;
	static var context:Pointer<ALCcontext>;

	#if HXCPP_TELEMETRY
	static var hxtConfig:Config;
	static var hxt:hxtelemetry.HxTelemetry;
	#end

	public static function init(resolution:Array<Int>, title:String)
	{
		#if HXCPP_TELEMETRY
		/* init telemetry */
		hxtConfig = new Config();
		hxtConfig.app_name = "Endor";

		hxt = new hxtelemetry.HxTelemetry(hxtConfig);
		#end

		Log.trace = function(data:Dynamic, ?info:PosInfos)
		{
			Sys.println("[endor] " + data);
		}

		trace("[engine] Initializing...");

		if (glfwInit() != GLFW_TRUE)
		{
			trace("[glfw] Initialization failed!");
			Sys.exit(-1);
		}

		trace("[glfw] Initialized!");

		glfwWindowHint(GLFW_CONTEXT_VERSION_MAJOR, 4);
		glfwWindowHint(GLFW_CONTEXT_VERSION_MINOR, 6);
		glfwWindowHint(GLFW_OPENGL_PROFILE, GLFW_OPENGL_CORE_PROFILE);

		window = glfwCreateWindow(resolution[0], resolution[1], title, null, null);

		glfwMakeContextCurrent(window);
		glfwSetFramebufferSizeCallback(window, framebufferSizeCallback);

		device = alcOpenDevice(null);
		if (device == null)
		{
			trace("[openal] Unable to open default device!");
			Sys.exit(-1);
		}

		trace("[openal] Device: " + alcGetString(device, ALC_DEFAULT_ALL_DEVICES_SPECIFIER));

		context = alcCreateContext(device, 0);
		alcMakeContextCurrent(context);

		if (gladLoadGL() != GLFW_TRUE)
		{
			trace("[opengl] Initialization failed!");
			Sys.exit(-1);
		}

		trace("[opengl] Initialized!");

		trace("[opengl] --------------- INFO ---------------");
		trace("[opengl] Vendor:             " + glGetString(GL_VENDOR));
		trace("[opengl] Rendering Device:   " + glGetString(GL_RENDERER));
		trace("[opengl] Version:            " + glGetString(GL_VERSION));
		trace("[opengl] GLSL Version:       " + glGetString(GL_SHADING_LANGUAGE_VERSION));
		trace("[opengl] ------------------------------------");
	}

	static function framebufferSizeCallback(window:Pointer<GLFWwindow>, width:Int, height:Int)
	{
		glViewport(0, 0, width, height);
	}

	#if HXCPP_TELEMETRY		
	public static function advanceFrame()
	{
		hxt.advance_frame();
	}
	#end
}

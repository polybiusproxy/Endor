import cpp.Pointer;
import glfw.GLFW.*;
import glfw.GLFW.GLFWwindow;

class Main
{
	static var window:Pointer<GLFWwindow>;

	static function main()
	{
		if (glfwInit() != GLFW_TRUE)
			Sys.println("[Endor] [GLFW] GLFW initialization failed!"); // Haxe's trace() function is messy and slow, do NOT use it!

		window = glfwCreateWindow(1280, 720, "Endor", null, null);
		glfwMakeContextCurrent(window);

		while (glfwWindowShouldClose(window) != GLFW_TRUE)
		{
			glfwSwapBuffers(window);
			glfwPollEvents();
		}
	}
}

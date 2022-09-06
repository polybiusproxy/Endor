import cpp.Pointer;
import glad.GLAD.*;
import glfw.GLFW.*;
import glfw.GLFW.GLFWwindow;

class Main
{
	static var window:Pointer<GLFWwindow>;

	static function main()
	{
		if (glfwInit() != GLFW_TRUE)
			Sys.println("[Endor] [GLFW] GLFW initialization failed!"); // Haxe's trace() function is slow, do NOT use it!

		glfwWindowHint(GLFW_CONTEXT_VERSION_MAJOR, 4);
		glfwWindowHint(GLFW_CONTEXT_VERSION_MINOR, 6);
		glfwWindowHint(GLFW_OPENGL_PROFILE, GLFW_OPENGL_CORE_PROFILE);

		window = glfwCreateWindow(1280, 720, "Endor", null, null);
		glfwMakeContextCurrent(window);

		if (gladLoadGL() != GLFW_TRUE)
			Sys.println("[Endor] [OpenGL] OpenGL initialization failed!");

		glViewport(0, 0, 1280, 720);

		while (glfwWindowShouldClose(window) != GLFW_TRUE)
		{
			glClearColor(0.07, 0.13, 0.17, 1);
			glClear(GL_COLOR_BUFFER_BIT);

			glfwSwapBuffers(window);
			glfwPollEvents();
		}
	}
}

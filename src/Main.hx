import render.Shader;
import cpp.Pointer;
import glad.GLAD.*;
import glfw.GLFW.*;
import glfw.GLFW.GLFWwindow;
import haxe.Log;
import haxe.PosInfos;

class Main
{
	static var window:Pointer<GLFWwindow>;

	static function main()
	{
		Log.trace = function(data:Dynamic, ?info:PosInfos)
		{
			Sys.println("[Endor] " + data);
		}

		if (glfwInit() != GLFW_TRUE)
		{
			trace("[GLFW] GLFW initialization failed!");
			Sys.exit(-1);
		}

		glfwWindowHint(GLFW_CONTEXT_VERSION_MAJOR, 4);
		glfwWindowHint(GLFW_CONTEXT_VERSION_MINOR, 6);
		glfwWindowHint(GLFW_OPENGL_PROFILE, GLFW_OPENGL_CORE_PROFILE);

		window = glfwCreateWindow(1280, 720, "Endor", null, null);
		glfwMakeContextCurrent(window);

		if (gladLoadGL() != GLFW_TRUE)
		{
			trace("[OpenGL] OpenGL initialization failed!");
			Sys.exit(-1);
		}

		glViewport(0, 0, 1280, 720);

		var vertices:Array<Single> = [
			-0.5, -0.5, 0.0,
			 0.5, -0.5, 0.0,
			 0.0,  0.5, 0.0
		];

		var VBO:Array<Int> = [];
		var VAO:Array<Int> = [];

		glGenBuffers(1, VBO);
		glGenVertexArrays(1, VAO);

		glBindVertexArray(VAO[0]);

		glBindBuffer(GL_ARRAY_BUFFER, VBO[0]);
		glBufferData(GL_ARRAY_BUFFER, vertices, GL_STATIC_DRAW);

		glVertexAttribPointer(0, 3, GL_FLOAT, false, untyped __cpp__("3 * sizeof(float)"), 0);
		glEnableVertexAttribArray(0);

		var shader:Shader = new Shader("vert", "frag");

		while (glfwWindowShouldClose(window) != GLFW_TRUE)
		{
			glClearColor(0.07, 0.13, 0.17, 1);
			glClear(GL_COLOR_BUFFER_BIT);

			shader.use();

			glBindVertexArray(VAO[0]);
			glDrawArrays(GL_TRIANGLES, 0, 3);

			glfwSwapBuffers(window);
			glfwPollEvents();
		}
	}
}

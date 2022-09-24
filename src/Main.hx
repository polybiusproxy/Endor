import engine.Endor;
import render.Shader;
import lib.glad.GLAD.*;
import lib.glfw.GLFW.*;

class Main
{
	static function main()
	{
		Endor.init([1280, 720], "Endor");

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
		glBufferData(GL_ARRAY_BUFFER, cast vertices, GL_STATIC_DRAW);

		glVertexAttribPointer(0, 3, GL_FLOAT, false, untyped __cpp__("3 * sizeof(float)"), 0);
		glEnableVertexAttribArray(0);

		var triangleShader:Shader = new Shader();

		while (glfwWindowShouldClose(Endor.window) != GLFW_TRUE)
		{
			glClearColor(0.07, 0.13, 0.17, 1);
			glClear(GL_COLOR_BUFFER_BIT);

			triangleShader.use();

			glBindVertexArray(VAO[0]);
			glDrawArrays(GL_TRIANGLES, 0, 3);

			glfwSwapBuffers(Endor.window);
			glfwPollEvents();
		}
	}
}

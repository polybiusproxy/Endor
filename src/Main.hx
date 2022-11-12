import render.Model;
import graphics.Sound;
import engine.Endor;
import render.Shader;
import lib.glad.GLAD.*;
import lib.glfw.GLFW.*;

class Main
{
	static function main()
	{
		Endor.init([1280, 720], "Endor");

		var vertices:Array<Float> = [
			 0.5,  0.5, 0.0,
			 0.5, -0.5, 0.0,
			-0.5, -0.5, 0.0,
			-0.5,  0.5, 0.0
		];

		var indices:Array<Int> = [
			0, 1, 3,
			1, 2, 3
		];

		var rectangle = new Model(vertices, indices);
		var rectangleShader:Shader = new Shader();

		var music:Sound = new Sound("studiopolis.ogg");
		music.play();

		while (glfwWindowShouldClose(Endor.window) != GLFW_TRUE)
		{
			glClearColor(0.07, 0.13, 0.17, 1);
			glClear(GL_COLOR_BUFFER_BIT);

			rectangleShader.use();

			for (model in Endor.models)
			{
				model.render();
			}

			glfwSwapBuffers(Endor.window);
			glfwPollEvents();
		}
	}
}

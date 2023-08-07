import graphics.Texture;
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

		var colors:Array<Float> = [
			1.0, 0.0, 0.0,
			0.0, 1.0, 0.0,
			0.0, 0.0, 1.0,
			1.0, 1.0, 1.0,
		];

		var texCoords:Array<Float> = [
			1.0, 1.0,
			1.0, 0.0,
			0.0, 0.0,
			0.0, 1.0
		];

		var rectangleShader:Shader = new Shader();

		var rectangle = new Model(vertices, indices, colors, texCoords, rectangleShader);
		var rectangleTexture:Texture = new Texture(rectangle, "tro.png");

		var music:Sound = new Sound("09.ogg");
		music.play();

		while (glfwWindowShouldClose(Endor.window) != GLFW_TRUE)
		{
			glClearColor(0.07, 0.13, 0.17, 1);
			glClear(GL_COLOR_BUFFER_BIT);

			for (shader in Endor.shaders)
			{
				shader.use();
			}

			for (model in Endor.models)
			{
				model.render();
			}

			glfwSwapBuffers(Endor.window);
			glfwPollEvents();

			#if HXCPP_TELEMETRY
			Endor.advanceFrame();
			#end
		}
	}
}

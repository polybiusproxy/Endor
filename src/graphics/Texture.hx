package graphics;

import lib.glad.GLAD.*;
import render.Model;
import lib.stb.Image;

class Texture
{
	public var ID:Array<Int> = [];

	public function new(model:Model, filename:String, req_comp:Int = 0)
	{
		var image = Image.load("res/" + filename, req_comp);

		glGenTextures(1, ID);
		glBindTexture(GL_TEXTURE_2D, ID[0]);
		glTexImage2D(GL_TEXTURE_2D, 0, /** TODO: Add GL_RGB **/ 0, image.width, image.height, 0, /** TODO: Add GL_RGB **/
			0, /** TODO: Add GL_UNSIGNED_BYTE **/ 0, image.data);

	}
}

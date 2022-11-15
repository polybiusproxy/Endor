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

		glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_WRAP_S, GL_REPEAT);
		glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_WRAP_T, GL_REPEAT);

		glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_MIN_FILTER, GL_LINEAR_MIPMAP_LINEAR);
		glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_MAG_FILTER, GL_LINEAR);

		glTexImage2D(GL_TEXTURE_2D, 0, GL_RGB, image.width, image.height, 0, GL_RGB, GL_UNSIGNED_BYTE, image.data);
		glGenerateMipmap(GL_TEXTURE_2D);

		model.textures.push(this);
	}
}

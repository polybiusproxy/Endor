package graphics;

import render.Model;
import render.Shader;
import lib.glad.GLAD.*;
import lib.stb.Image;

class Texture
{
	public var ID:Int = 0;

	public function new(model:Model, filename:String, req_comp:Int = 0)
	{
		var image = Image.load("res/images/" + filename, req_comp);

		glGenTextures(1, ID);
		glBindTexture(GL_TEXTURE_2D, ID);

		glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_WRAP_S, GL_REPEAT);
		glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_WRAP_T, GL_REPEAT);

		glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_MIN_FILTER, GL_LINEAR_MIPMAP_LINEAR);
		glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_MAG_FILTER, GL_LINEAR);

		glTexImage2D(GL_TEXTURE_2D, 0, GL_RGBA, image.width, image.height, 0, GL_RGBA, GL_UNSIGNED_BYTE, image.data);
		glGenerateMipmap(GL_TEXTURE_2D);

		model.setTexture(this);
	}
}

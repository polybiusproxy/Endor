package render;

import graphics.Texture;
import engine.Endor;
import render.Shader;
import lib.glad.GLAD.*;

class Model
{
	public var vaoID:Int;
	public var vertexCount:Int;

	public var hasIndices:Bool;

	public var VBOs:Array<Int> = [];
	public var VAOs:Array<Int> = [];
	public var EBOs:Array<Int> = [];

	public var textures:Array<Texture> = [];

	public var shader:Shader;

	public function new(vertices:Array<Float>, ?indices:Array<Int>, ?colors:Array<Float>, ?texCoords:Array<Float>, shader:Shader)
	{
		if (indices != null)
			hasIndices = true;

		if (hasIndices)
			vertexCount = indices.length;
		else
			vertexCount = Std.int(vertices.length / 3);

		this.shader = shader;

		var VAO:Int = 0;
		glGenVertexArrays(1, VAO);
		glBindVertexArray(VAO);
		VAOs.push(VAO);

		var vertexVBO:Int = 0;
		glGenBuffers(1, vertexVBO);
		VBOs.push(vertexVBO);

		glBindBuffer(GL_ARRAY_BUFFER, vertexVBO);
		glBufferData(GL_ARRAY_BUFFER, vertices, GL_STATIC_DRAW);

		// position attribute
		glVertexAttribPointer(0, 3, GL_FLOAT, false, 3, 0);
		glEnableVertexAttribArray(0);
		glBindBuffer(GL_ARRAY_BUFFER, 0);

		var indexEBO:Int = 0;

		if (hasIndices)
		{
			// Indices EBO
			glGenBuffers(1, indexEBO);
			EBOs.push(indexEBO);

			glBindBuffer(GL_ELEMENT_ARRAY_BUFFER, indexEBO);
			glBufferData_int(GL_ELEMENT_ARRAY_BUFFER, indices, GL_STATIC_DRAW);
		}

		var colorVBO:Int = 0;
		glGenBuffers(1, colorVBO);
		VBOs.push(colorVBO);

		if (colors != null)
		{
			glBindBuffer(GL_ARRAY_BUFFER, colorVBO);
			glBufferData(GL_ARRAY_BUFFER, colors, GL_STATIC_DRAW);

			glVertexAttribPointer(1, 3, GL_FLOAT, false, 3, 0);
			glEnableVertexAttribArray(1);
			glBindBuffer(GL_ARRAY_BUFFER, 0);
		}

		var texCoordVBO:Int = 0;
		glGenBuffers(1, texCoordVBO);
		VBOs.push(texCoordVBO);

		if (texCoords != null)
		{
			glBindBuffer(GL_ARRAY_BUFFER, texCoordVBO);
			glBufferData(GL_ARRAY_BUFFER, texCoords, GL_STATIC_DRAW);

			glVertexAttribPointer(2, 2, GL_FLOAT, false, 2, 0);
			glEnableVertexAttribArray(2);
			glBindBuffer(GL_ARRAY_BUFFER, 0);
		}

		glBindVertexArray(0);

		Endor.models.push(this);
	}

	public function setTexture(texture:Texture) 
	{
    	shader.setInt("tex", texture.ID);
		textures.push(texture);
	}

	public function render()
	{
		for (VAO in VAOs)
		{
			glBindVertexArray(VAO);
		}

		for (texture in textures)
		{
			glBindTexture(GL_TEXTURE_2D, texture.ID);
		}

		if (hasIndices)
		{
			glDrawElements(GL_TRIANGLES, vertexCount, GL_UNSIGNED_INT, 0);
		}
		else
			glDrawArrays(GL_TRIANGLES, 0, vertexCount);
	}
}

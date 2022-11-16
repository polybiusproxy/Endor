package render;

import graphics.Texture;
import engine.Endor;
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

	public function new(vertices:Array<Float>, ?indices:Array<Int>, ?colors:Array<Float>, ?texCoords:Array<Float>)
	{
		if (indices != null)
			hasIndices = true;

		if (hasIndices)
			vertexCount = indices.length;
		else
			vertexCount = Std.int(vertices.length / 3);

		var VAO:Int = 0;

		glGenVertexArrays(1, VAO);
		glBindVertexArray(VAO);
		VAOs.push(VAO);

		var vertexVBO:Int = 0;
		var colorVBO:Int = 0;
		var texCoordVBO:Int = 0;

		var indexEBO:Int = 0;

		glGenBuffers(1, vertexVBO);
		glGenBuffers(1, colorVBO);
		glGenBuffers(1, texCoordVBO);

		VBOs.push(vertexVBO);
		VBOs.push(colorVBO);
		VBOs.push(texCoordVBO);

		glBindBuffer(GL_ARRAY_BUFFER, vertexVBO);
		glBufferData(GL_ARRAY_BUFFER, cast vertices, GL_STATIC_DRAW);

		glVertexAttribPointer(0, 3, GL_FLOAT, false, 0, 0);
		glEnableVertexAttribArray(0);
		glBindBuffer(GL_ARRAY_BUFFER, 0);

		if (hasIndices)
		{
			glGenBuffers(1, indexEBO);
			EBOs.push(indexEBO);

			glBindBuffer(GL_ELEMENT_ARRAY_BUFFER, indexEBO);
			glBufferData_int(GL_ELEMENT_ARRAY_BUFFER, indices, GL_STATIC_DRAW);
		}

		if (colors != null)
		{
			glBindBuffer(GL_ARRAY_BUFFER, colorVBO);
			glBufferData(GL_ARRAY_BUFFER, cast colors, GL_STATIC_DRAW);

			glVertexAttribPointer(1, 3, GL_FLOAT, false, 0, 0);
			glEnableVertexAttribArray(1);
			glBindBuffer(GL_ARRAY_BUFFER, 0);
		}

		if (texCoords != null)
		{
			glBindBuffer(GL_ARRAY_BUFFER, texCoordVBO);
			glBufferData(GL_ARRAY_BUFFER, cast texCoords, GL_STATIC_DRAW);

			glVertexAttribPointer(2, 2, GL_FLOAT, false, 0, 0);
			glEnableVertexAttribArray(2);
			glBindBuffer(GL_ARRAY_BUFFER, 0);
		}

		glBindVertexArray(0);

		Endor.models.push(this);
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

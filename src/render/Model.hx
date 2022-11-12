package render;

import engine.Endor;
import lib.glad.GLAD.*;

class Model
{
	public var vaoID:Int;
	public var vertexCount:Int;

	public var hasIndices:Bool;

	public var VBO:Array<Int> = [];
	public var VAO:Array<Int> = [];
	public var EBO:Array<Int> = [];

	public function new(vertices:Array<Float>, ?indices:Array<Int>)
	{
		if (indices != null)
			hasIndices = true;

		if (hasIndices)
			vertexCount = indices.length;
		else
			vertexCount = Std.int(vertices.length / 3);

		glGenBuffers(2, VBO);
		glGenVertexArrays(1, VAO);

		glBindVertexArray(VAO[0]);

		glBindBuffer(GL_ARRAY_BUFFER, VBO[0]);
		glBufferData(GL_ARRAY_BUFFER, cast vertices, GL_STATIC_DRAW);

		if (hasIndices)
		{
			glGenBuffers(1, EBO);

			glBindBuffer(GL_ELEMENT_ARRAY_BUFFER, EBO[0]);
			glBufferData_int(GL_ELEMENT_ARRAY_BUFFER, indices, GL_STATIC_DRAW);
		}

		glVertexAttribPointer(0, 3, GL_FLOAT, false, 6, 0);
		glEnableVertexAttribArray(0);

		glVertexAttribPointer(1, 3, GL_FLOAT, false, 6, 3);
		glEnableVertexAttribArray(1);

		glBindBuffer(GL_ARRAY_BUFFER, 0);
		glBindVertexArray(0);

		Endor.models.push(this);
	}

	public function render()
	{
		glBindVertexArray(VAO[0]);

		if (hasIndices)
		{
			glDrawElements(GL_TRIANGLES, vertexCount, GL_UNSIGNED_INT, 0);
		}
		else
			glDrawArrays(GL_TRIANGLES, 0, vertexCount);
	}
}
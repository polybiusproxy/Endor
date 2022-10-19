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

	public function new(vertices:Array<Float>, ?indices:Array<Int>)
	{
		if (indices != null)
			hasIndices = true;

		if (hasIndices)
			vertexCount = indices.length;
		else
			vertexCount = Std.int(vertices.length / 3);

		glGenBuffers(1, VBO);
		glGenVertexArrays(1, VAO);

		glBindVertexArray(VAO[0]);

		glBindBuffer(GL_ELEMENT_ARRAY_BUFFER, VBO[0]);
		glBufferData(GL_ELEMENT_ARRAY_BUFFER, cast indices, GL_STATIC_DRAW);

		glBindBuffer(GL_ARRAY_BUFFER, VBO[0]);
		glBufferData(GL_ARRAY_BUFFER, cast vertices, GL_STATIC_DRAW);

		glVertexAttribPointer(0, 3, GL_FLOAT, false, untyped __cpp__("3 * sizeof(float)"), 0);
		glEnableVertexAttribArray(0);

		Endor.models.push(this);
	}

	public function render()
	{
		glBindVertexArray(VAO[0]);

		if (hasIndices)
			glDrawElements(GL_TRIANGLES, vertexCount, GL_UNSIGNED_INT, 0);
		else
			glDrawArrays(GL_TRIANGLES, 0, vertexCount);
	}
}

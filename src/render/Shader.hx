package render;

import glad.GLAD.*;
import sys.io.File;

class Shader
{
	public var ID:Int;

	var vertex:Int;
	var fragment:Int;

	public function new(vertexPath:String, fragmentPath:String)
	{
		var vertexShader:String;
		var fragmentShader:String;

		try
		{
			vertexShader = File.getContent(vertexPath + '.vs');
			fragmentShader = File.getContent(vertexPath + '.fs');
		}
		catch (err)
		{
			Sys.println("[Endor] Couldn't load shader files!");
		}

		vertex = glCreateShader(GL_VERTEX_SHADER);
		glShaderSource(vertex, 1, vertexShader, null);
		glCompileShader(vertex);
		checkErrors(vertex, "VERTEX");

		fragment = glCreateShader(GL_FRAGMENT_SHADER);
		glShaderSource(fragment, 1, fragmentShader, null);
		glCompileShader(fragment);
		checkErrors(fragment, "FRAGMENT");

		ID = glCreateProgram();
		glAttachShader(ID, vertex);
		glAttachShader(ID, fragment);
		glLinkProgram(ID);
		checkErrors(ID, "PROGRAM");

		glDeleteShader(vertex);
		glDeleteShader(fragment);
	}

	function use()
	{
		glUseProgram(ID);
	}

	function setBool(name:String, value:Bool)
	{
		glUniform1i(glGetUniformLocation(ID, name), cast value);
	}

	function setInt(name:String, value:Int)
	{
		glUniform1i(glGetUniformLocation(ID, name), value);
	}

	function setFloat(name:String, value:Float)
	{
		glUniform1f(glGetUniformLocation(ID, name), value);
	}

	@:functionCode('
        int success;
        char infoLog[1024];

        if (type != "PROGRAM")
        {
            glGetShaderiv(shader, GL_COMPILE_STATUS, &success);

            if (!success)
            {
                glGetShaderInfoLog(shader, 1024, NULL, infoLog);
                std::cout << "[Endor] [OpenGL] [Shader] Compile error of type: " << type << "\n" << infoLog << "\n -- --------------------------------------------------- -- " << std::endl;
            }
        }
        else
        {
            glGetProgramiv(shader, GL_LINK_STATUS, &success);

            if (!success)
            {
                glGetProgramInfoLog(shader, 1024, NULL, infoLog);
                std::cout << "[Endor] [OpenGL] [Shader] Link error of type: " << type << "\n" << infoLog << "\n -- --------------------------------------------------- -- " << std::endl;
            }
        }
    ')
	private function checkErrors(shader:Int, type:String) {}
}

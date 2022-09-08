package render;

import cpp.ConstCharStar;
import glad.GLAD.*;
import sys.io.File;

@:headerInclude("iostream")
class Shader
{
	public var ID:Int;

	var vertex:Int;
	var fragment:Int;

	public function new(vertexPath:String, fragmentPath:String)
	{
		var vertexShader:String = "";
		var fragmentShader:String = "";

		try
		{
			vertexShader = File.getContent(vertexPath + '.vs');
			fragmentShader = File.getContent(fragmentPath + '.fs');
		}
		catch (err)
		{
			trace("[Endor] Couldn't load shader files!");
		}

		trace("[OpenGL] Compiling shaders...");

		vertex = glCreateShader(GL_VERTEX_SHADER);
		glShaderSource(vertex, 1, vertexShader);
		glCompileShader(vertex);
		checkErrors(vertex, "VERTEX");

		fragment = glCreateShader(GL_FRAGMENT_SHADER);
		glShaderSource(fragment, 1, fragmentShader);
		glCompileShader(fragment);
		checkErrors(fragment, "FRAGMENT");

		trace("[OpenGL] Compiling programs...");

		ID = glCreateProgram();
		glAttachShader(ID, vertex);
		glAttachShader(ID, fragment);
		glLinkProgram(ID);
		checkErrors(ID, "PROGRAM");

		glDeleteShader(vertex);
		glDeleteShader(fragment);
	}

	public function use()
	{
		glUseProgram(ID);
	}

	public function setBool(name:String, value:Bool)
	{
		glUniform1i(glGetUniformLocation(ID, name), cast value);
	}

	public function setInt(name:String, value:Int)
	{
		glUniform1i(glGetUniformLocation(ID, name), value);
	}

	public function setFloat(name:String, value:Float)
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
                std::cout << "[Endor] [OpenGL] Compile error of type: " << type << std::endl << infoLog << std::endl << " -- --------------------------------------------------- -- " << std::endl;
            }
        }
        else
        {
            glGetProgramiv(shader, GL_LINK_STATUS, &success);

            if (!success)
            {
                glGetProgramInfoLog(shader, 1024, NULL, infoLog);
                std::cout << "[Endor] [OpenGL] Link error of type: " << type << std::endl << infoLog << std::endl << " -- --------------------------------------------------- -- " << std::endl;
            }
        }
    ')
	private function checkErrors(shader:Int, type:ConstCharStar) {}
}
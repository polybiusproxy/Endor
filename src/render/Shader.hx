package render;

import glm.Vec3;
import glm.Mat4;
import engine.Endor;
import cpp.ConstCharStar;
import lib.glad.GLAD.*;
import sys.io.File;

@:headerInclude("iostream")
class Shader
{
	public var ID:Int;

	var vertex:Int;
	var fragment:Int;

	var defaultVert = "#version 460 core
	layout (location = 0) in vec3 aPos;
	layout (location = 1) in vec3 aColor;
	layout (location = 2) in vec2 aTexCoord;

	out vec3 color;
	out vec2 texCoord;
	
	void main()
	{
		color = aColor;
		texCoord = aTexCoord;
		gl_Position = vec4(aPos, 1.0);
	}";

	var defaultFrag = "#version 460 core
	out vec4 fragColor;

	in vec3 color;
	in vec2 texCoord;

	uniform sampler2D tex;
	
	void main()
	{
		fragColor = texture(tex, texCoord) * vec4(color, 1.0);
	}";

	public function new(?vertexPath:String, ?fragmentPath:String, ?file:Bool = true)
	{
		var vertexShader:String = "";
		var fragmentShader:String = "";

		if (vertexPath != null && fragmentPath != null)
		{
			if (file)
			{
				try
				{
					vertexShader = File.getContent(vertexPath + '.vs');
					fragmentShader = File.getContent(fragmentPath + '.fs');
				}
				catch (err)
				{
					trace("[Endor] Couldn't load shader files!");
				}
			}
			else
			{
				vertexShader = vertexPath;
				fragmentShader = fragmentPath;
			}
		}
		else
		{
			vertexShader = defaultVert;
			fragmentShader = defaultFrag;
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

		Endor.shaders.push(this);

		glDeleteShader(vertex);
		glDeleteShader(fragment);
	}

	public function use()
	{
		glUseProgram(ID);
	}

	public function setBool(name:String, value:Bool)
	{
		glUseProgram(ID);
		glUniform1i(glGetUniformLocation(ID, name), cast value);
	}

	public function setInt(name:String, value:Int)
	{
		glUseProgram(ID);
		glUniform1i(glGetUniformLocation(ID, name), value);
	}

	public function setFloat(name:String, value:Float)
	{
		glUseProgram(ID);
		glUniform1f(glGetUniformLocation(ID, name), value);
	}

	public function setVec3(name:String, value:Vec3)
	{
		glUseProgram(ID);
		glUniform3f(glGetUniformLocation(ID, name), value.x, value.y, value.z);
	}

	public function setMat4(name:String, value:Mat4)
	{
		glUseProgram(ID);
		glUniformMatrix4fv(glGetUniformLocation(ID, name), 1, false, value);
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

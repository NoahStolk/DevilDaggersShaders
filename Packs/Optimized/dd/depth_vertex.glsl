// depth
#version 330
in      vec3 in_position;
uniform mat4 world_matrix;
uniform mat4 view_proj_matrix;

void main()
{
	gl_Position = view_proj_matrix * (world_matrix * vec4(in_position, 1.0));
}
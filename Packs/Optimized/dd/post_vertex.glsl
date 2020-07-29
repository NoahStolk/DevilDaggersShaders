// post
#version 330
in      vec3 in_position;
in      vec2 in_uv0;
uniform mat4 view_proj_matrix;
out     vec2 vert_uv0;
out     vec2 vert_view_pos;
out     vec3 vert_view_dir;

void main()
{
	vert_uv0 = in_uv0;
	vert_view_dir = view_proj_matrix[2].xyz;
	vert_view_pos = in_position.xy;
	gl_Position = vec4(in_position, 1.0);
}
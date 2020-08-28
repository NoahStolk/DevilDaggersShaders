// post_title
#version 330
in      vec3 in_position;
in      vec2 in_uv0;
out     vec2 vert_uv0;

void main()
{
	vert_uv0 = in_uv0;
	gl_Position = vec4(in_position, 1.0);
}
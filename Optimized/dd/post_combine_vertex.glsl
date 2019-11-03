// post_combine
#version 330
in      vec3 in_position;
in      vec2 in_uv0;
out     vec2 vert_uv0;
out     vec2 vert_view_pos;

void main()
{
	vert_uv0 = in_uv0;
	vert_view_pos = in_position.xy;
	gl_Position = vec4(in_position, 1.0);
}
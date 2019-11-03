// test
#version 330
in      vec2 vert_uv0;
out     vec4 out_colour0;

void main()
{
	out_colour0 = vec4(vert_uv0, 1.0, 1.0);
}
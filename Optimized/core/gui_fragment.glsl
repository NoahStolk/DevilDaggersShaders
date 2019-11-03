// gui
#version 330
uniform sampler2D tex_diffuse;
in      vec2 vert_uv0;
in      vec4 vert_colour;
out     vec4 out_colour0;

void main()
{
	vec4 result0 = texture(tex_diffuse, vert_uv0.xy);
	out_colour0 = result0 * vert_colour;
}
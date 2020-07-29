// post_final
#version 330
uniform sampler2D tex_diffuse;
in      vec2 vert_uv0;
out     vec4 out_colour0;

void main()
{
	out_colour0 = texture(tex_diffuse, vert_uv0);
}
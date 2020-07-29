// guifont
#version 330
uniform sampler2D tex_diffuse;
uniform sampler2D tex_diffuse2;
in      vec2 vert_uv0;
in      vec2 vert_uv1;
in      vec4 vert_colour;
out     vec4 out_colour0;

void main()
{
	vec4 result0 = texture(tex_diffuse, vert_uv0.xy);
	vec3 gradient = texture(tex_diffuse2, -vert_uv1 * 0.062 + vec2(0.0, 0.17)).rgb;
	result0.rgb *= vert_uv1.y > 100.0 ? vec3(1.0) : gradient;
	out_colour0 = result0 * vert_colour;
}
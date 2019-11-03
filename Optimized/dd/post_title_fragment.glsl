// post_title
#version 330
uniform sampler2D tex_diffuse;
out     vec4 out_colour0;

void main()
{
	vec2 vuv = (gl_FragCoord.xy / textureSize(tex_diffuse, 0));
	out_colour0 = texture(tex_diffuse, vuv);
}
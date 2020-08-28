// post
#version 330
uniform float exposure;
uniform sampler2D tex_diffuse;
out     vec4 out_colour0;

void main()
{
	out_colour0 = texture(tex_diffuse, gl_FragCoord.xy / textureSize(tex_diffuse, 0)) * exposure;
}

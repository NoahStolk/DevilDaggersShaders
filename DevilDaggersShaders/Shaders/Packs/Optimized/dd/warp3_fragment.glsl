// warp3
#version 330
uniform vec4 uv_scale_offset;
uniform sampler2D tex_diffuse;
in      vec3 vert_model_position;
in      vec3 vert_model_position2;
out     vec4 out_colour0;

void main()
{
	mat3 triplanes;
	triplanes[0] = texture(tex_diffuse, vert_model_position.xx, -1.0).rgb;
	triplanes[1] = texture(tex_diffuse, vert_model_position2.xx, -1.0).rgb;
	float fader = fract(uv_scale_offset.x);
	fader = min(1.0, fader * 2.0) - max(0.0, fader * 2.0 - 1.0);
	vec3 diffuse = mix(triplanes[1], triplanes[0], fader);
	diffuse = diffuse * diffuse;

	vec3 result0 = diffuse;

	out_colour0 = vec4(pow(result0, vec3(1.0 / 2.0)), 0.5);
}
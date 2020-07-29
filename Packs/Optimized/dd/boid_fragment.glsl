// boid
#version 330
uniform vec4 uv_scale_offset;
uniform sampler2D tex_diffuse;
in      vec2 vert_uv0;
out     vec4 out_colour0;

void main()
{
	vec3 diffuse = texture(tex_diffuse, vert_uv0, -1.0).rgb * 1.0;
	diffuse = diffuse * diffuse;

	vec3 result0 = diffuse * mix(1.4, 1.0, min(1.0, uv_scale_offset.y));

	out_colour0 = vec4(pow(result0, vec3(1.0 / 2.0)), uv_scale_offset.y);
}
// warpeye
#version 330
uniform vec4 uv_scale_offset;
uniform sampler2D tex_diffuse;
in      vec2 vert_uv0;
in      vec3 vert_view_dir;
out     vec4 out_colour0;

void main()
{
	vec3 vvd = normalize(vert_view_dir);
	float vvdx = atan(vvd.z, vvd.x) / 3.14159 * 3.0;
	vec2 hackuv = vec2(vvd.y / length(vvd.xz) * 0.5  + uv_scale_offset.x * 1.0, vvdx);

	vec3 diffusehack = texture(tex_diffuse, hackuv, -1.0).rgb;
	diffusehack = diffusehack * diffusehack;
	vec3 diffuse = texture(tex_diffuse, vert_uv0, -1.0).rgb;
	diffuse = diffuse * diffuse;
 
	diffuse = mix(diffusehack, diffuse, uv_scale_offset.w);

	diffuse = mix(diffuse, diffuse.rrr * 0.4, uv_scale_offset.z);

	vec3 result0 = diffuse;

	out_colour0 = vec4(pow(result0, vec3(1.0 / 2.0)), 0.5);
}
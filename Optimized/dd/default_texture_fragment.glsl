// default_texture
#version 330
uniform sampler2D tex_diffuse0;
uniform sampler2D tex_diffuse1;
uniform sampler2D tex_normal0;
uniform sampler2D tex_normal1;
uniform sampler2D tex_mask;
in      vec2 vert_uv0;
out     vec4 out_colour0;
out     vec4 out_colour1;

void main()
{
	vec4 diffuse_ao0    = texture(tex_diffuse0, vert_uv0.xy / (2048.0 / 256.0));
	vec4 diffuse_ao1    = texture(tex_diffuse1, vert_uv0.xy / (2048.0 / 256.0));
	vec4 normal_height0 = texture(tex_normal0,  vert_uv0.xy / (2048.0 / 256.0));
	vec4 normal_height1 = texture(tex_normal1,  vert_uv0.xy / (2048.0 / 256.0));
	vec4 mask = texture(tex_mask, vert_uv0.xy / (2000.0) - vec2(0.5));
	mask.rgb = mask.rgb * mask.rgb;
	diffuse_ao0.rgb = diffuse_ao0.rgb * diffuse_ao0.rgb;
	diffuse_ao1.rgb = diffuse_ao1.rgb * diffuse_ao1.rgb;

	vec4 t_diffuse = mix(diffuse_ao0, diffuse_ao1, mask.a);
	float diffuse_target_lum = dot(t_diffuse.rgb, vec3(0.28, 0.59, 0.12));
	float mask_src_lum = dot(mask.rgb, vec3(0.28, 0.59, 0.12));
	t_diffuse.rgb = mix(t_diffuse.rgb, mask.rgb * (diffuse_target_lum / mask_src_lum), 0.5);
	t_diffuse.rgb = pow(t_diffuse.rgb, vec3(0.5));

	out_colour0 = t_diffuse;
	out_colour1 = mix(normal_height0, normal_height1, mask.g);
}
// post_combine
#version 330
uniform float fog_ground;
uniform float dd_gamma;
uniform mat4 view_proj_matrix;
uniform sampler2D tex_diffuse;
uniform sampler2D tex_diffuse2;
uniform sampler2D tex_depth;
in      vec2 vert_view_pos;
out     vec4 out_colour0;

void main()
{
	vec2 vuv = (gl_FragCoord.xy / textureSize(tex_diffuse, 0));
	vec4 pos_projected = vec4(vert_view_pos, texture(tex_depth, vuv).r * 2.0 - 1.0, 1.0);
	vec4 test_pos = (view_proj_matrix * pos_projected);
	vec3 wpos = test_pos.xyz / test_pos.w;
	float fog = 1.0;
	fog *= clamp(1.0 + (45.0 - wpos.y) * 0.1, 0.0, 1.0);
	fog *= pow(clamp((fog_ground + wpos.y) / fog_ground, 0.0, 1.0), 3.0);

	vec4 result0 = texture(tex_diffuse, vuv.xy) * 5.0;

	vec4 result1 = texture(tex_diffuse2, vuv.xy);

	float illum_red = 1.0 - min(1.0, (1.0 - result1.a) * 2.0);
	float illum_main = min(1.0, (result1.a) * 2.0) * (1.0 - illum_red);
	result0.r = max(illum_red * 0.8, result0.r);
	vec4 illum_c = mix(result1 * result0, result1, illum_main);
	result1 = fog * illum_c;

	result1.rgb = pow(result1.rgb, vec3(dd_gamma));
	result1.rgb = pow(result1.rgb, vec3(1.0 / 2.2));
	out_colour0 = result1;
}
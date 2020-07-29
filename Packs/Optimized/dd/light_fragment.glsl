// light
#version 330
uniform mat4 view_proj_inv;
uniform sampler2D tex_depth;
uniform mat3 light_data;
in      vec4 vert_view_pos;
out     vec4 out_colour0;

void main()
{
	vec2 vuv = (gl_FragCoord.xy / textureSize(tex_depth, 0));
	vec4 result0 = vec4(0);
	vec2 view_uv = vert_view_pos.xy / vert_view_pos.w;
	vec4 pos_projected = vec4(view_uv, texture(tex_depth, vuv).r * 2.0 - 1.0, 1.0);
	vec4 test_pos = (view_proj_inv * pos_projected);
	result0.rgb = test_pos.xyz / test_pos.w;
	result0.rgb = vec3(light_data[2].x - length(result0.rgb - light_data[0])) / light_data[2].x * light_data[1];

	out_colour0 = result0 * 0.2;
}
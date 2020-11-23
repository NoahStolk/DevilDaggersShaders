// warp2
#version 330
uniform mat4 world_matrix;
uniform vec4 uv_scale_offset;
uniform sampler2D tex_diffuse;
in      vec3 vert_view_dir;
out     vec4 out_colour0;

void main()
{
	vec3 vvd = normalize(vert_view_dir);
	float vvdx = atan(vvd.z, vvd.x) / 3.14159 * 3.0;
	vec2 hackuv = vec2(vvd.y / length(vvd.xz) * 0.5  + uv_scale_offset.x * 1.0, vvdx);

	vec3 diffuse = textureLod(tex_diffuse, hackuv.yx * uv_scale_offset.zw + world_matrix[2].xz, -1.0).rgb * 1.0;

	vec3 result0 = diffuse * diffuse * pow(uv_scale_offset.y, 1.2);
	out_colour0 = vec4(pow(result0, vec3(1.0 / 2.0)), 0.5);
}
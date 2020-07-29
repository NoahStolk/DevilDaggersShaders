// debug
#version 330
in      vec3 in_position;
in      vec3 in_normal;
in      vec3 in_tangent;
in      vec3 in_bitangent;
in      vec2 in_uv0;
uniform mat4 world_matrix;
uniform mat4 view_proj_matrix;
uniform vec4 uv_scale_offset;
out     vec2 vert_uv0;
out     vec4 vert_position;
out     mat3 tbn;

void main()
{
	vert_uv0 = in_uv0 * uv_scale_offset.xy + uv_scale_offset.zw;
	tbn[0] = in_tangent;
	tbn[1] = in_bitangent;
	tbn[2] = in_normal;
	tbn = mat3x3(world_matrix) * tbn;

	vert_position = (world_matrix * vec4(in_position, 1.0));
	gl_Position = view_proj_matrix * vert_position;
}
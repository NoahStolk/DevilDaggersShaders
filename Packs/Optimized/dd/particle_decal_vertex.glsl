// particle_decal
#version 330
in      vec3 in_position;
in      vec3 in_normal;
in      vec2 in_uv0;
in      vec2 in_uv1;
uniform mat4 world_matrix;
uniform mat4 view_proj_matrix;
uniform vec3 cam_position;
uniform vec4 uv_scale_offset;
uniform mat4 user_matrix;
out     vec2 vert_uv0;
out     vec2 vert_uv1;
out     vec3 vert_normal;
out     vec3 vert_colour;
out     vec3 vert_rim;
out     mat3 view_matrix;
out     vec3 vert_view_vec;
out     vec4 vert_world_position;

void main()
{
	vert_normal = mat3(world_matrix) * in_normal;
	vert_colour = user_matrix[0].xyz;
	vert_rim    = user_matrix[1].xyz;
	vert_uv0 = in_uv0 * uv_scale_offset.xy + uv_scale_offset.zw;
	vert_uv1 = in_uv1;

	vec3 new_pos = in_position;
	float ca = atan(new_pos.z, new_pos.y);
	float len = length(new_pos.zy);
	ca += pow(in_position.z * 2.0, 2.0) * user_matrix[3].w * 10.0;
	new_pos.y = cos(ca) * len;
	new_pos.z = sin(ca) * len;

	vec4 world_position = world_matrix * vec4(new_pos, 1.0);
	vert_world_position = world_position;
	vert_view_vec = world_position.xyz - cam_position;

	float fresnel = 0.5 + 0.5 * dot(normalize(vert_view_vec), normalize(vert_normal));
	fresnel = fresnel + user_matrix[3].z;
	fresnel = fresnel > 1.0 ? -1.0 : fresnel;

	gl_ClipDistance[0] = fresnel;
	gl_ClipDistance[1] = -world_position.y + 0.1;
	view_matrix = mat3(view_proj_matrix);

	gl_Position = vec4(world_position.xz / 50.0, 0.0, 1.0);
}
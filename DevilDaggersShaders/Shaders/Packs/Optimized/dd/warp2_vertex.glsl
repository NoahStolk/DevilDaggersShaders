// warp2
#version 330
in      vec3 in_position;
in      vec3 in_normal;
in      vec2 in_uv0;
uniform mat4 world_matrix;
uniform mat4 view_proj_matrix;
uniform vec3 cam_position;
out     vec2 vert_uv0;
out     vec4 vert_world_position;
out     vec3 vert_view_dir;
out     vec3 vert_world_normal;

void main()
{
	vec3 v_normal = mat3(world_matrix) * in_normal;
	vert_uv0 = in_uv0;
	vec4 world_position = world_matrix * vec4(in_position, 1.0);
	world_position = floor(world_position * 16.0) / 16.0;
	vert_world_position = world_position;

	vert_view_dir = world_position.xyz - cam_position;
	vert_world_normal = v_normal;

	gl_Position = view_proj_matrix * world_position;
}
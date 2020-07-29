// sorath
#version 330
in      vec3 in_position;
in      vec2 in_uv0;
uniform mat4 world_matrix;
uniform mat4 view_proj_matrix;
uniform vec4 uv_scale_offset;
out     vec2 vert_uv0;
out     vec4 vert_world_position;

void main()
{
	vert_uv0 = in_uv0;
	vert_uv0.x -= (uv_scale_offset.x - 240.0) * 0.5 / uv_scale_offset.x;
	vert_uv0.x = vert_uv0.x * (uv_scale_offset.x / uv_scale_offset.y);
	vec4 world_position = world_matrix * vec4(in_position, 1.0);
	world_position = floor(world_position * 256.0) / 256.0;
	vert_world_position = world_position;
	gl_Position = view_proj_matrix * world_position;
}
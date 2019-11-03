// light_ring
#version 330
in      vec3 in_position;
in      vec2 in_uv0;
uniform mat4 world_matrix;
uniform mat4 view_proj_matrix;
uniform mat3 light_data;
out     vec2 vert_uv0;
out     vec4 vert_world_position;
out     vec4 vert_view_pos;

void main()
{
	vert_uv0 = in_uv0;
	vert_uv0.y = vert_uv0.y;
	vec4 world_position = world_matrix * vec4(in_position * light_data[2].x + light_data[0], 1.0);
	vert_world_position = world_position;
	vert_view_pos = view_proj_matrix * world_position;
	gl_Position = vert_view_pos; 
}
// hand
#version 330
in        vec3 in_position;
in        vec2 in_uv0;
uniform mat4 world_matrix;
uniform mat4 view_proj_matrix;
uniform vec3 cam_position;
uniform float light_scale;
uniform sampler2D tex_diffuse;
uniform sampler2D tex_reflect;
uniform vec3 light_pos;
out     vec2 vert_uv0;
out     vec4 vert_world_position;
void main( )
{
	vert_uv0 = in_uv0;
	vert_uv0.y = vert_uv0.y;
	vec4 world_position = world_matrix * vec4( in_position, 1.0 );
	world_position = floor( world_position * 200.0 ) / 200.0;
	vert_world_position = world_position;
	gl_Position = view_proj_matrix * world_position;
}
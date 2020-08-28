// tile2
#version 330
in        vec3 in_position;
in        vec3 in_normal;
in        vec2 in_uv0;
uniform mat4 world_matrix;
uniform mat4 view_proj_matrix;
uniform vec4 uv_scale_offset;
uniform vec3 cam_position;
uniform float light_scale;
uniform sampler2D tex_diffuse;
uniform sampler2D tex_normal;
uniform sampler2D tex_reflect;
uniform sampler2D tex_decals;
uniform vec3 light_pos;
out     vec2 vert_uv0;
out     vec4 vert_world_position;
out     vec3 vert_world_normal;
void main( )
{
	vert_uv0 = in_uv0;
	vert_uv0.y = vert_uv0.y;
	vert_uv0 = vec2( length( in_position.xz * 0.06 ) + uv_scale_offset.z * -0.08 );
	vec4 world_position = world_matrix * vec4( in_position * vec3( 1.0, 1.0, 1.0 ), 1.0 );
	world_position = floor( world_position * 16.0 ) / 16.0;
//	world_position.y = world_position.y < -2.01? -2.0:world_position.y;
//	float ca = atan( world_position.z, world_position.x );
//	float len = length( world_position.xz );
//	ca += max( 0.0, 16.0 - len ) / 16.0;
//	world_position.x = sin( ca ) * len;
//	world_position.z = -cos( ca ) * len;
//	vert_world_normal = mat3( world_matrix ) * in_normal;
	vert_world_position = world_position;
	gl_Position = view_proj_matrix * world_position;
}
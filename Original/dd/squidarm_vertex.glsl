// squidarm
#version 330
in        vec3 in_position;
in        vec3 in_normal;
in        vec2 in_uv0;
uniform mat4 world_matrix;
uniform mat4 view_proj_matrix;
uniform vec3 cam_position;
uniform vec4 uv_scale_offset;
uniform float light_scale;
uniform sampler2D tex_diffuse;
uniform sampler2D tex_normal;
uniform sampler2D tex_reflect;
uniform vec3 light_pos;
out     vec2 vert_uv0;
out     vec4 vert_world_position;
void main( )
{
	vec3 v_normal = mat3( world_matrix ) * in_normal;
	vert_uv0 = in_uv0;
	vert_uv0.y = vert_uv0.y;
	float spawn_scale = uv_scale_offset.w;
	float spawn_inv = 1.0 - spawn_scale;
	float wave_amount = clamp(( -in_position.y - 1.5 ) * 0.5, 0.0, 1.0 ) * 0.5;
	float s_v = pow( -in_position.y, 2.1 ) * 0.07  - abs( uv_scale_offset.x ) * 2.0;
	float s_l = pow( -in_position.y, 2.1 ) * 0.07  - uv_scale_offset.z * 4.0;
	vec3 p_off = wave_amount * vec3( 0.0, 0.0, sin( s_v ) * spawn_inv + ( sin( s_l + 0.1 )* 2.0 + 2.0 ) * spawn_scale);
	vec3 new_pos = in_position + p_off;
	float ca = atan( new_pos.z, new_pos.x );
	float len = length( new_pos.xz );
	ca += wave_amount * -pow( -in_position.y, 2.1 ) * 0.07 * mix( 0.2, 1.0, spawn_inv );
	new_pos.x = sin( ca ) * len;
	new_pos.z = -cos( ca ) * len;
	new_pos.y *= 1.0;
	vec4 world_position = world_matrix * vec4( new_pos, 1.0 );
	//world_position = world_matrix * vec4( in_position, 1.0 );
	world_position = floor( world_position * 16.0 ) / 16.0;
	vert_world_position = world_position;
	
	float fresnel = 0.5 + 0.5 * dot( normalize( world_position.xyz - cam_position ), normalize( v_normal ));
	fresnel = fresnel - uv_scale_offset.y * 3.333;
	fresnel = fresnel > 1.0? -1.0:fresnel;
	gl_ClipDistance[ 0 ] = fresnel;

	gl_Position = view_proj_matrix * world_position;
}
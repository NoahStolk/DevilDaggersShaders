// thorn
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
	vec3 new_pos = in_position;
	new_pos += in_normal * 0.3 * ( sin( uv_scale_offset.x + in_position.y * 0.4 ) * 0.5 + 0.5 );
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
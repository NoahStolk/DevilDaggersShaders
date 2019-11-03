// particle
#version 330
in        vec3 in_position;
in        vec3 in_normal;
in        vec3 in_tangent;
in        vec3 in_bitangent;
in        vec2 in_uv0;
in        vec2 in_uv1;
uniform mat4 world_matrix;
uniform mat4 view_proj_matrix;
uniform vec3 cam_position;
uniform float light_scale;
uniform sampler2D tex_diffuse;
uniform sampler2D tex_normal;
uniform sampler2D tex_reflect;
uniform vec3 light_pos;
out     vec2 vert_uv0;
out     vec2 vert_uv1;
out     vec3 vert_normal;
out     vec3 vert_colour;
out     vec3 vert_rim;
out     mat3 view_matrix;
out     vec3 vert_view_vec;
out     vec4 vert_world_position;
void main( )
{
	vert_normal = in_normal;
	vert_colour = in_tangent;
	vert_rim    = in_bitangent;
	vert_uv0 = in_uv0;
	vert_uv0.y = vert_uv0.y;
	vert_uv1 = in_uv1;

	vec3 new_pos = in_position;
//	float ca = atan( new_pos.y, new_pos.x );
//	float len = length( new_pos.xy );
//	ca += pow( in_position.y, 2.1 ) * 0.07;
//	new_pos.x = sin( ca ) * len;
//	new_pos.y = -cos( ca ) * len;

	vec4 world_position = vec4( new_pos, 1.0 );
//	world_position = floor( world_position * 32.0 ) / 32.0;
	vert_world_position = world_position;
	vert_view_vec = world_position.xyz - cam_position;

	float fresnel = 0.5 + 0.5 * dot( normalize( vert_view_vec ), normalize( vert_normal ));
	fresnel = fresnel + vert_uv1.x;
	fresnel = fresnel > 1.0? -1.0:fresnel;

	gl_ClipDistance[ 0 ] = fresnel;
	view_matrix = mat3( view_proj_matrix );
	gl_Position = view_proj_matrix * world_position;
}
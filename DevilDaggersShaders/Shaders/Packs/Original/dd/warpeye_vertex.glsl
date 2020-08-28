// warpeye
#version 330
in        vec3 in_position;
uniform mat4 world_matrix;
uniform mat4 view_proj_matrix;
uniform vec3 cam_position;
uniform vec4 uv_scale_offset;
uniform float erode;
uniform float light_scale;
uniform sampler2D tex_diffuse;
uniform sampler2D tex_normal;
uniform sampler2D tex_reflect;
uniform vec3 light_pos;
out     vec2 vert_uv0;
out     vec4 vert_world_position;
out     vec3 vert_view_dir;
void main( )
{
	vert_uv0 = in_position.yy * 0.03 + vec2( uv_scale_offset.x, 0.0 ) * 0.08;// * uv_scale_offset.xy + uv_scale_offset.zw;
	vec4 world_position = world_matrix * vec4( in_position, 1.0 );
	world_position = floor( world_position * 16.0 ) / 16.0;
	vert_world_position = world_position;

	vert_view_dir = world_position.xyz - cam_position;

	gl_Position = view_proj_matrix * world_position;
}
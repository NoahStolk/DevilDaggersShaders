// test
#version 330
in        vec3 in_position;
in        vec2 in_uv0;
uniform mat4 view_proj_matrix;
uniform vec4 uv_scale_offset;
out     vec2 vert_uv0;
void main( )
{
	vert_uv0 = in_uv0 * uv_scale_offset.xy + uv_scale_offset.zw;
	gl_Position = vec4( in_position + vec3( 0.0, 0.0, -10.0 ), 1.0 ) * view_proj_matrix;
}
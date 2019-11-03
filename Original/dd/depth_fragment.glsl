// depth
#version 330
uniform mat4 world_matrix;
uniform mat4 view_proj_matrix;
uniform vec4 uv_scale_offset;
out vec4 out_colour0;
void main( )
{
	out_colour0 = vec4( 0 );
}
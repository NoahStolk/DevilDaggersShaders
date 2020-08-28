// test
#version 330
uniform mat4 view_proj_matrix;
uniform vec4 uv_scale_offset;
in      vec2 vert_uv0;
out vec4 out_colour0;
void main( )
{
	out_colour0 = vec4( vert_uv0, 1.0, 1.0 );
}
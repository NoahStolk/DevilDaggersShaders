// post_title
#version 330
in        vec3 in_position;
in        vec2 in_uv0;
uniform vec3 light_dir;
uniform mat4 view_proj_matrix;
uniform sampler2D tex_diffuse;
out     vec2 vert_uv0;
void main( )
{
	vert_uv0 = in_uv0;
	gl_Position = vec4( in_position , 1.0 );
}
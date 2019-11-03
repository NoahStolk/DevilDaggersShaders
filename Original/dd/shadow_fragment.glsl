// shadow
#version 330
uniform mat4 world_matrix;
uniform mat4 view_proj_matrix;
uniform vec3 cam_position;
uniform sampler2D tex_diffuse;
uniform sampler2D tex_reflect;
uniform vec3 light_pos;
in      vec2 vert_uv0;
in      vec4 vert_world_position;
out vec4 out_colour0;
void main( )
{
	out_colour0 = vec4( 0.0, 0.0, 0.0, 0.5 );
}
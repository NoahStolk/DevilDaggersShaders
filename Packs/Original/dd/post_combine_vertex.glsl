// post_combine
#version 330
in        vec3 in_position;
in        vec2 in_uv0;
uniform float fog_ground;
uniform float dd_gamma;
uniform vec3 light_dir;
uniform mat3 aspect_view_proj;
uniform mat4 view_proj_matrix;
uniform sampler2D tex_diffuse;
uniform sampler2D tex_diffuse2;
uniform sampler2D tex_depth;
out     vec2 vert_uv0;
out     vec2 vert_view_pos;
out     vec3 vert_view_dir;
void main( )
{
	vert_uv0 = in_uv0;
	vert_view_pos = in_position.xy;
	gl_Position = vec4( in_position , 1.0 );
}
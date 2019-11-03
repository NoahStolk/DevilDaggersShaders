// post
#version 330
in        vec3 in_position;
in        vec2 in_uv0;
uniform float seed;
uniform float vhs_scale;
uniform float lut_scale;
uniform float lut2_scale;
uniform float exposure;
uniform vec3 cam_position;
uniform vec3 light_dir;
uniform mat3 aspect_view_proj;
uniform mat4 view_proj_matrix;
uniform sampler2D tex_diffuse;
uniform sampler2D tex_diffuse2;
uniform sampler2D tex_lut;
uniform sampler2D tex_lut2;
out     vec2 vert_uv0;
out     vec2 vert_view_pos;
out     vec3 vert_view_dir;
void main( )
{
	vert_uv0 = in_uv0;
	vert_view_dir = view_proj_matrix[ 2 ].xyz;
	vert_view_pos = in_position.xy;
	gl_Position = vec4( in_position , 1.0 );
}
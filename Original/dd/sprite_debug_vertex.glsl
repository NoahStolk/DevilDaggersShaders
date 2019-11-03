// sprite_debug
#version 330
in        vec3 in_position;
in        vec2 in_uv0;
uniform sampler2D tex_sprite0;
uniform sampler2D tex_sprite1;
uniform sampler2D tex_sprite2;
out     vec2 vert_uv0;
void main( )
{
	vert_uv0 = in_uv0;
	gl_Position = vec4( in_position * 2.0, 1.0 );
}
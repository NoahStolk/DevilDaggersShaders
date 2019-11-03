// sprite_debug
#version 330
uniform sampler2D tex_sprite0;
uniform sampler2D tex_sprite1;
uniform sampler2D tex_sprite2;
in      vec2 vert_uv0;
out vec4 out_colour0;
void main( )
{
	vec4 result0 = texture( tex_sprite2, vert_uv0.xy / textureSize( tex_sprite2, 0 ) ).gaaa;
	result0.a = 1.0;
	out_colour0 = result0;
}
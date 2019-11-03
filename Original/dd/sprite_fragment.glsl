// sprite
#version 330
uniform sampler2D tex_sprite0;
in      vec2 vert_uv0;
out vec4 out_colour0;
void main( )
{
	vec4 result0 = texture( tex_sprite0, vert_uv0.xy / textureSize( tex_sprite0, 0 ) );
//	result0 = vec4( 1.0 );
//	result0.rg = fract( vert_uv0.xy / 100.0 );
	result0.a = 1.0;
	out_colour0 = result0;
}
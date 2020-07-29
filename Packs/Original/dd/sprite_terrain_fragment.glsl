// sprite_terrain
#version 330
uniform sampler2D tex_sprite0;
uniform sampler2D tex_sprite1;
uniform sampler2D tex_sprite2;
uniform sampler2D tex_target0;
uniform sampler2D tex_target1;
in      vec2 vert_uv0;
in      mat2 vert_rotation_inv;
out vec4 out_colour0;
out vec4 out_colour1;
void main( )
{
	vec4 s0 = texture( tex_sprite0, vert_uv0.xy / textureSize( tex_sprite0, 0 ));
	vec4 s1 = texture( tex_sprite1, vert_uv0.xy / textureSize( tex_sprite1, 0 ));
	vec4 s2 = texture( tex_sprite2, vert_uv0.xy / textureSize( tex_sprite2, 0 ));
	vec2 normal_xy = s2.ga * 2.0 - 1.0;
	normal_xy = ( vert_rotation_inv * normal_xy) * 0.5 + 0.5;
	vec2 t_uv = gl_FragCoord.xy / textureSize( tex_target0, 0 );
	vec4 t0 = texture( tex_target0, t_uv );
	vec4 t1 = texture( tex_target1, t_uv );
	vec4 result0 = vec4( s0.rgb, s1.g ); // 
	vec4 result1 = vec4( normal_xy, s1.b, 0.0 );
	// Sample target textures, mask, blend
//	target0   = mix( t0.a, result0.a, s1.a );
	out_colour0.rgb = mix( t0.rgb, result0.rgb, s1.a * 0.5 );
	out_colour0.a   = mix( t0.a, result0.a, s1.a );
//	target0.r = 1.0;
//	target0.g = 0.0;
	out_colour1 = mix( t1, result1.rrgg, s1.a );
}
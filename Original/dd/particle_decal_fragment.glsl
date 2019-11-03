// particle_decal
#version 330
uniform mat4 world_matrix;
uniform mat4 view_proj_matrix;
uniform vec3 cam_position;
uniform vec4 uv_scale_offset;
uniform mat4 user_matrix;
uniform sampler2D tex_diffuse;
in      vec2 vert_uv0;
in      vec2 vert_uv1;
in      vec3 vert_normal;
in      vec3 vert_colour;
in      vec3 vert_rim;
in      mat3 view_matrix;
in      vec3 vert_view_vec;
in      vec4 vert_world_position;
out vec4 out_colour0;

vec3 get_lighting( const in vec4 pos, const in vec3 cam_p, float ls );

vec4 get_fog( const in vec4 pos, const in vec3 cam_p );

vec4 get_fog( const in vec4 pos, const in vec3 cam_p )
{
	float fog = min( 1.0, length( pos.xyz - cam_p ) / 100.0);
	fog = pow( fog, 0.4 );
	return vec4( 0.0, 0.0, 0.0, fog * 0.5 );
}

vec3 get_lighting( const in vec4 pos, const in vec3 cam_p, float ls )
{
	//ls *= 4.0;
	vec3 pos2 = pos.xyz / ls;
	float fade = length( pos2.xyz );
	fade = 2.0 * clamp(( 60.0 - fade ) / 60.0, 0.0, 1.0 );
	vec3 light = vec3( fade );
	light += pow( fade, 0.3 ) * pow( clamp(( 1.0 - length( pos.xyz - cam_p ) / 6.0 ), 0.0, 0.5 ), 1.2 ) * 22.6 * vec3( 1.0, 0.5, 0.1 );
  //  return vec3( pow( fade, 3.0 )) * 0.25;
//	light = max( light, vec3( 0.12 ) * ls * ls );
//	light *= clamp(( 19.0 - pos.y ) * 0.1, 0.0, 1.0 );
//	light *= clamp(( 2.0 + pos.y ) * 0.5, 0.0, 1.0 );
//	light /= length( pos.xyz - cam_p ) / 10.0;
    return light * 0.5;
}
void main( )
{
	vec3 result0 = vec3( 0.7, 0.02, 0.01 );
	result0 = vert_colour * vert_colour * 0.5;


	float fresnel = 0.5 + 0.5 * dot( normalize( vert_view_vec ), normalize( vert_normal ));
	//fresnel = fresnel > ( 1.0 - vert_uv0.y )? 1.0:0.0;
	fresnel *= min( 1.0, user_matrix[ 3 ].y );
	fresnel += max( 0.0, user_matrix[ 3 ].y - 1.0 );

	result0 = mix( result0, vert_rim * vert_rim * 0.5, fresnel );

	//result0 = clamp( result0 * texture( tex_diffuse, vert_uv0 ).rgb, 0.0, 1.0 );
	//result0 = clamp( result0 + texture( tex_diffuse, vert_uv0 ).rgb * 0.2 - 0.1, 0.0, 1.0 );
	result0 = clamp( result0 * ( texture( tex_diffuse, vert_uv0 ).rgb + 0.5 ), 0.0, 1.0 );

	//float l = dot( result0, vec3( 0.29, 0.5, 0.11 ));
	//result0.rgb /= max( result0.r, max( result0.g, result0.b ));
	//result0 *= 	texture( tex_diffuse, vert_uv0 ).rgb;

	//vec3 fade = get_lighting( vert_world_position, cam_position );
    //result0 = mix( result0 * fade, result0, user_matrix[ 3 ].x );
    //result0.rg = ss_reflect;
    //vec4 fog = get_fog( vert_world_position, cam_position );
    //result0 = mix( result0, fog.rgb, fog.w );

    // result0.rgb = mix( result0, vec3( 1.0, 0.3, 0.0 ), pow( fresnel, 0.5 ));
    //result0.rgb = vec3( pow( fresnel, 2.0 ) );
    //result0.rgb = normalize( vert_normal ) * 0.5 + 0.5;

	out_colour0 = vec4( pow( result0 * 2.0, vec3( 1.0 / 2.0 )), 1.0 );
}
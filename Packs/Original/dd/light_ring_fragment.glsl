// light_ring
#version 330
uniform mat4 world_matrix;
uniform mat4 view_proj_matrix;
uniform mat4 view_proj_inv;
uniform vec3 cam_position;
uniform sampler2D tex_diffuse;
uniform sampler2D tex_depth;
uniform mat3 light_data;
in      vec2 vert_uv0;
in      vec4 vert_world_position;
in      vec4 vert_view_pos;
out vec4 out_colour0;
void main( )
{
	vec2 vuv = ( gl_FragCoord.xy / textureSize( tex_depth, 0 ) );
	vec4 result0 = vec4( 0.0 );
	vec2 view_uv = vert_view_pos.xy / vert_view_pos.w;
	//vec4 pos_projected = vec4( view_uv, texture( tex_depth, vuv * vec2( 0.5 ) + vec2( 0.5 ) ).r * 2.0 - 1.0, 1.0 );
	vec4 pos_projected = vec4( view_uv, texture( tex_depth, vuv ).r * 2.0 - 1.0, 1.0 );
	vec4 test_pos = ( view_proj_inv * pos_projected );
	result0.rgb = test_pos.xyz / test_pos.w;

	vec3 vvd = normalize( result0.rgb - cam_position );
	float vvdx = atan( vvd.z, vvd.x ) / 3.14159 * 3.0;
	vec2 hackuv = vec2( vvd.y / length( vvd.xz ) * 0.5  + light_data[ 2 ].x * 0.4, vvdx );

//	vec2 hackuv = normalize( result0.rgb - cam_position ).xz;

	vec3 diffuse = textureLod( tex_diffuse, hackuv, -1.0 ).rgb * 1.0;
	
	float ring = light_data[ 2 ].x - length( result0.rgb - light_data[ 0 ] );
	ring = 1.0 - (abs( ring - light_data[ 2 ].z ) / light_data[ 2 ].z);
	ring = min( 1.0, ring * 2.0 );
	ring = round( ring * 4.0 ) / 4.0;
	result0.rgb = ring * light_data[ 1 ] * diffuse;
    
//	result0.rgb += vec3( textureLod( tex_diffuse, view_uv.xy * vec2( 0.5 ) + vec2( 0.5 ), 0 ).r ) * 0.2;
//	result0.rgb = vec3( textureLod( tex_depth, view_uv.xy * vec2( 0.5 ) + vec2( 0.5 ), 0 ).r );

//	result0.rgb = vec3( texelFetch)
//	result0.rg = view_uv.xy * vec2( 0.5 ) + vec2( 0.5 );
//	result0.rgb = vec3( 1.0 );
//	ring = 1.0;
//	result0.rg = vec2( texture( tex_depth, vuv * vec2( 0.5 ) + vec2( 0.5 ) ).r * 2.0 - 1.0, 0.0 );
//	result0.b = 0.0;

	out_colour0 = vec4( result0.rgb * 0.2, ring );
}
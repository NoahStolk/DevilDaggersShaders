// light
#version 330
uniform mat4 world_matrix;
uniform mat4 view_proj_matrix;
uniform mat4 view_proj_inv;
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
	//vec4 pos_projected = vec4( vuv.xy, texture( tex_depth, view_uv * vec2( 0.5 ) + vec2( 0.5 ) ).r * 2.0 - 1.0, 1.0 );
	vec4 pos_projected = vec4( view_uv, texture( tex_depth, vuv ).r * 2.0 - 1.0, 1.0 );
	vec4 test_pos = ( view_proj_inv * pos_projected );
	result0.rgb = test_pos.xyz / test_pos.w;
	result0.rgb = vec3( light_data[ 2 ].x - length( result0.rgb - light_data[ 0 ] )) / light_data[ 2 ].x * light_data[ 1 ];
    
//	result0.rgb += vec3( textureLod( tex_diffuse, view_uv.xy * vec2( 0.5 ) + vec2( 0.5 ), 0 ).r ) * 0.2;
//	result0.rgb = vec3( textureLod( tex_depth, view_uv.xy * vec2( 0.5 ) + vec2( 0.5 ), 0 ).r );

//	result0.rgb = vec3( texelFetch)
//	result0.rg = view_uv.xy * vec2( 0.5 ) + vec2( 0.5 );
//	result0.rgb = vec3( 1.0 );
//	result0.g = 1.0;
	//result0.rgb = vec3( texture( tex_depth, view_uv.xy * vec2( 0.5 ) + vec2( 0.5 ) ).r * 100.0);

	//result0.rg = vuv;
	//result0.rgb = test_pos.xyz / test_pos.w;

	out_colour0 = result0 * 0.2;
}
// tile2
#version 330
uniform mat4 world_matrix;
uniform mat4 view_proj_matrix;
uniform vec4 uv_scale_offset;
uniform vec3 cam_position;
uniform float light_scale;
uniform sampler2D tex_diffuse;
uniform sampler2D tex_normal;
uniform sampler2D tex_reflect;
uniform sampler2D tex_decals;
uniform vec3 light_pos;
in      vec2 vert_uv0;
in      vec4 vert_world_position;
in      vec3 vert_world_normal;
out vec4 out_colour0;

vec4 get_fog( const in vec4 pos, const in vec3 cam_p );

vec4 get_fog( const in vec4 pos, const in vec3 cam_p )
{
	float fog = min( 1.0, length( pos.xyz - cam_p ) / 100.0);
	fog = pow( fog, 0.4 );
	return vec4( 0.0, 0.0, 0.0, fog * 0.5 );
}
void main( )
{
	vec3 diffuse = texture( tex_diffuse, vert_uv0, -1.0 ).rgb * 1.0;
	diffuse = diffuse * diffuse;

	vec2 decal_uv = vert_world_position.xz;
	vec4 decals = texture( tex_decals, decal_uv / 100.0 + 0.5 );
	diffuse = mix( diffuse, decals.rgb * decals.rgb, decals.a * 0.1 ) * decals.rgb;

	vec3 result0 = diffuse;

    vec4 fog = get_fog( vert_world_position, cam_position );
    result0 = mix( result0, fog.rgb, fog.w );

	out_colour0 = vec4( pow( result0, vec3( 1.0 / 2.0 )), 0.0 );
}
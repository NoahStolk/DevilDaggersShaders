// warpeye
#version 330
uniform mat4 world_matrix;
uniform mat4 view_proj_matrix;
uniform vec3 cam_position;
uniform vec4 uv_scale_offset;
uniform float erode;
uniform float light_scale;
uniform sampler2D tex_diffuse;
uniform sampler2D tex_normal;
uniform sampler2D tex_reflect;
uniform vec3 light_pos;
in      vec2 vert_uv0;
in      vec4 vert_world_position;
in      vec3 vert_view_dir;
out vec4 out_colour0;
void main( )
{
	vec3 vvd = normalize( vert_view_dir );
	float vvdx = atan( vvd.z, vvd.x ) / 3.14159 * 3.0;
	vec2 hackuv = vec2( vvd.y / length( vvd.xz ) * 0.5  + uv_scale_offset.x * 1.0, vvdx );

	vec3 diffusehack = texture( tex_diffuse, hackuv, -1.0 ).rgb;
	diffusehack = diffusehack * diffusehack;
	vec3 diffuse = texture( tex_diffuse, vert_uv0, -1.0 ).rgb;
	diffuse = diffuse * diffuse;
 
	diffuse = mix( diffusehack, diffuse, uv_scale_offset.w );

	diffuse = mix( diffuse, diffuse.rrr * 0.4, uv_scale_offset.z );

	vec3 result0 = diffuse;
	//result0.r = fader * 0.5;

	out_colour0 = vec4( pow( result0, vec3( 1.0 / 2.0 )), 0.5 );
}
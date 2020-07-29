// warp3
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
in      vec3 vert_model_position;
in      vec3 vert_model_position2;
in      vec4 vert_world_position;
in      vec3 vert_view_dir;
in      vec3 vert_world_normal;
out vec4 out_colour0;
void main( )
{
	mat3 triplanes;
	triplanes[ 0 ] = texture( tex_diffuse, vert_model_position.xx, -1.0 ).rgb;
	triplanes[ 1 ] = texture( tex_diffuse, vert_model_position2.xx, -1.0 ).rgb;
	//triplanes[ 2 ] = texture( tex_diffuse, vert_model_position.xz, -1.0 ).rgb;
	float fader = fract( uv_scale_offset.x );
	fader = min( 1.0, fader * 2.0 ) - max( 0.0, fader * 2.0 - 1.0 );
	vec3 diffuse = mix( triplanes[ 1 ], triplanes[ 0 ], fader );
	diffuse = diffuse * diffuse;

	vec3 result0 = diffuse;
	//result0.r = fader * 0.5;

	out_colour0 = vec4( pow( result0, vec3( 1.0 / 2.0 )), 0.5 );
}
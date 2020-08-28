// post_final
#version 330
uniform vec3 light_dir;
uniform mat3 aspect_view_proj;
uniform mat4 view_proj_matrix;
uniform sampler2D tex_diffuse;
in      vec2 vert_uv0;
in      vec2 vert_view_pos;
in      vec3 vert_view_dir;
out vec4 out_colour0;
void main( )
{

	vec4 result0 = texture( tex_diffuse, vert_uv0 );
	//result0 *= result0;
	

	//result0.rgb = max( vec3( 0.02 ), result0.rgb );

	//result0.rgb = mix( vec3( 0.00 ), vec3( 1.0 ), result0.rgb );

	out_colour0 = result0;
}
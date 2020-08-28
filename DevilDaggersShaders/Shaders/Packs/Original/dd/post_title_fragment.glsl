// post_title
#version 330
uniform vec3 light_dir;
uniform mat4 view_proj_matrix;
uniform sampler2D tex_diffuse;
in      vec2 vert_uv0;
out vec4 out_colour0;
void main( )
{
	vec2 vuv = ( gl_FragCoord.xy / textureSize( tex_diffuse, 0 ) );
	vec4 result0 = texture( tex_diffuse, vuv );
	out_colour0 = result0;
}
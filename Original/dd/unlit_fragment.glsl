// unlit
#version 330
uniform mat4 world_matrix;
uniform mat4 view_proj_matrix;
uniform vec3 cam_position;
uniform vec4 uv_scale_offset;
uniform sampler2D tex_diffuse;
uniform vec3 light_pos;
in      vec2 vert_uv0;
in      vec4 vert_world_position;
out vec4 out_colour0;
void main( )
{
	vec3 diffuse = texture( tex_diffuse, vert_uv0, -1.0 ).rgb;
	diffuse *= diffuse;

	diffuse *= 1.0 + ( -sin( uv_scale_offset.x )) * 0.2 * uv_scale_offset.y;

    vec3 result0 = diffuse * 0.5;

	out_colour0 = vec4( pow( result0, vec3( 1.0 / 2.0 )), 0.5 );
}
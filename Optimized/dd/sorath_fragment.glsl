// sorath
#version 330
uniform mat4 world_matrix;
uniform mat4 view_proj_matrix;
uniform vec3 cam_position;
uniform vec4 uv_scale_offset;
uniform sampler2D tex_diffuse;
uniform sampler2D tex_mask;
uniform sampler2D tex_vector;
uniform vec3 light_pos;
in      vec2 vert_uv0;
in      vec4 vert_world_position;
out     vec4 out_colour0;

void main()
{
	vec2 uv0 = vert_uv0;
	uv0.x = clamp(uv0.x, 0.0, 1.0);
	vec2 displace = texture(tex_vector, uv0, -1.0).rg;
	displace = displace * 2.0 - vec2(1.0);
	float timer = uv_scale_offset.z * 0.4 + length(displace) * 2.0;
	float t = fract(timer);
	float t2 = fract(timer + 0.5);
	vec3 diffuse = texture(tex_diffuse, uv0 - displace * t * 0.8, -1.0).rgb;
	diffuse = diffuse * diffuse;
	vec3 diffuse2 = texture(tex_diffuse, uv0 - displace * t2 * 0.8, -1.0).rgb;
	diffuse2 = diffuse2 * diffuse2;
	float fader = t * 2.0 - 2.0 * clamp(t * 2.0 - 1.0, 0.0, 1.0);
	fader = fader * 2.0 - 1.0;
	fader = sign(fader) * pow(abs(fader), 0.6);
	fader = fader * 0.5 + 0.5;
	diffuse = mix(diffuse2, diffuse, fader);
	float mask = texture(tex_mask, uv0, -1.0).r;

	diffuse = diffuse * mask;

	vec3 result0 = diffuse;

	out_colour0 = vec4(pow(result0, vec3(1.0 / 2.0)) * 0.5, 0.5);
}
// particle
#version 330
uniform vec3 cam_position;
uniform float light_scale;
in      vec2 vert_uv0;
in      vec3 vert_normal;
in      vec3 vert_colour;
in      vec3 vert_rim;
in      vec3 vert_view_vec;
in      vec4 vert_world_position;
out     vec4 out_colour0;

vec3 get_lighting(const in vec4 pos, const in vec3 cam_p, float ls);

vec4 get_fog(const in vec4 pos, const in vec3 cam_p);

vec3 get_lighting(const in vec4 pos, const in vec3 cam_p, float ls)
{
	vec3 pos2 = pos.xyz / ls;
	float fade = length(pos2.xyz);
	fade = 2.0 * clamp((60.0 - fade) / 60.0, 0.0, 1.0);
	vec3 light = vec3(fade);
	light += pow(fade, 0.3) * pow(clamp((1.0 - length(pos.xyz - cam_p) / 6.0), 0.0, 0.5), 1.2) * 22.6 * vec3(1.0, 0.5, 0.1);
	return light * 0.5;
}

vec4 get_fog(const in vec4 pos, const in vec3 cam_p)
{
	float fog = min(1.0, length(pos.xyz - cam_p) / 100.0);
	fog = pow(fog, 0.4);
	return vec4(0.0, 0.0, 0.0, fog * 0.5);
}

void main()
{
	vec3 result0 = vec3(0.7, 0.02, 0.01);
	result0 = vert_colour * vert_colour * 0.5;

	float fresnel = 0.5 + 0.5 * dot(normalize(vert_view_vec), normalize(vert_normal));
	fresnel = fresnel > (1.0 - vert_uv0.y) ? 1.0 : 0.0;

	result0 = mix(result0, vert_rim * vert_rim * 0.5, fresnel);

	vec3 fade = get_lighting(vert_world_position, cam_position, light_scale);
	vec4 fog = get_fog(vert_world_position, cam_position);
	result0 = mix(result0, fog.rgb, fog.w);

	out_colour0 = vec4(pow(result0, vec3(1.0 / 2.0)), vert_uv0.x);
}
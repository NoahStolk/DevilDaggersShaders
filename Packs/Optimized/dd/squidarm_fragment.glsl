// squidarm
#version 330
uniform vec3 cam_position;
uniform vec4 uv_scale_offset;
uniform float light_scale;
uniform sampler2D tex_diffuse;
in      vec2 vert_uv0;
in      vec4 vert_world_position;
out     vec4 out_colour0;

vec3 get_lighting(const in vec4 pos, const in vec3 cam_p, float ls);

vec4 get_fog(const in vec4 pos, const in vec3 cam_p);

vec4 get_fog(const in vec4 pos, const in vec3 cam_p)
{
	float fog = min(1.0, length(pos.xyz - cam_p) / 100.0);
	fog = pow(fog, 0.4);
	return vec4(0.0, 0.0, 0.0, fog * 0.5);
}

vec3 get_lighting(const in vec4 pos, const in vec3 cam_p, float ls)
{
	vec3 pos2 = pos.xyz / ls;
	float fade = length(pos2.xyz);
	fade = 2.0 * clamp((60.0 - fade) / 60.0, 0.0, 1.0);
	vec3 light = vec3(fade);
	light += pow(fade, 0.3) * pow(clamp((1.0 - length(pos.xyz - cam_p) / 6.0), 0.0, 0.5), 1.2) * 22.6 * vec3(1.0, 0.5, 0.1);
	return light * 0.5;
}

void main()
{
	vec3 diffuse = texture(tex_diffuse, vert_uv0, -1.0).rgb * 1.0;
	diffuse = diffuse * diffuse;

	vec3 result0 = diffuse * 1.4;

	vec3 fade = get_lighting(vert_world_position, cam_position, light_scale);
	vec4 fog = get_fog(vert_world_position, cam_position);
	result0 = mix(result0, fog.rgb, fog.w);

	out_colour0 = vec4(pow(result0, vec3(1.0 / 2.0)), uv_scale_offset.x < 0.0 ? 0.5 : 0.0);
}
varying vec2 v_vTexcoord;
varying vec4 v_vColour;
uniform float Degree; // 0 = No greyscale, 1 = full greyscale

void main()
{
    vec4 texColor = texture2D(gm_BaseTexture, v_vTexcoord);
    float gray = (texColor.r * 0.299) + (texColor.g * 0.587) + (texColor.b * 0.114);
	float r = (texColor.r * (1.0 - Degree) + (gray * Degree));
	float g = (texColor.g * (1.0 - Degree) + (gray * Degree));
	float b = (texColor.b * (1.0 - Degree) + (gray * Degree));
    gl_FragColor = vec4(r, g, b, texColor.a);
}
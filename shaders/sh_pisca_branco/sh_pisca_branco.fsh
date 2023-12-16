//
// Simple passthrough fragment shader
//
varying vec2 v_vTexcoord;
varying vec4 v_vColour;

void main()
{
	vec4 minha_cor = v_vColour * texture2D( gm_BaseTexture, v_vTexcoord );
	minha_cor.rgb = vec3(1);
	
    gl_FragColor = minha_cor;
}

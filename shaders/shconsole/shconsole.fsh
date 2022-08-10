uniform vec3 iResolution; 
uniform float iGlobalTime;
varying vec2 fragCoord; 
float warp = 0.75; // simulate curvature of CRT monitor
float scan = 0.75; // simulate darkness between scanlines

void main()
{
	vec2 uv = fragCoord/iResolution.xy;
	vec2 dc = abs(0.5-uv);
	vec3 col = vec3(0.0);
	float scanlineIntesnsity = 0.050;
    float scanlineCount = 500.0;
    float scanlineYDelta = sin(iGlobalTime / 200.0);
	float scanline = sin((uv.y - scanlineYDelta) * scanlineCount) * scanlineIntesnsity;
	
	dc *= dc;
    
	uv.x -= 0.5; uv.x *= 1.0 + (dc.y * (0.3 * warp)); uv.x += 0.5;
	uv.y -= 0.5; uv.y *= 1.0 + (dc.x * (0.4 * warp)); uv.y += 0.5;

	col -= scanline;
	
	if (uv.y > 1.0 || uv.x < 0.0 || uv.x > 1.0 || uv.y < 0.0)
	{
	    gl_FragColor = vec4(0.0,0.0,0.0,1.0);
	}
	else
	{
		float apply = abs(sin(fragCoord.y) * 0.5 * scan);
		
		gl_FragColor = vec4(mix(texture2D(gm_BaseTexture,uv).rgb,vec3(0.0),apply),1.0) + vec4(col,1.0);
	}
}
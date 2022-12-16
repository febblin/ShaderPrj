/*
#ifdef позволяет коду работать на слабых телефонах, и мощных пк.Если шейдер используется на телефоне(GL_ES) то
используется низкая разрядность (точность) данных.(highp – высокая точность; mediump – средняя точность; lowp – низкая точность)
*/
#ifdef GL_ES
#define LOWP lowp
precision mediump float;
#else
#define LOWP 
#endif

varying LOWP vec4 v_color;
varying vec2 v_texCoords;
uniform sampler2D u_texture;

uniform vec2 resolution;
uniform float time;
uniform float factor;


vec2 rotate2d(vec2 uv, float a){
    float s = sin(a);
    float c = cos(a);
    return mat2(c, -s, s, c) * uv;
}

void main()
{
  vec2 uv = (gl_FragCoord.xy - 0.5 *resolution.xy) / resolution.y;
  vec3 col = vec3(0.0);

  uv = rotate2d(uv, 3.14 / 2.0);

  float r = 0.15;

  float i = 0.0;
  for (float t = 0.0;t<120.0;t++){
	i += factor;
	float a = i / 3.0;
    float dx = 2.0 * r * cos(a) - r * cos(2.0 * a);
    float dy = 2.0 * r * sin(a) + r * sin(2.0 * a);
    col += 0.01 * factor / length(uv - vec2(dx+0.1, dy));
	i++;
	if (i > 40.0)break;
  }

  i = 0.0;
  for (float t = 0.0;t<120.0;t++){
	i += factor;
	float a = i / 3.0;
    float dy = 2.0 * r * cos(a) - r * cos(2.0 * a);
    float dx = 2.0 * r * sin(a) + r * sin(2.0 * a);
    col += 0.01 * factor / length(uv - vec2(dx+0.1, dy));
	i++;
	if (i > 40.0)break;
  }

  i = 0.0;
    for (float t = 0.0;t<120.0;t++){
  	i += factor;
  	float a = i / 3.0;
      float dx = 2.0 * r * cos(a) - r * cos(2.0 * a);
      float dy = 2.0 * r * sin(a) - r * sin(2.0 * a);
      col += 0.01 * factor / length(uv - vec2(dx+0.1, dy));
  	i++;
  	if (i > 40.0)break;
    }

  col *= sin(vec3(0.2, 0.8, 0.9) * time) * 0.15 + 0.25;

  gl_FragColor = vec4(col, 1.00);
}
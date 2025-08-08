#version 450

in vec2 texCoord;
in vec4 color;
out vec4 FragColor;

uniform sampler2D mask;
uniform sampler2D tex;

void main() {
	vec4 texcolor = texture(tex, texCoord);
    vec4 maskcolor = texture(mask, texCoord);

    if (maskcolor.a == 0.0) {
        discard;
    }

    FragColor = texcolor;
}

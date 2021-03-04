#version 330

layout(location = 0) in vec3 position;

// Data from CPU
uniform mat4 MVP; // ModelViewProjection Matrix
uniform vec3 lightPosition;
uniform vec3 cameraPosition;
uniform float heightFactor;

// Texture-related data
uniform sampler2D heightMapTexture;
uniform int textureWidth;
uniform int textureHeight;

// Output to Fragment Shader
out vec2 textureCoordinate; // For texture-color
out vec3 vertexNormal; // For Lighting computation
out vec3 ToLightVector; // Vector from Vertex to Light;
out vec3 ToCameraVector; // Vector from Vertex to Camera;

float getY(in vec2 xz) {
    return heightFactor * texture(heightMapTexture, xz).r;
}

vec3 getNeighbourCoordinates(in float x, in float z) {
    float y = getY(vec2(1.0f - ((position.x + x) * (1.0f / textureWidth)), 1.0f - (position.z + z) * (1.0f / textureHeight)));
    return vec3(position.x + x, y, position.z + z);
}

void main() {
    textureCoordinate = vec2(1.0f - (position.x / textureWidth), 1.0f - (position.z / textureHeight));
    vec3 p = vec3(position.x, getY(textureCoordinate), position.z);
    ToCameraVector = normalize(cameraPosition - p);
    ToLightVector = normalize(lightPosition - p);
    vec3 l = getNeighbourCoordinates(-1.0f, 0.0f);
    vec3 r = getNeighbourCoordinates(1.0f, 0.0f);
    vec3 t = getNeighbourCoordinates(0.0f, -1.0f);
    vec3 b = getNeighbourCoordinates(0.0f, 1.0f);
    vec3 tr = getNeighbourCoordinates(1.0f, 1.0f);
    vec3 bl = getNeighbourCoordinates(-1.0f, -1.0f);
    vec3 n = cross(r - p, tr - p) + cross(tr - p, t - p) + cross(t - p, l - p) + cross(l - p, bl - p) + cross(bl - p, b - p) + cross(b - p, r - p);
    vertexNormal = normalize(n);
    gl_Position = MVP * vec4(p, 1.0f);
}

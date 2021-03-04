#include "helper.h"
#include "camera.h"
#include "scene.h"
#include "util.h"
#include "glm/glm.hpp"
#include "glm/gtx/transform.hpp"
#include "glm/gtx/rotate_vector.hpp"
#include "glm/gtc/type_ptr.hpp"
#include <bitset>

static GLFWwindow *win = nullptr;
int widthWindow = 1000, heightWindow = 1000;

// Shaders
GLuint idProgramShader;
GLuint idFragmentShader;
GLuint idVertexShader;
// extern by helper.h
GLuint idJpegTexture;
GLuint idHeightTexture;


// Locations
GLuint MVP_location;
GLuint cameraPosition_location;
GLuint lightPosition_location;
GLuint heightFactor_location;
GLuint textureWidth_location;
GLuint textureHeight_location;
GLuint heightMap_location;
GLuint rgbTexture_location;

// Buffers
GLuint idVertexArray;
GLuint idVertexBuffer;
GLuint idIndexBuffer;

int textureWidth, textureHeight;
bool isFullscreen = false;
//  0 WASD
//  4 QEHY
//  8 RFTG
// 12 LEFT RIGHT UP DOWN
std::bitset<16> mask;

// Geometry
glm::mat4 MVP;
Camera camera;
Scene scene;
std::string vertexShader = "shader.vert";
std::string fragmentShader = "shader.frag";

static void errorCallback(int error, const char *description) {
    fprintf(stderr, "Error: %s\n", description);
}

static void keyCallback(GLFWwindow *window, int key, int scancode, int action, int mods) {
    switch (key) {
        case GLFW_KEY_ESCAPE:
            if (action == GLFW_PRESS) {
                glfwSetWindowShouldClose(window, GLFW_TRUE);
            }
            break;
        case GLFW_KEY_P:
            if (action == GLFW_PRESS) {
                if (isFullscreen) {
                    isFullscreen = false;
                    widthWindow = 1000;
                    heightWindow = 1000;
                    exitFullScreen(win, widthWindow, heightWindow);
                } else {
                    isFullscreen = true;
                    makeFullScreen(win);
                }
            }
            break;
        case GLFW_KEY_W:
            if (action == GLFW_PRESS) {
                mask[0] = true;
            } else if (action == GLFW_RELEASE) {
                mask[0] = false;
            }
            break;
        case GLFW_KEY_S:
            if (action == GLFW_PRESS) {
                mask[2] = true;
            } else if (action == GLFW_RELEASE) {
                mask[2] = false;
            }
            break;
        case GLFW_KEY_A:
            if (action == GLFW_PRESS) {
                mask[1] = true;
            } else if (action == GLFW_RELEASE) {
                mask[1] = false;
            }
            break;
        case GLFW_KEY_D:
            if (action == GLFW_PRESS) {
                mask[3] = true;
            } else if (action == GLFW_RELEASE) {
                mask[3] = false;
            }
            break;
        case GLFW_KEY_Q:
            if (action == GLFW_PRESS) {
                mask[4] = true;
            } else if (action == GLFW_RELEASE) {
                mask[4] = false;
            }
            break;
        case GLFW_KEY_E:
            if (action == GLFW_PRESS) {
                mask[5] = true;
            } else if (action == GLFW_RELEASE) {
                mask[5] = false;
            }
            break;
        case GLFW_KEY_H:
            if (action == GLFW_PRESS) {
                mask[6] = true;
            } else if (action == GLFW_RELEASE) {
                mask[6] = false;
            }
            break;
        case GLFW_KEY_Y:
            if (action == GLFW_PRESS) {
                mask[7] = true;
            } else if (action == GLFW_RELEASE) {
                mask[7] = false;
            }
            break;
        case GLFW_KEY_X:
            camera.setSpeed(0.0f);
            mask[6] = false;
            mask[7] = false;
            break;
        case GLFW_KEY_I:
            camera.set(scene, MVP);
            camera.setSpeed(0);
            scene.setLightPos(glm::vec3(textureWidth / 2.0, 100, textureHeight / 2.0));
            break;
        case GLFW_KEY_R:
            if (action == GLFW_PRESS) {
                mask[8] = true;
            } else if (action == GLFW_RELEASE) {
                mask[8] = false;
            }
            break;
        case GLFW_KEY_F:
            if (action == GLFW_PRESS) {
                mask[9] = true;
            } else if (action == GLFW_RELEASE) {
                mask[9] = false;
            }
            break;
        case GLFW_KEY_T:
            if (action == GLFW_PRESS) {
                mask[10] = true;
            } else if (action == GLFW_RELEASE) {
                mask[10] = false;
            }
            break;
        case GLFW_KEY_G:
            if (action == GLFW_PRESS) {
                mask[11] = true;
            } else if (action == GLFW_RELEASE) {
                mask[11] = false;
            }
            break;
        case GLFW_KEY_RIGHT:
            if (action == GLFW_PRESS) {
                mask[13] = true;
            } else if (action == GLFW_RELEASE) {
                mask[13] = false;
            }
            break;
        case GLFW_KEY_LEFT:
            if (action == GLFW_PRESS) {
                mask[12] = true;
            } else if (action == GLFW_RELEASE) {
                mask[12] = false;
            }
            break;
        case GLFW_KEY_UP:
            if (action == GLFW_PRESS) {
                mask[14] = true;
            } else if (action == GLFW_RELEASE) {
                mask[14] = false;
            }
            break;
        case GLFW_KEY_DOWN:
            if (action == GLFW_PRESS) {
                mask[15] = true;
            } else if (action == GLFW_RELEASE) {
                mask[15] = false;
            }
            break;
        default:
            break;
    }
}

void createTriangles() {

    glGenVertexArrays(1, &idVertexArray);
    glBindVertexArray(idVertexArray);
    glGenBuffers(1, &idVertexBuffer);
    glBindBuffer(GL_ARRAY_BUFFER, idVertexBuffer);
    glGenBuffers(1, &idIndexBuffer);

    int numVertices = (textureWidth + 1) * (textureHeight + 1);
    int numTriangles = 2 * textureWidth * textureHeight;
    auto* vertices = new GLfloat[3 * numVertices];
    auto* indices = new GLuint[3 * numTriangles];
    auto** vertex_data = new float* [numVertices];
    for (int i = 0; i < numVertices; i++) {
        vertex_data[i] = new float[3];
    }

    // init vertices
    int c = 0;
    for (int h = 0; h <= textureHeight; h++) {
        for (int w = 0; w <= textureWidth; w++) {
            vertex_data[c][0] = (float)w;
            vertex_data[c][1] = 0.0f;
            vertex_data[c++][2] = (float)h;
        }
    }
    int j = 0;
    for (int i = 0; i < numVertices; i++) {
        vertices[j] = vertex_data[i][0];
        vertices[j + 1] = vertex_data[i][1];
        vertices[j + 2] = vertex_data[i][2];
        j += 3;
    }

    c = 0;
    for (int h = 0; h < textureHeight; h++) {
        for (int w = 0; w < textureWidth; w++) {
            indices[c++] = getIndex(w, h, textureWidth);
            indices[c++] = getIndex(w, h + 1, textureWidth);
            indices[c++] = getIndex(w + 1, h, textureWidth);

            indices[c++] = getIndex(w + 1, h + 1, textureWidth);
            indices[c++] = getIndex(w + 1, h, textureWidth);
            indices[c++] = getIndex(w, h + 1, textureWidth);
        }
    }

    glBufferData(GL_ARRAY_BUFFER, numVertices * 3 * sizeof(GLfloat), vertices, GL_STATIC_DRAW);

    glBindBuffer(GL_ELEMENT_ARRAY_BUFFER, idIndexBuffer);
    glBufferData(GL_ELEMENT_ARRAY_BUFFER, 3 * numTriangles * sizeof(GLuint), indices, GL_STATIC_DRAW);

    glVertexAttribPointer(0, 3, GL_FLOAT, GL_FALSE, 0, (void *) nullptr);

    glEnableVertexAttribArray(0);

    delete[] vertices;
    delete[] indices;
    for (int i = 0; i < numVertices; i++) {
        delete[] vertex_data[i];
    }
    delete[] vertex_data;

}

void sendVariables() {
    glUniformMatrix4fv(MVP_location, 1, GL_FALSE, glm::value_ptr(MVP));
    glUniform1f(heightFactor_location, scene.getHeightFactor());
    glUniform3fv(cameraPosition_location, 1, glm::value_ptr(camera.getPosition()));
    glUniform3fv(lightPosition_location, 1, glm::value_ptr(scene.getLightPos()));
}

void bindVariables() {

    MVP_location = glGetUniformLocation(idProgramShader, "MVP");
    cameraPosition_location = glGetUniformLocation(idProgramShader, "cameraPosition");
    lightPosition_location = glGetUniformLocation(idProgramShader, "lightPosition");
    heightFactor_location = glGetUniformLocation(idProgramShader, "heightFactor");
    textureWidth_location = glGetUniformLocation(idProgramShader, "textureWidth");
    textureHeight_location = glGetUniformLocation(idProgramShader, "textureHeight");
    heightMap_location = glGetUniformLocation(idProgramShader, "heightMapTexture");
    rgbTexture_location = glGetUniformLocation(idProgramShader, "rgbTexture");

    glUniform1i(textureWidth_location, scene.getImageWidth());
    glUniform1i(textureHeight_location, scene.getImageHeight());
    glUniform1i(heightMap_location, 1);
    glUniform1i(rgbTexture_location, 0);
    sendVariables();
}

void renderScene() {
    handleKeys(camera, scene, mask);
    // resize if needed
    glfwGetFramebufferSize(win, &widthWindow, &heightWindow);
    glViewport(0,0, widthWindow, heightWindow);
    glClear(GL_COLOR_BUFFER_BIT | GL_DEPTH_BUFFER_BIT);

    // update variables to be sent to shaders
    glm::vec3 newPos = glm::normalize(camera.getGaze());
    newPos *= camera.getSpeed();
    newPos += camera.getPosition();
    camera.setPosition(newPos);
    camera.calculateMVP(scene, MVP);

    // send variables to shaders again to update values
    sendVariables();
    // draw
    glDrawElements(GL_TRIANGLES, 3 * 2 * textureWidth * textureHeight, GL_UNSIGNED_INT, nullptr);

}

int main(int argc, char *argv[]) {

    if (argc != 3) {
        printf("Please provide height and texture image files!\n");
        exit(-1);
    }

    glfwSetErrorCallback(errorCallback);


    if (!glfwInit()) {
        exit(-1);
    }

    glfwWindowHint(GLFW_CONTEXT_VERSION_MAJOR, 3);
    glfwWindowHint(GLFW_CONTEXT_VERSION_MINOR, 2);

    glfwWindowHint(GLFW_OPENGL_PROFILE, GLFW_OPENGL_ANY_PROFILE); // This is required for remote
    // glfwWindowHint(GLFW_OPENGL_PROFILE, GLFW_OPENGL_ANY_PROFILE); // This might be used for local

    win = glfwCreateWindow(widthWindow, heightWindow, "CENG477 - HW4", nullptr, nullptr);

    if (!win) {
        glfwTerminate();
        exit(-1);
    }
    glfwMakeContextCurrent(win);
    glViewport(0, 0, 1000, 1000);

    GLenum err = glewInit();
    if (err != GLEW_OK) {
        fprintf(stderr, "Error: %s\n", glewGetErrorString(err));

        glfwTerminate();
        exit(-1);
    }

    glfwSetKeyCallback(win, keyCallback);
    glEnable(GL_DEPTH_TEST);

    initTexture(argv[1], argv[2], &textureWidth, &textureHeight);
    initShaders(idProgramShader, vertexShader, fragmentShader);
    createTriangles();
    camera = Camera();
    scene = Scene(textureWidth, textureHeight);
    camera.set(scene, MVP);
    //scene.setLightPos(glm::vec3(textureWidth / 2.0, 100, textureHeight / 2.0));
    glUseProgram(idProgramShader);
    bindVariables();
    while (!glfwWindowShouldClose(win)) {
        renderScene();
        glfwSwapBuffers(win);
        glfwPollEvents();
    }
    glfwDestroyWindow(win);
    glfwTerminate();
    return 0;
}

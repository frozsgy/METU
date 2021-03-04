
#include "util.h"

void turnOnLights() {
    // adapted from recitation slides
    glEnable(GL_LIGHTING);
    int i = 0;

    glEnable(GL_LIGHT0 + i);
    GLfloat amb[] = {1,1,1, 1.0f};
    GLfloat col[] = {100,100,100, 1.0f};
    GLfloat pos[] = {100,100,100, 1.0f};
    glLightfv(GL_LIGHT0 + i, GL_AMBIENT, amb);
    glLightfv(GL_LIGHT0 + i, GL_POSITION, pos);
    glLightfv(GL_LIGHT0 + i, GL_DIFFUSE, col);
    glLightfv(GL_LIGHT0 + i, GL_SPECULAR, col);
}

void makeFullScreen(GLFWwindow* win) {
    const GLFWvidmode* mode = glfwGetVideoMode(glfwGetPrimaryMonitor());
    glfwSetWindowMonitor(win, glfwGetPrimaryMonitor(), 0, 0, mode->width, mode->height, mode->refreshRate);
}

void exitFullScreen(GLFWwindow* win, int& widthWindow, int& heightWindow) {
    const GLFWvidmode* mode = glfwGetVideoMode(glfwGetPrimaryMonitor());
    glfwSetWindowMonitor(win, nullptr, 0, 0, widthWindow, heightWindow, mode->refreshRate);
}


int getIndex(int w, int h, int textureWidth) {
    return (textureWidth + 1) * h + w;
}


void handleKeys(Camera &camera, Scene &scene, std::bitset<16>& mask) {
    if (mask[0]) {
        // W
        camera.updateGaze(0.0f, -0.05f);
    }
    if (mask[1]) {
        // A
        camera.updateGaze(0.05f, 0.0f);
    }
    if (mask[2]) {
        // S
        camera.updateGaze(0.0f, 0.05f);
    }
    if (mask[3]) {
        // D
        camera.updateGaze(-0.05f, 0.0f);
    }
    if (mask[4]) {
        // Q
        camera.setPosition({camera.getPosition().x - 1, camera.getPosition().y, camera.getPosition().z});
    }
    if (mask[5]) {
        // E
        camera.setPosition({camera.getPosition().x + 1, camera.getPosition().y, camera.getPosition().z});
    }
    if (mask[6]) {
        // H
        camera.updateSpeed(-0.01f);
    }
    if (mask[7]) {
        // Y
        camera.updateSpeed(0.01f);
    }
    if (mask[8]) {
        // R
        scene.updateHeightFactor(0.5f);
    }
    if (mask[9]) {
        // F
        scene.updateHeightFactor(-0.5f);
    }
    if (mask[10]) {
        // T
        scene.moveLight({0.0f, -5.0f, 0.0f});
    }
    if (mask[11]) {
        // G
        scene.moveLight({0.0f, 5.0f, 0.0f});
    }
    if (mask[12]) {
        // LEFT
        scene.moveLight({5.0f, 0.0f, 0.0f});
    }
    if (mask[13]) {
        // RIGHT
        scene.moveLight({-5.0f, 0.0f, 0.0f});
    }
    if (mask[14]) {
        // UP
        scene.moveLight({0.0f, 0.0f, 5.0f});
    }
    if (mask[15]) {
        // DOWN
        scene.moveLight({0.0f, 0.0f, -5.0f});
    }
}

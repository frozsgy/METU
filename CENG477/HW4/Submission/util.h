//
// Created by ozan on 26.01.2021.
//

#ifndef HW4_UTIL_H
#define HW4_UTIL_H


#include "helper.h"
#include "camera.h"
#include "scene.h"
#include "glm/glm.hpp"
#include "glm/gtx/transform.hpp"
#include "glm/gtx/rotate_vector.hpp"
#include "glm/gtc/type_ptr.hpp"
#include <bitset>

void turnOnLights();

void makeFullScreen(GLFWwindow* win);

void exitFullScreen(GLFWwindow* win, int& widthWindow, int& heightWindow);

int getIndex(int w, int h, int textureWidth);

void handleKeys(Camera &camera, Scene &scene, std::bitset<16>& mask);

#endif //HW4_UTIL_H

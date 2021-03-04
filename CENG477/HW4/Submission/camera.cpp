
#include "camera.h"
#include <iostream>

Camera::Camera() {

}

Camera::Camera(const glm::vec3 &position, const glm::vec3 &gaze, const glm::vec3 &up, double speed) : position(
        position), gaze(gaze), up(up), speed(speed) {}


void Camera::updateGaze(double yaw, double pitch) {
    if (yaw != 0.0) {
        // calculate rotation matrix
        glm::mat4 rotationMatrix = glm::rotate(glm::mat4(1.0), (float) yaw, this->up);
        // rotate and set gaze,
        // no need to change left vector because it is not stored, it is calculated.
        this->setGaze(glm::normalize(glm::vec3(rotationMatrix * glm::vec4(this->getGaze(),0.0))));
    }
    else {
        // calculate left vector to find the axis of rotation
        glm:: vec3 leftVector = glm::normalize(glm::cross(this->up, this->getGaze()));
        // calculate rotation matrix
        glm::mat4 rotationMatrix = glm::rotate(glm::mat4(1.0), (float) pitch, leftVector);
        // rotate and set gaze,
        // calculate up vector and set it, left vector is not stored but used for recalculating up vector.
        this->setGaze(glm::normalize(glm::vec3(rotationMatrix * glm::vec4(this->getGaze(),0.0))));
        this->setUp(glm::normalize(glm::cross(this->getGaze(),leftVector)));
    }

}

void Camera::updateSpeed(double speed) {
    this->speed += speed;
}

void Camera::set(Scene &scene, glm::mat4 &MVP) {

    this->setPosition({scene.getImageWidth() / 2.0f, scene.getImageWidth() / 10.0f, scene.getImageWidth() / -4.0f});
    this->setGaze({0.0f, 0.0f, 1.0f});
    this->setUp({0.0f, 1.0f, 0.0f});
    /*this->setPosition({495, 380, -631});
    this->setGaze({0, -0.34, 0.94});
    this->setUp({-0.017, 0.94, 0.34});*/

    this->calculateMVP(scene, MVP);
}

void Camera::calculateMVP(Scene &scene, glm::mat4 &MVP) {
    glm::vec3 cameraPosition = this->getPosition();
    glm::vec3 cameraGaze = this->getGaze();
    glm::vec3 toLook = cameraPosition;
    toLook += cameraGaze;
    glm::vec3 cameraUp = this->getUp();

    MVP = glm::mat4(1.0);
    MVP = glm::lookAt(cameraPosition, toLook, cameraUp) * MVP;
    MVP = glm::perspective(glm::radians((float)scene.getAngle()), (float)scene.getAspectRatio(), (float)scene.getNearPlane(), (float)scene.getFarPlane()) * MVP;
}

const glm::vec3 &Camera::getPosition() const {
    return position;
}

void Camera::setPosition(const glm::vec3 &position) {
    Camera::position = position;
}

const glm::vec3 &Camera::getGaze() const {
    return gaze;
}

void Camera::setGaze(const glm::vec3 &gaze) {
    Camera::gaze = gaze;
}

const glm::vec3 &Camera::getUp() const {
    return up;
}

void Camera::setUp(const glm::vec3 &up) {
    Camera::up = up;
}

double Camera::getSpeed() const {
    return speed;
}

void Camera::setSpeed(double speed) {
    Camera::speed = speed;
}




#include "scene.h"

int Scene::getImageWidth() const {
    return image_width;
}

void Scene::setImageWidth(int imageWidth) {
    image_width = imageWidth;
}

int Scene::getImageHeight() const {
    return image_height;
}

void Scene::setImageHeight(int imageHeight) {
    image_height = imageHeight;
}

double Scene::getHeightFactor() const {
    return heightFactor;
}

void Scene::setHeightFactor(double heightFactor) {
    Scene::heightFactor = heightFactor;
}

const glm::vec3 &Scene::getLightPos() const {
    return lightPos;
}

void Scene::setLightPos(const glm::vec3 &lightPos) {
    Scene::lightPos = lightPos;
}

double Scene::getAngle() const {
    return angle;
}

double Scene::getAspectRatio() const {
    return aspectRatio;
}

double Scene::getNearPlane() const {
    return nearPlane;
}

double Scene::getFarPlane() const {
    return farPlane;
}


Scene::Scene() {


}

Scene::Scene(int imageWidth, int imageHeight) : image_width(imageWidth), image_height(imageHeight) {
    this->lightPos = {imageWidth/2.0f, 100, imageHeight/2.0f};
}

void Scene::updateHeightFactor(double heightFactor) {
    this->heightFactor += heightFactor;
}


void Scene::moveLight(const glm::vec3 &replacement) {
    this->lightPos += replacement;
}

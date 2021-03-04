#ifndef HW4_SCENE_H
#define HW4_SCENE_H

#include "glm/glm.hpp"


class Scene {

private:
    int image_width;
    int image_height;
    double heightFactor = 10.0f;
    double angle = 45;
    double aspectRatio = 1.0f;
    double nearPlane = 0.1f;
    double farPlane = 1000.0f;
    glm::vec3 lightPos;


public:

    Scene();

    Scene(int imageWidth, int imageHeight);


    int getImageWidth() const;

    void setImageWidth(int imageWidth);

    int getImageHeight() const;

    void setImageHeight(int imageHeight);

    double getHeightFactor() const;

    void setHeightFactor(double heightFactor);

    const glm::vec3 &getLightPos() const;

    void setLightPos(const glm::vec3 &lightPos);

    double getAngle() const;

    double getAspectRatio() const;

    double getNearPlane() const;

    double getFarPlane() const;

    void updateHeightFactor(double heightFactor);

    void moveLight(const glm::vec3 &replacement);

};


#endif //HW4_SCENE_H

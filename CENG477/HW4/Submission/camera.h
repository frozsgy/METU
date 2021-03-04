#ifndef HW4_CAMERA_H
#define HW4_CAMERA_H


#include "glm/glm.hpp"
#include "glm/gtx/transform.hpp"
#include "glm/gtc/matrix_transform.hpp"
#include "glm/gtx/rotate_vector.hpp"
#include "glm/gtc/type_ptr.hpp"
#include "scene.h"

class Camera {

private:
    glm::vec3 position;
    glm::vec3 gaze;
    glm::vec3 up;
    double speed = 0.0f;

public:

    Camera();

    Camera(const glm::vec3 &position, const glm::vec3 &gaze, const glm::vec3 &up, double speed);


    const glm::vec3 &getPosition() const;

    void setPosition(const glm::vec3 &position);

    const glm::vec3 &getGaze() const;

    void setGaze(const glm::vec3 &gaze);

    const glm::vec3 &getUp() const;

    void setUp(const glm::vec3 &up);

    double getSpeed() const;

    void setSpeed(double speed);


    void updateGaze(double yaw, double pitch);

    void updateSpeed(double speed);

    void set(Scene &scene, glm::mat4 &MVP);

    void calculateMVP(Scene &scene, glm::mat4 &MVP);

};


#endif //HW4_CAMERA_H

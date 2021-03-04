#include <iostream>
#include "parser.h"
#include <GL/glew.h>
#include <GLFW/glfw3.h>

// Sample usage for reading an XML scene file
parser::Scene scene;
static GLFWwindow *win = nullptr;

static void errorCallback(int error, const char *description) {
    fprintf(stderr, "Error: %s\n", description);
}

static void keyCallback(GLFWwindow *window, int key, int scancode, int action, int mods) {
    if (key == GLFW_KEY_ESCAPE && action == GLFW_PRESS)
        glfwSetWindowShouldClose(window, GLFW_TRUE);
}


GLuint gVertices;        // Vertex Buffer Objects for the terrain vertices
GLuint gNormals;         // vbo for normals
GLuint gIndices;         // vbo for vertex indices of triangles


double lastTime;
int nbFrames;

void showFPS(GLFWwindow *pWindow) {
    // taken from spheres.c, with slight modifications
    double currentTime = glfwGetTime();
    double delta = currentTime - lastTime;
    char ss[500] = {};
    nbFrames++;
    if (delta >= 0.5) {
        double fps = (double) nbFrames / delta;
        sprintf(ss, "CENG477 - HW3 [%.2lf FPS]", fps);
        glfwSetWindowTitle(pWindow, ss);
        nbFrames = 0;
        lastTime = currentTime;
    }
}

// vector util functions
parser::Vec3f normalize(parser::Vec3f &original) {
    float length = sqrt(original.x * original.x + original.y * original.y + original.z * original.z);
    return {original.x / length, original.y / length, original.z / length};
}

parser::Vec3f scale(parser::Vec3f &original, float scale) {
    return {original.x * scale, original.y * scale, original.z * scale};
}

parser::Vec3f add(parser::Vec3f v1, parser::Vec3f v2) {
    return {v1.x + v2.x, v1.y + v2.y, v1.z + v2.z};
}

parser::Vec3f subtract(parser::Vec3f v1, parser::Vec3f v2) {
    return {v1.x - v2.x, v1.y - v2.y, v1.z - v2.z};
}

parser::Vec3f cross(parser::Vec3f &v1, parser::Vec3f &v2) {
    return {v1.y * v2.z - v2.y * v1.z, v2.x * v1.z - v1.x * v2.z, v1.x * v2.y - v2.x * v1.y};
}

// render functions
void setCamera() {
    // adapted from recitation slides
    glViewport(0, 0, scene.camera.image_width, scene.camera.image_height);
    /* Set camera position */
    glMatrixMode(GL_MODELVIEW);
    glLoadIdentity();
    float m_vEye[3] = {scene.camera.position.x, scene.camera.position.y, scene.camera.position.z};
    parser::Vec3f vRef = add(scene.camera.position, scale(scene.camera.gaze, scene.camera.near_distance));
    float m_vRef[3] = {vRef.x, vRef.y, vRef.z};
    float m_vUp[3] = {scene.camera.up.x, scene.camera.up.y, scene.camera.up.z};
    gluLookAt(m_vEye[0], m_vEye[1], m_vEye[2], m_vRef[0], m_vRef[1], m_vRef[2], m_vUp[0], m_vUp[1], m_vUp[2]);
    /* Set projection frustum */
    glMatrixMode(GL_PROJECTION);
    glLoadIdentity();
    glFrustum(scene.camera.near_plane.x, scene.camera.near_plane.y, scene.camera.near_plane.z,
              scene.camera.near_plane.w, scene.camera.near_distance, scene.camera.far_distance);
}

void geometry() {
    // adapted from terrain.c
    GLfloat *vertices;
    GLfloat *normals;
    GLuint *indices;
    int i = 0;
    int j = 0;
    glGenBuffers(1, &gVertices);
    glGenBuffers(1, &gNormals);
    glGenBuffers(1, &gIndices);

    int numVertices = scene.vertex_data.size();
    int numTriangles = 0;
    int numMeshes = 0;
    for (const auto &m: scene.meshes) {
        numTriangles += m.faces.size();
        numMeshes++;
    }

    vertices = new GLfloat[3 * numVertices];
    normals = new GLfloat[3 * numVertices];
    indices = new GLuint[3 * numTriangles];
    for (i = 0; i < numVertices; i++) {
        vertices[j] = scene.vertex_data[i].x;
        normals[j] = 0;
        vertices[j + 1] = scene.vertex_data[i].y;
        normals[j + 1] = 0;
        vertices[j + 2] = scene.vertex_data[i].z;
        normals[j + 2] = 0;
        j += 3;
    }
    int cnt = 0;
    for (i = 0; i < numMeshes; i++) {
        for (j = 0; j < scene.meshes[i].faces.size(); j++) {
            indices[cnt * 3] = scene.meshes[i].faces[j].v0_id - 1;
            indices[cnt * 3 + 1] = scene.meshes[i].faces[j].v1_id - 1;
            indices[cnt * 3 + 2] = scene.meshes[i].faces[j].v2_id - 1;
            cnt++;
        }
    }
    cnt = 0;
    for (i = 0; i < numMeshes; i++) {
        for (j = 0; j < scene.meshes[i].faces.size(); j++) {
            parser::Vec3f e1, e2, norm;
            e1.x = vertices[indices[cnt * 3 + 1] * 3] - vertices[indices[cnt * 3] * 3];
            e1.y = vertices[indices[cnt * 3 + 1] * 3 + 1] - vertices[indices[cnt * 3] * 3 + 1];
            e1.z = vertices[indices[cnt * 3 + 1] * 3 + 2] - vertices[indices[cnt * 3] * 3 + 2];
            e2.x = vertices[indices[cnt * 3 + 2] * 3] - vertices[indices[cnt * 3] * 3];
            e2.y = vertices[indices[cnt * 3 + 2] * 3 + 1] - vertices[indices[cnt * 3] * 3 + 1];
            e2.z = vertices[indices[cnt * 3 + 2] * 3 + 2] - vertices[indices[cnt * 3] * 3 + 2];
            norm = cross(e1, e2);
            normals[indices[cnt * 3] * 3] += norm.x;
            normals[indices[cnt * 3] * 3 + 1] += norm.y;
            normals[indices[cnt * 3] * 3 + 2] += norm.z;
            normals[indices[cnt * 3 + 1] * 3] += norm.x;
            normals[indices[cnt * 3 + 1] * 3 + 1] += norm.y;
            normals[indices[cnt * 3 + 1] * 3 + 2] += norm.z;
            normals[indices[cnt * 3 + 2] * 3] += norm.x;
            normals[indices[cnt * 3 + 2] * 3 + 1] += norm.y;
            normals[indices[cnt * 3 + 2] * 3 + 2] += norm.z;
            cnt++;
        }
    }

    for (i = 0; i < numVertices; i++) {
        parser::Vec3f n = {normals[3 * i], normals[3 * i + 1], normals[3 * i + 2]};
        n = normalize(n);
        normals[3 * i] = n.x;
        normals[3 * i + 1] = n.y;
        normals[3 * i + 2] = n.z;
    }

    glBindBuffer(GL_ARRAY_BUFFER, gVertices);
    glBufferData(GL_ARRAY_BUFFER, numVertices * 3 * sizeof(GLfloat), vertices, GL_STATIC_DRAW);

    glBindBuffer(GL_ARRAY_BUFFER, gNormals);
    glBufferData(GL_ARRAY_BUFFER, numVertices * 3 * sizeof(GLfloat), normals, GL_STATIC_DRAW);

    glBindBuffer(GL_ELEMENT_ARRAY_BUFFER, gIndices);
    glBufferData(GL_ELEMENT_ARRAY_BUFFER, numTriangles * 3 * sizeof(GLuint), indices, GL_STATIC_DRAW);

    glBindBuffer(GL_ARRAY_BUFFER, 0);
    glBindBuffer(GL_ELEMENT_ARRAY_BUFFER, 0);

    delete[] vertices;
    delete[] normals;
    delete[] indices;
}

void turnOnLights() {
    // adapted from recitation slides
    glEnable(GL_LIGHTING);
    int i = 0;
    GLfloat amb[] = {scene.ambient_light.x, scene.ambient_light.y, scene.ambient_light.z, 1.0f};
    for (auto &l: scene.point_lights) {
        glEnable(GL_LIGHT0 + i);
        GLfloat col[] = {l.intensity.x, l.intensity.y, l.intensity.z, 1.0f};
        GLfloat pos[] = {l.position.x, l.position.y, l.position.z, 1.0f};
        glLightfv(GL_LIGHT0 + i, GL_AMBIENT, amb);
        glLightfv(GL_LIGHT0 + i, GL_POSITION, pos);
        glLightfv(GL_LIGHT0 + i, GL_DIFFUSE, col);
        glLightfv(GL_LIGHT0 + i, GL_SPECULAR, col);
        i++;
    }
}

void turnOffLights() {
    // adapted from recitation slides
    glDisable(GL_LIGHTING);
    int i = 0;
    for (auto &l: scene.point_lights) {
        glDisable(GL_LIGHT0 + i);
    }
}

int main(int argc, char *argv[]) {
    if (argc < 2) {
        std::cerr << "Missing xml file, example usage: ./hw3 horse.xml" << std::endl;
        exit(EXIT_FAILURE);
    }
    scene.loadFromXml(argv[1]);
    glfwSetErrorCallback(errorCallback);
    if (!glfwInit()) {
        exit(EXIT_FAILURE);
    }
    glfwWindowHint(GLFW_CONTEXT_VERSION_MAJOR, 2);
    glfwWindowHint(GLFW_CONTEXT_VERSION_MINOR, 1);
    win = glfwCreateWindow(scene.camera.image_width, scene.camera.image_height, "CENG477 - HW3", NULL, NULL);
    if (!win) {
        glfwTerminate();
        exit(EXIT_FAILURE);
    }
    glfwMakeContextCurrent(win);
    GLenum err = glewInit();
    if (err != GLEW_OK) {
        fprintf(stderr, "Error: %s\n", glewGetErrorString(err));
        exit(EXIT_FAILURE);
    }
    glfwSetKeyCallback(win, keyCallback);

    /*
     * steps
     * specify the location & parameters of the camera
     * specify the geometry
     * specify the lights
     */

    // initialize opengl stuff
    glClearColor(scene.background_color.x / 255., scene.background_color.y / 255., scene.background_color.z / 255.,
                 1.0);
    glClear(GL_COLOR_BUFFER_BIT | GL_DEPTH_BUFFER_BIT);
    glEnable(GL_DEPTH_TEST);
    //glEnable(GL_COLOR_MATERIAL);
    glEnableClientState(GL_VERTEX_ARRAY);
    glEnableClientState(GL_NORMAL_ARRAY);

    if (scene.culling_enabled) {
        glEnable(GL_CULL_FACE);
        if (scene.culling_face == 0) {
            glCullFace(GL_BACK);
        } else {
            glCullFace(GL_FRONT);
        }
    }
    glShadeModel(GL_SMOOTH);
    //glColorMaterial(GL_FRONT_AND_BACK, GL_AMBIENT_AND_DIFFUSE);


    //glEnable(GL_TEXTURE_2D);

    /*
    glEnable(GL_LIGHT0);
    glEnable(GL_LIGHT1);
    glColorMaterial(GL_FRONT_AND_BACK, GL_AMBIENT_AND_DIFFUSE);
    glEnable(GL_COLOR_MATERIAL);
    glEnable(GL_TEXTURE_2D);
    */
    // specify the lights
    turnOnLights();
    // specify the location & parameters of the camera
    setCamera();
    // specify the geometry
    geometry();


    while (!glfwWindowShouldClose(win)) {
        glfwWaitEvents();
        glClear(GL_COLOR_BUFFER_BIT | GL_DEPTH_BUFFER_BIT);
        glMatrixMode(GL_MODELVIEW);
        glClear(GL_DEPTH_BUFFER_BIT);
        glBindBuffer(GL_ARRAY_BUFFER, gVertices);
        glVertexPointer(3, GL_FLOAT, 0, 0);
        glBindBuffer(GL_ARRAY_BUFFER, gNormals);
        glNormalPointer(GL_FLOAT, 0, 0);


        int previous = 0;
        for (auto &m: scene.meshes) {
            glPushMatrix();
            // transformations
            parser::Vec3f t;
            for (auto it = m.transformations.rbegin(); it != m.transformations.rend(); it++) {
                switch (it->transformation_type[0]) {
                    case 'T':
                        t = scene.translations[it->id - 1];
                        glTranslatef(t.x, t.y, t.z);
                        break;
                    case 'S':
                        t = scene.scalings[it->id - 1];
                        glScalef(t.x, t.y, t.z);
                        break;
                    case 'R':
                        parser::Vec4f r = scene.rotations[it->id - 1];
                        glRotatef(r.x, r.y, r.z, r.w);
                        break;
                }
            }
            // material details
            GLfloat ambColor[4] = {scene.materials[m.material_id - 1].ambient.x,
                                  scene.materials[m.material_id - 1].ambient.y,
                                  scene.materials[m.material_id - 1].ambient.z, 1.0f};
            GLfloat diffColor[4] = {scene.materials[m.material_id - 1].diffuse.x,
                                  scene.materials[m.material_id - 1].diffuse.y,
                                  scene.materials[m.material_id - 1].diffuse.z, 1.0f};
            GLfloat specColor[4] = {scene.materials[m.material_id - 1].specular.x,
                                   scene.materials[m.material_id - 1].specular.y,
                                   scene.materials[m.material_id - 1].specular.z, 1.0f};
            GLfloat specExp[1] = {scene.materials[m.material_id - 1].phong_exponent};
            glMaterialfv(GL_FRONT, GL_AMBIENT, ambColor);
            glMaterialfv(GL_FRONT, GL_DIFFUSE, diffColor);
            glMaterialfv(GL_FRONT, GL_SPECULAR, specColor);
            glMaterialfv(GL_FRONT, GL_SHININESS, specExp);
            if (m.mesh_type == "Solid") {
                glPolygonMode(GL_FRONT_AND_BACK, GL_FILL);
            } else if (m.mesh_type == "Wireframe") {
                glPolygonMode(GL_FRONT_AND_BACK, GL_LINE);
            }

            glBindBuffer(GL_ELEMENT_ARRAY_BUFFER, gIndices);
            glDrawElements(GL_TRIANGLES, m.faces.size() * 3, GL_UNSIGNED_INT, reinterpret_cast<const void *>(previous));
            previous += m.faces.size() * 3 * sizeof(GLuint);
            glPopMatrix();

        }

        showFPS(win);

        glfwSwapBuffers(win);
    }

    glfwDestroyWindow(win);
    glfwTerminate();

    exit(EXIT_SUCCESS);

    return 0;
}

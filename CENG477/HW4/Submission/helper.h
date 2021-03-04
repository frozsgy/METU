#ifndef __HELPER__H__
#define __HELPER__H__

#include <iostream>
#include <string>
#include <fstream>
#include <jpeglib.h>
#include <GL/glew.h>
#include <GLFW/glfw3.h>

extern GLuint idProgramShader;
extern GLuint idFragmentShader;
extern GLuint idVertexShader;
extern GLuint idJpegTexture;
extern GLuint idHeightTexture;

using namespace std;

void initShaders(GLuint &programID, std::string &vertFile, std::string &fragFile);

GLuint initVertexShader(const string& filename);

GLuint initFragmentShader(const string& filename);

GLuint initGeomShader(const string& filename);

bool readDataFromFile(const string& fileName, string &data);

void initTexture(char *height_map_file, char *texture_map_file, int *w, int *h);

#endif

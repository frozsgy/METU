#include "helper.h"

void initShaders(GLuint &programID, std::string &vertFile, std::string &fragFile)
{

    programID = glCreateProgram();

    idVertexShader = initVertexShader(vertFile);
    idFragmentShader = initFragmentShader(fragFile);

    glAttachShader(programID, idVertexShader);
    glAttachShader(programID, idFragmentShader);

    glLinkProgram(programID);
}

GLuint initVertexShader(const string &filename)
{
    string shaderSource;

    if (!readDataFromFile(filename, shaderSource))
    {
        cout << "Cannot find file name: " + filename << endl;
        exit(-1);
    }

    GLint length = shaderSource.length();
    const GLchar *shader = (const GLchar *)shaderSource.c_str();

    GLuint vs = glCreateShader(GL_VERTEX_SHADER);
    glShaderSource(vs, 1, &shader, &length);
    glCompileShader(vs);

    char output[1024] = {0};
    glGetShaderInfoLog(vs, 1024, &length, output);
    printf("VS compile log: %s\n", output);

    return vs;
}

GLuint initFragmentShader(const string &filename)
{
    string shaderSource;

    if (!readDataFromFile(filename, shaderSource))
    {
        cout << "Cannot find file name: " + filename << endl;
        exit(-1);
    }

    GLint length = shaderSource.length();
    const GLchar *shader = (const GLchar *)shaderSource.c_str();

    GLuint fs = glCreateShader(GL_FRAGMENT_SHADER);
    glShaderSource(fs, 1, &shader, &length);
    glCompileShader(fs);

    char output[1024] = {0};
    glGetShaderInfoLog(fs, 1024, &length, output);
    printf("FS compile log: %s\n", output);

    return fs;
}

GLuint initGeomShader(const string &filename)
{
    string shaderSource;

    if (!readDataFromFile(filename, shaderSource))
    {
        cout << "Cannot find file name: " + filename << endl;
        exit(-1);
    }

    GLint length = shaderSource.length();
    const GLchar *shader = (const GLchar *)shaderSource.c_str();

    GLuint vs = glCreateShader(GL_GEOMETRY_SHADER);
    glShaderSource(vs, 1, &shader, &length);
    glCompileShader(vs);

    char output[1024] = {0};
    glGetShaderInfoLog(vs, 1024, &length, output);
    printf("GEO compile log: %s\n", output);

    return vs;
}

bool readDataFromFile(const string &fileName, string &data)
{
    fstream myfile;

    myfile.open(fileName.c_str(), std::ios::in);

    if (myfile.is_open())
    {
        string curLine;

        while (getline(myfile, curLine))
        {
            data += curLine;
            if (!myfile.eof())
                data += "\n";
        }

        myfile.close();
    }
    else
        return false;

    return true;
}

void initTexture(char *height_map_file, char *texture_map_file, int *w, int *h)
{
    int h_width, h_height, t_width, t_height;

    unsigned char *h_raw_image = NULL, *t_raw_image = NULL;
    int bytes_per_pixel = 3;   /* or 1 for GRACYSCALE images */
    int color_space = JCS_RGB; /* or JCS_GRAYSCALE for grayscale images */

    /* these are standard libjpeg structures for reading(decompression) */
    struct jpeg_decompress_struct h_cinfo, t_cinfo;
    struct jpeg_error_mgr h_jerr, t_jerr;

    /* libjpeg data structure for storing one row, that is, scanline of an image */
    JSAMPROW h_row_pointer[1], t_row_pointer[1];

    FILE *h_infile = fopen(height_map_file, "rb");
    FILE *t_infile = fopen(texture_map_file, "rb");
    unsigned long h_location = 0, t_location = 0;
    int h_i = 0, h_j = 0, t_i = 0, t_j = 0;

    if (!h_infile)
    {
        printf("Error opening jpeg file %s\n!", height_map_file);
        return;
    }

    if (!t_infile)
    {
        fclose(h_infile);
        printf("Error opening jpeg file %s\n!", height_map_file);
        return;
    }
    printf("Height map filename = %s\n", height_map_file);
    printf("Texture map filename = %s\n", texture_map_file);

    /* here we set up the standard libjpeg error handler */
    h_cinfo.err = jpeg_std_error(&h_jerr);
    t_cinfo.err = jpeg_std_error(&t_jerr);
    /* setup decompression process and source, then read JPEG header */
    jpeg_create_decompress(&h_cinfo);
    jpeg_create_decompress(&t_cinfo);
    /* this makes the library read from infile */
    jpeg_stdio_src(&h_cinfo, h_infile);
    jpeg_stdio_src(&t_cinfo, t_infile);
    /* reading the image header which contains image information */
    jpeg_read_header(&h_cinfo, TRUE);
    jpeg_read_header(&t_cinfo, TRUE);
    /* Start decompression jpeg here */
    jpeg_start_decompress(&h_cinfo);
    jpeg_start_decompress(&t_cinfo);

    /* allocate memory to hold the uncompressed image */
    h_raw_image = (unsigned char *)malloc(h_cinfo.output_width * h_cinfo.output_height * h_cinfo.num_components);
    t_raw_image = (unsigned char *)malloc(t_cinfo.output_width * t_cinfo.output_height * t_cinfo.num_components);
    /* now actually read the jpeg into the raw buffer */
    h_row_pointer[0] = (unsigned char *)malloc(h_cinfo.output_width * h_cinfo.num_components);
    t_row_pointer[0] = (unsigned char *)malloc(t_cinfo.output_width * t_cinfo.num_components);
    /* read one scan line at a time */
    while (h_cinfo.output_scanline < h_cinfo.image_height)
    {
        jpeg_read_scanlines(&h_cinfo, h_row_pointer, 1);
        for (h_i = 0; h_i < h_cinfo.image_width * h_cinfo.num_components; h_i++)
            h_raw_image[h_location++] = h_row_pointer[0][h_i];
    }
    
    while (t_cinfo.output_scanline < t_cinfo.image_height)
    {
        jpeg_read_scanlines(&t_cinfo, t_row_pointer, 1);
        for (t_i = 0; t_i < t_cinfo.image_width * t_cinfo.num_components; t_i++)
            t_raw_image[t_location++] = t_row_pointer[0][t_i];
    }

    h_height = h_cinfo.image_height;
    h_width = h_cinfo.image_width;

    t_height = t_cinfo.image_height;
    t_width = t_cinfo.image_width;

    if (t_height != h_height || t_width != h_width)
    {
        printf("Error opening jpeg files' sizes are not equal %s %s\n!", height_map_file, texture_map_file);
        free(h_row_pointer[0]);
        free(t_row_pointer[0]);

        free(h_raw_image);
        free(t_raw_image);

        fclose(h_infile);
        fclose(t_infile);

        return;
    }

    glGenTextures(1, &idJpegTexture);
    glActiveTexture(GL_TEXTURE0);
    glBindTexture(GL_TEXTURE_2D, idJpegTexture);
    glTexImage2D(GL_TEXTURE_2D, 0, GL_RGB, t_width, t_height, 0, GL_RGB, GL_UNSIGNED_BYTE, t_raw_image);
    glGenerateMipmap(GL_TEXTURE_2D);

    glGenTextures(1, &idHeightTexture);
    glActiveTexture(GL_TEXTURE1);
    glBindTexture(GL_TEXTURE_2D, idHeightTexture);
    glTexImage2D(GL_TEXTURE_2D, 0, GL_RGB, h_width, h_height, 0, GL_RGB, GL_UNSIGNED_BYTE, h_raw_image);
    glGenerateMipmap(GL_TEXTURE_2D);    
    

    *w = h_width;
    *h = h_height;

    /* wrap up decompression, destroy objects, free pointers and close open files */
    jpeg_finish_decompress(&h_cinfo);
    jpeg_destroy_decompress(&h_cinfo);

    jpeg_finish_decompress(&t_cinfo);
    jpeg_destroy_decompress(&t_cinfo);

    free(h_row_pointer[0]);
    free(t_row_pointer[0]);

    free(h_raw_image);
    free(t_raw_image);

    fclose(h_infile);
    fclose(t_infile);
}

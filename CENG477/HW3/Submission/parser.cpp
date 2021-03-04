#include "parser.h"
#include "tinyxml2.h"
#include <sstream>
#include <stdexcept>

void parser::Scene::loadFromXml(const std::string& filepath)
{
    tinyxml2::XMLDocument file;
    std::stringstream stream;

    auto res = file.LoadFile(filepath.c_str());
    if (res)
    {
        throw std::runtime_error("Error: The xml file cannot be loaded.");
    }

    auto root = file.FirstChild();
    if (!root)
    {
        throw std::runtime_error("Error: Root is not found.");
    }

    //Get BackgroundColor
    auto element = root->FirstChildElement("BackgroundColor");
    if (element)
    {
        stream << element->GetText() << std::endl;
    }
    else
    {
        stream << "0 0 0" << std::endl;
    }
    stream >> background_color.x >> background_color.y >> background_color.z;

    //Get CullingEnabled
    element = root->FirstChildElement("CullingEnabled");
    if (element)
    {
        stream << element->GetText() << std::endl;
    }
    else
    {
        stream << "0" << std::endl;
    }
    stream >> culling_enabled;
    
    //Get CullingFace
    element = root->FirstChildElement("CullingFace");
    if (element)
    {
        stream << element->GetText() << std::endl;
    }
    else
    {
        stream << "0" << std::endl;
    }
    stream >> culling_face;

    //Get Cameras
    element = root->FirstChildElement("Camera");
    auto child = element->FirstChildElement("Position");
    stream << child->GetText() << std::endl;
    child = element->FirstChildElement("Gaze");
    stream << child->GetText() << std::endl;
    child = element->FirstChildElement("Up");
    stream << child->GetText() << std::endl;
    child = element->FirstChildElement("NearPlane");
    stream << child->GetText() << std::endl;
    child = element->FirstChildElement("NearDistance");
    stream << child->GetText() << std::endl;
    child = element->FirstChildElement("FarDistance");
    stream << child->GetText() << std::endl;
    child = element->FirstChildElement("ImageResolution");
    stream << child->GetText() << std::endl;
    stream >> camera.position.x >> camera.position.y >> camera.position.z;
    stream >> camera.gaze.x >> camera.gaze.y >> camera.gaze.z;
    stream >> camera.up.x >> camera.up.y >> camera.up.z;
    stream >> camera.near_plane.x >> camera.near_plane.y >> camera.near_plane.z >> camera.near_plane.w;
    stream >> camera.near_distance;
    stream >> camera.far_distance;
    stream >> camera.image_width >> camera.image_height;

    //Get Lights
    element = root->FirstChildElement("Lights");
    child = element->FirstChildElement("AmbientLight");
    stream << child->GetText() << std::endl;
    stream >> ambient_light.x >> ambient_light.y >> ambient_light.z;
    element = element->FirstChildElement("PointLight");
    PointLight point_light;
    while (element)
    {
        child = element->FirstChildElement("Position");
        stream << child->GetText() << std::endl;
        child = element->FirstChildElement("Intensity");
        stream << child->GetText() << std::endl;

        stream >> point_light.position.x >> point_light.position.y >> point_light.position.z;
        stream >> point_light.intensity.x >> point_light.intensity.y >> point_light.intensity.z;

        point_lights.push_back(point_light);
        element = element->NextSiblingElement("PointLight");
    }

    //Get Materials
    element = root->FirstChildElement("Materials");
    element = element->FirstChildElement("Material");
    Material material;
    while (element)
    {
        child = element->FirstChildElement("AmbientReflectance");
        stream << child->GetText() << std::endl;
        child = element->FirstChildElement("DiffuseReflectance");
        stream << child->GetText() << std::endl;
        child = element->FirstChildElement("SpecularReflectance");
        stream << child->GetText() << std::endl;
        child = element->FirstChildElement("PhongExponent");
        stream << child->GetText() << std::endl;

        stream >> material.ambient.x >> material.ambient.y >> material.ambient.z;
        stream >> material.diffuse.x >> material.diffuse.y >> material.diffuse.z;
        stream >> material.specular.x >> material.specular.y >> material.specular.z;
        stream >> material.phong_exponent;

        materials.push_back(material);
        element = element->NextSiblingElement("Material");
    }

    //Get Translations
    element = root->FirstChildElement("Transformations");
    element = element->FirstChildElement("Translation");
    Vec3f translation;
    while (element)
    {
        stream << element->GetText() << std::endl;
        stream >> translation.x >> translation.y >> translation.z;
        translations.push_back(translation);
        
        element = element->NextSiblingElement("Translation");
    }

    //Get Scalings
    element = root->FirstChildElement("Transformations");
    element = element->FirstChildElement("Scaling");
    Vec3f scaling;
    while (element)
    {
        stream << element->GetText() << std::endl;
        stream >> scaling.x >> scaling.y >> scaling.z;
        scalings.push_back(scaling);
        
        element = element->NextSiblingElement("Scaling");
    }

    //Get Rotations
    element = root->FirstChildElement("Transformations");
    element = element->FirstChildElement("Rotation");
    Vec4f rotation;
    while (element)
    {
        stream << element->GetText() << std::endl;
        stream >> rotation.x >> rotation.y >> rotation.z >> rotation.w;
        rotations.push_back(rotation);
        
        element = element->NextSiblingElement("Rotation");
    }

    //Get VertexData
    element = root->FirstChildElement("VertexData");
    stream << element->GetText() << std::endl;
    Vec3f vertex;
    while (!(stream >> vertex.x).eof())
    {
        stream >> vertex.y >> vertex.z;
        vertex_data.push_back(vertex);
    }
    stream.clear();

    //Get Meshes
    element = root->FirstChildElement("Objects");
    element = element->FirstChildElement("Mesh");
    Mesh mesh;
    
    while (element)
    {
        child = element->FirstChildElement("MeshType");
        stream << child->GetText() << std::endl;
        stream >> mesh.mesh_type;
        child = element->FirstChildElement("Material");
        stream << child->GetText() << std::endl;
        stream >> mesh.material_id;

        //Get Transformations in order
        mesh.transformations.clear();
        child = element->FirstChildElement("Transformations");

        stream << child->GetText() << std::endl;

        std::string transformation_encoding;
        
        while(stream >> transformation_encoding && transformation_encoding.length()>0) {
            
                char transformation_type = transformation_encoding[0];
                int transformation_id = std::stoi (transformation_encoding.substr(1));
                
                Transformation transformation;
                switch (transformation_type) {
                    case 't':
                        transformation.transformation_type = "Translation";
                        break;
                    case 'r':
                        transformation.transformation_type = "Rotation";
                        break;
                    case 's':
                        transformation.transformation_type = "Scaling";
                        break;
                }

                transformation.id=transformation_id;
                mesh.transformations.push_back(transformation);
        }
        

        stream.clear();
        child = element->FirstChildElement("Faces");
        stream << child->GetText() << std::endl;
        Face face;
        while (!(stream >> face.v0_id).eof())
        {
            stream >> face.v1_id >> face.v2_id;
            mesh.faces.push_back(face);
        }
        stream.clear();

        meshes.push_back(mesh);
        mesh.faces.clear();
        element = element->NextSiblingElement("Mesh");
    }
    stream.clear();

}

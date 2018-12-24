#ifndef STOCKPHOTOWEBSTORE_H
#define STOCKPHOTOWEBSTORE_H

#include "tpbst.hpp"
#include "photo.hpp"

class StockPhotoWebstore //do not change this file
{
public:
    StockPhotoWebstore();

    StockPhotoWebstore &addPhoto(const Photo &photo);
    StockPhotoWebstore &removePhoto(const std::string &category, const std::string &name);
    StockPhotoWebstore &updatePrice(const std::string &category, const std::string &name, int newPrice);
    StockPhotoWebstore &printAllPhotos();
    StockPhotoWebstore &printAllPhotosInCategory(const std::string &category);
    StockPhotoWebstore &printPhoto(const std::string &category, const std::string &name);

private:
    TwoPhaseBST<Photo> tpbst;
};

#endif //STOCKPHOTOWEBSTORE_H

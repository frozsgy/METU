#include "photo.hpp"

// do not change this file.

Photo::Photo(const std::string &_category, const std::string &_name, const std::string &_resolution, int _price)
        : category(_category), name(_name), resolution(_resolution), price(_price) {}

const std::string &Photo::getCategory() const {
    return category;
}

const std::string &Photo::getName() const {
    return name;
}

const std::string &Photo::getResolution() const {
    return resolution;
}

int Photo::getPrice() const {
    return price;
}

void Photo::setPrice(int _price) {
    price = _price;
}

std::ostream &operator<<(std::ostream &output, const Photo &p) {
    std::string sep(";");

    output << p.category << sep;
    output << p.name << sep;
    output << p.resolution << sep;
    output << p.price;

    return output;
}
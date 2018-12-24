#ifndef PHOTO_H
#define PHOTO_H

#include <iostream>
#include <string>

class Photo { // do not change this file.
public:
    Photo(const std::string &, const std::string &, const std::string &, int);

    const std::string &getCategory() const;
    const std::string &getName() const;
    const std::string &getResolution() const;
    int getPrice() const;

    void setPrice(int);

    friend std::ostream &operator<<(std::ostream &, const Photo &);

private:
    const std::string category;
    const std::string name;
    const std::string resolution;
    int price;
};

#endif //PHOTO_H

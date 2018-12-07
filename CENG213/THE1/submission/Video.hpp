#ifndef VIDEO_HPP
#define	VIDEO_HPP

#include <string>
#include <iostream>

using namespace std;

class Video {
private:
    /* title is unique */
    string title;
    string genre;
public:
    Video();
    Video(string p_title, string p_genre = "");
    ~Video();
    const string& getTitle() const;
    void setTitle(const string& p_title);
    const string& getGenre() const;
    void setGenre(const string& p_genre);
    bool operator==(const Video & rhs) const;
    friend ostream& operator<<(ostream& out, const Video & video);
};

#endif	/* VIDEO_HPP */


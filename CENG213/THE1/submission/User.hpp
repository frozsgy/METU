#ifndef USER_HPP
#define	USER_HPP

#include <string>
#include <iostream>
#include "LinkedList.hpp"
#include "Video.hpp"

using namespace std;

/*....DO NOT EDIT BELOW....*/

enum Status {
    ACTIVE,
    SUSPENDED
};

class User {
private:
    /* username is unique */
    string username;
    string name;
    string surname;
    Status status;
    LinkedList< Video* > subscriptions;
    LinkedList< User* > friends;

public:
    User();
    User(string username, string name = "", string surname = "");
    ~User();
    const string& getUsername() const;
    const string& getName() const;
    const string& getSurname() const;
    Status getStatus() const;
    void updateStatus(Status st);
    void subscribe(Video * video);
    void unSubscribe(Video * video);
    void addFriend(User * user);
    void removeFriend(User * user);
    LinkedList<Video* > *getSubscriptions();
    LinkedList< User* > *getFriends();
    void printSubscriptions();
    void printFriends();
    bool operator==(const User& rhs) const;
    friend ostream& operator<<(ostream& out, const User & user);
};


#endif	/* USER_HPP */


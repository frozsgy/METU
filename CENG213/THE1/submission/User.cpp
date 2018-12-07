#include <iostream>
#include "User.hpp"
#include "Video.hpp"

void User::printSubscriptions() {
    Node< Video*> * first = subscriptions.first();
    while (first) {
        cout << *(first->getData());
        first = first->getNext();
    }
    cout << std::endl;
}

void User::printFriends() {
    Node< User*> * first = friends.first();
    while (first) {
        cout << *(first->getData());
        first = first->getNext();
    }
    cout << std::endl;
}

ostream& operator<<(ostream& out, const User & user) {
    string st = (user.status == ACTIVE) ? "active" : "suspended";
    out << "username:" << user.username << ",name:" << user.name << ",surname:" << user.surname << ",Status:" << st << endl;
    return out;
}

/* TO-DO: method implementations below */

User::User() {
  status=ACTIVE;
}

User::User(string username, string name, string surname) {
  this->username=username;
  if(name.size()) this->name=name;
  if(surname.size()) this->surname=surname;
  status=ACTIVE;
}

User::~User() {

}
const string& User::getUsername() const {
  return username;
}

const string& User::getName() const {
  return name;
}

const string& User::getSurname() const {
  return surname;
}

Status User::getStatus() const {
  return status;
}

void User::updateStatus(Status st) {
  this->status=st;
}

bool User::operator==(const User& rhs) const {
  return this->username==rhs.getUsername();
}

void User::addFriend(User * user) {
  (this->friends).insertNode((this->friends).getHead(), user);
}

void User::removeFriend(User * user) {
  Node<User*>* temp2=(this->friends).findNode(user);
  if(temp2) {
    Node<User*>* temp=(this->friends).findPrev(user);
    (this->friends).deleteNode(temp);
  }
}

LinkedList< User* >* User::getFriends() {
  return &friends;
}

LinkedList<Video* >* User::getSubscriptions() {
  return &subscriptions;
}

void User::subscribe(Video * video) {
  (this->subscriptions).insertNode((this->subscriptions).getHead(),video);
}

void User::unSubscribe(Video * video) {
  Node<Video*>* temp=(this->subscriptions).findNode(video);
  Node<Video*>* temp2=(this->subscriptions).findPrev(video);
  if(temp) {
    (this->subscriptions).deleteNode(temp2);
  }
}
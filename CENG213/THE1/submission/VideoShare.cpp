#include <iostream>
#include <fstream>
#include <sstream>
#include <string>
#include "VideoShare.hpp"
#include "User.hpp"

using namespace std;

void VideoShare::printAllVideos() {
    videos.print();
}

void VideoShare::printAllUsers() {
    users.print();
}

/* TO-DO: method implementations below */

VideoShare::VideoShare() {

}

VideoShare::~VideoShare() {

}

void VideoShare::loadUsers(const string & fileName) {
  string temp;
  string temp2[3];
  ifstream usersFile(fileName.c_str());
  while(getline(usersFile,temp)) {
    for(int i=0;i<3;i++) {
      int wh=temp.find(';');
      if(!i && !wh) {
        temp2[0]=temp2[1]=temp2[2]="";
        break;
      }
      temp2[i]=temp.substr(0, wh);
      temp.erase(0, wh+1);
    }
    if(temp2[0] != "") {
      createUser(temp2[0],temp2[1],temp2[2]);
    }
    temp2[0]=temp2[1]=temp2[2]="";
  }
  usersFile.close();
}

void VideoShare::createUser(const string & userName, const string & name, const string & surname) {
  User temp=User(userName,name,surname);
  (this->users).insertNode((this->users).getHead(),temp);
}

void VideoShare::createVideo(const string & title, const string & genre) {
  Video temp=Video(title,genre);
  (this->videos).insertNode((this->videos).getHead(),temp);
}

void VideoShare::loadVideos(const string & fileName) {
  string temp;
  string temp2[2];
  ifstream videosFile(fileName.c_str());
  while(getline(videosFile,temp)) {
    for(int i=0;i<2;i++) {
      int wh=temp.find(';');
      if(!i && !wh) {
        temp2[0]=temp2[1]="";
        break;
      }
      temp2[i]=temp.substr(0, wh);
      temp.erase(0, wh+1);
    }
    if(temp2[0] != "") {
      createVideo(temp2[0],temp2[1]);
    }
    temp2[0]=temp2[1]="";
  }
  videosFile.close();
}

void VideoShare::addFriendship(const string & userName1, const string & userName2) {
  Node<User>* temp1=(this->users).findNode(userName1);
  Node<User>* temp2=(this->users).findNode(userName2);
  if(temp1 && temp2) {
    (*temp1).getDataPtr()->addFriend(temp2->getDataPtr());
    (*temp2).getDataPtr()->addFriend(temp1->getDataPtr());
  }
}

void VideoShare::removeFriendship(const string & userName1, const string & userName2) {
  Node<User>* temp1=(this->users).findNode(userName1);
  Node<User>* temp2=(this->users).findNode(userName2);
  if(temp1 && temp2) {
    User* utemp1=temp1->getDataPtr();
    User* utemp2=temp2->getDataPtr();
    utemp1->removeFriend(utemp2);
    utemp2->removeFriend(utemp1);
  }
}

void VideoShare::updateUserStatus(const string & userName, Status newStatus) {
  Node<User>* temp=(this->users).findNode(userName);
  if(temp) {
    temp->getDataPtr()->updateStatus(newStatus);
  }
}

void VideoShare::printFriendsOfUser(const string & userName) {
  Node<User>* temp=(this->users).findNode(userName);
  if(temp) {
    temp->getDataPtr()->printFriends();
  }
}

void VideoShare::subscribe(const string & userName, const string & videoTitle) {
  Node<User>* temp=(this->users).findNode(userName);
  if(temp) {
    User* tempu=temp->getDataPtr();
    if(tempu->getStatus() == ACTIVE) {
      Node<Video>* tempv=(this->videos).findNode(videoTitle);
      if(tempv) {
        Video* tempvp=tempv->getDataPtr();
        tempu->subscribe(tempvp);
      }
    }
  }
}

void VideoShare::unSubscribe(const string & userName, const string & videoTitle) {
  Node<User>* temp=(this->users).findNode(userName);
  if(temp) {
    User* tempu=temp->getDataPtr();
    if(tempu->getStatus() == ACTIVE) {
      Node<Video>* tempv=(this->videos).findNode(videoTitle);
      if(tempv) {
        Video* tempvp=tempv->getDataPtr();
        tempu->unSubscribe(tempvp);
      }
    }
  }
}

void VideoShare::printUserSubscriptions(const string & userName) {
  Node<User>* temp=(this->users).findNode(userName);
  if(temp) {
    temp->getDataPtr()->printSubscriptions();
  }
}

void bubbleSort(LinkedList<Video*>* lister, int n) {
  bool sorted=false;
  for(int i=0;(i<n-1) && !sorted;i++) {
    sorted=true;
    for(int j=1;j<=n-i-1;j++) {
      Node<Video*> *walk, *ajm1, *aj;
      int wai=0;
      walk=lister->first();
      while(wai!=(j-1)) {
        walk=walk->getNext();
        wai++;
      }
      ajm1=walk;
      aj=walk->getNext();
      if((*(ajm1->getDataPtr()))->getTitle() > (*(aj->getDataPtr()))->getTitle()) {
        lister->swap(j,j-1);
      }
      sorted=false;
    }
  }
}

void VideoShare::sortUserSubscriptions(const string & userName) {
  Node<User>* temp=(this->users).findNode(userName);
  if(temp) {
    LinkedList<Video* >* subscriptions=(*temp).getDataPtr()->getSubscriptions();
    bubbleSort(subscriptions,subscriptions->getLength());
  }
}

void VideoShare::deleteUser(const string & userName) {
  Node<User>* waif=(this->users).findNode(userName);
  if(waif) {
    User* wai=waif->getDataPtr();
    Node<User>* walk=(this->users).first();
    while(walk) {
      User* temp=walk->getDataPtr();
      if(temp) {
        LinkedList<User*>* amis=temp->getFriends();
        if(amis->findNode(wai)) {
          temp->removeFriend(wai);
        }
        walk=walk->getNext();
      }
    }
    LinkedList<User*>* mesamis=wai->getFriends();
    mesamis->clear();
    users.deleteNode(users.findPrev(userName));
  }
}

void VideoShare::printCommonSubscriptions(const string & userName1, const string & userName2) {
  LinkedList<Video*> *temp1, *temp2;
  Node<User>* waif1=(this->users).findNode(userName1);
  Node<User>* waif2=(this->users).findNode(userName2);
  if(waif1 && waif2) {
    User* wai1=waif1->getDataPtr();
    User* wai2=waif2->getDataPtr();
    LinkedList<Video*> result=LinkedList<Video*>();
    LinkedList<Video*> *results=&result;
    temp1=wai1->getSubscriptions();
    temp2=wai2->getSubscriptions();
    Node<Video*> *myVideos1, *myVideos2;
    myVideos1=temp1->first();
    while(myVideos1) {
      if(myVideos1->getDataPtr()) {
        myVideos2=temp2->first();
        while(myVideos2) {
          if(myVideos2->getDataPtr()) {
           if((myVideos1->getData())->getTitle()==(myVideos2->getData())->getTitle()) {
             results->insertNode(results->getHead(),myVideos1->getData());
           }
          }
          myVideos2=myVideos2->getNext();
        }
      }
      myVideos1=myVideos1->getNext();
    }
    bubbleSort(results,results->getLength());
    Node<Video*> *walk=results->first();
    while(walk) {
      cout << *(walk->getData());
      walk=walk->getNext();
    }
    cout << endl;
  }
}

void VideoShare::printFriendSubscriptions(const string & userName) {
  LinkedList<Video*>* temp;
  Node<User>* waif=(this->users).findNode(userName);
  if(waif) {
    User* wai=waif->getDataPtr();
    LinkedList<User*>* mesamis=wai->getFriends();
    LinkedList<Video*> result=LinkedList<Video*>();
    LinkedList<Video*> *results=&result;
    if(mesamis->first()) {
      Node<User*>* myFriends=mesamis->first();
      while(myFriends) {
        if(myFriends->getDataPtr()) {
          temp=(*(myFriends->getDataPtr()))->getSubscriptions();
          Node<Video*>* myVideos;
          if(temp->first()) {
            myVideos=temp->first();
            while(myVideos) {
              if(myVideos->getDataPtr()) {
                 if(!results->findNode(myVideos->getData())) {
                   results->insertNode(results->getHead(),myVideos->getData());
                 }
             }
              myVideos=myVideos->getNext();
            }
          }
          myFriends=myFriends->getNext();
        }
      }
    }
    bubbleSort(results,results->getLength());
    Node<Video*> *walk=results->first();
    while(walk) {
      cout << *(walk->getData());
      walk=walk->getNext();
    }
    cout << endl;
  }
}

bool VideoShare::isConnected(const string & userName1, const string & userName2) {
  if(!((this->users).findNode(userName1)) || !((this->users).findNode(userName2))) {
    return false;
  }
  if(userName1 == userName2) {
    return true;
  }
  User* wai1=((this->users).findNode(userName1))->getDataPtr();
  LinkedList<User*>* mesamis1=wai1->getFriends();
  User* wai2=((this->users).findNode(userName2))->getDataPtr();
  if(mesamis1->findNode(wai2)) {
    return true;
  }
  if(mesamis1->first()) {
    Node<User*>* myFriends1 = mesamis1->first();
    while(myFriends1) {
      string ut1=myFriends1->getData()->getUsername();
      bool test1=isConnected(ut1,userName2);
      if(!test1) {
        myFriends1=myFriends1->getNext();
      }
      else {
        return true;
      }

    }
  }
  return false;
}

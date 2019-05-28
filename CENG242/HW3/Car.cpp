#include "Car.h"

/*
YOU MUST WRITE THE IMPLEMENTATIONS OF THE REQUESTED FUNCTIONS
IN THIS FILE. START YOUR IMPLEMENTATIONS BELOW THIS LINE
*/

#include "Utilizer.h"

Car::Car(std::string driver_name) {
  this->driver_name=driver_name;
  this->performance=Utilizer::generatePerformance();
  this->head=nullptr;
  this->next=nullptr;
}

Car::Car(const Car& rhs) {
  this->driver_name=rhs.getDriverName();
  this->performance=rhs.getPerformance();
  Laptime* walk=rhs.getLaptime();
  Laptime* prev=nullptr;
  Laptime* first=nullptr;
  int count=0;
  while(walk) {
    Laptime* temp=new Laptime(walk->getLaptime());
    if(count == 0) first=temp;
    this->laptimeGarbage.push_back(temp);
    if(prev) {
      prev->addLaptime(temp);
    }
    prev=temp;
    count++;
    walk=walk->getNext();
  }
  this->head=first;
  //this->head=rhs.getLaptime();
  this->next=nullptr;
}

Car::Car(const Car *rhs) {
  this->driver_name=rhs->getDriverName();
  this->performance=rhs->getPerformance();
  this->head=nullptr;
  this->next=nullptr;
}

Car::~Car() {
  if(this->head) {
    Laptime * temp=this->head;
    Laptime * next=nullptr;
    while(temp->getNext()) {
      next=temp->getNext();
      delete temp;
      temp=next;
    }
    delete temp;
  }
  /*for(auto i:laptimeGarbage) {
    delete i;
  }*/
}

std::string Car::getDriverName() const {
  return this->driver_name;
}

double Car::getPerformance() const {
  return this->performance;
}

void Car::addCar(Car *next) {
  this->next=next;
}

bool Car::operator<(const Car& rhs) const {
  Laptime r(0);
  Laptime l(0);
  if(this->head) l=this->head->getTotalLaptime();
  if(rhs.head) r=rhs.head->getTotalLaptime();
  return l < r;
}

bool Car::operator>(const Car& rhs) const {
  Laptime r(0);
  Laptime l(0);
  if(this->head) l=this->head->getTotalLaptime();
  if(rhs.head) r=rhs.head->getTotalLaptime();
  return l > r;
}

Laptime Car::operator[](const int lap) const {
  Laptime* temp=this->head;
  for(int i=0;i<lap;i++) {
    if(temp->getNext()) {
      temp=temp->getNext();
    }
    else {
      temp=nullptr;
      break;
    }
  }
  if(temp) {
    return *temp;
  }
  else {
    return Laptime(0);
  }
}

void Car::Lap(const Laptime& average_laptime) {
  int myLaptime=Utilizer::generateLaptimeVariance(this->performance)+average_laptime.getLaptime();
  Laptime* adder=new Laptime(myLaptime);
  if(this->head) {
    Laptime * temp=this->head;
    while(temp->getNext()) {
      temp=temp->getNext();
    }
    temp->addLaptime(adder);
  }
  else {
    this->head=adder;
  }
}

std::ostream& operator<<(std::ostream& os, const Car& car) {
  Laptime * temp=car.head;
  char name[4];
  int j=0;
  while((car.driver_name)[j] != ' ') j++;
  j++;
  for(int i=0;i<3;i++) {
    if((car.driver_name)[j+i] > 96) {
      name[i]=(car.driver_name)[j+i]-32;
    }
    else {
      name[i]=(car.driver_name)[j+i];
    }
  }
  name[3]='\0';
  os << name << "--"  << temp->getLastLaptime() << "--" << temp->getFastestLaptime() << "--" << temp->getTotalLaptime(); // << std::endl;
  return os;
}

Car* Car::getNext() {
  return this->next;
}

Laptime Car::getLastLaptime() {
  return this->head->getLastLaptime();
}

Laptime Car::getFastestLaptime() {
  return this->head->getFastestLaptime();
}

void Car::removeLap() {
  Laptime* walk=this->head;
  Laptime* prev=nullptr;
  while(walk->getNext()) {
    prev=walk;
    walk=walk->getNext();
  }
  delete walk;
  if(prev) {
    prev->addLaptime(nullptr);
  }
  else {
    this->head=nullptr;
  }
}

Laptime Car::getTotalLaptime() {
  return this->head->getTotalLaptime();
}
int Car::getTotalLapCount() const {
  if(this->head) {
    return this->head->getTotalLapCount();
  }
  return 0;
}

Laptime* Car::getLaptime() const {
  return this->head;
}

std::string Car::getInitials() const {
  Laptime * temp=this->head;
  char name[4];
  int j=0;
  while((this->driver_name)[j] != ' ') j++;
  j++;
  for(int i=0;i<3;i++) {
    if((this->driver_name)[j+i] > 96) {
      name[i]=(this->driver_name)[j+i]-32;
    }
    else {
      name[i]=(this->driver_name)[j+i];
    }
  }
  name[3]='\0';
  return name;
}

std::string Car::getDriverNameV() {
  return this->driver_name;
}

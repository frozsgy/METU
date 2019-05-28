#include "Laptime.h"

/*
YOU MUST WRITE THE IMPLEMENTATIONS OF THE REQUESTED FUNCTIONS
IN THIS FILE. START YOUR IMPLEMENTATIONS BELOW THIS LINE
*/

Laptime::Laptime(int laptime) {
  this->laptime=laptime;
  this->next=nullptr;
}

Laptime::Laptime(const Laptime& rhs) {
  this->laptime=rhs.getLaptime();
  this->next=rhs.getNextConst();
}

Laptime::~Laptime() {
}

void Laptime::addLaptime(Laptime *next) {
  this->next=next;
}

bool Laptime::operator<(const Laptime& rhs) const {
  return (this->laptime)<(rhs.laptime);
}

bool Laptime::operator>(const Laptime& rhs) const {
  return (this->laptime)>(rhs.laptime);
}

Laptime& Laptime::operator+(const Laptime& rhs) {
  this->laptime=this->laptime+rhs.laptime;
  return *this;
}

std::ostream& operator<<(std::ostream& os, const Laptime& laptime) {
  int minutes=laptime.laptime/60000;
  int seconds=laptime.laptime/1000 - minutes*60;
  int miliseconds=laptime.laptime % 1000;
  char laps[200];
  sprintf(laps,"%d:%02d.%03d",minutes,seconds,miliseconds);
  os << laps; //minutes << ":" << seconds << "." << miliseconds;
  return os;
}

Laptime* Laptime::getNext() {
  return this->next;
}

Laptime* Laptime::getNextConst() const {
  return this->next;
}

int Laptime::getLaptime() const {
  if(this) {
    return this->laptime;
  }
  return 0;
}

Laptime Laptime::getLastLaptime() const{
  Laptime temp2=*this;
  Laptime *temp=&temp2;
  while(temp->getNext()) {
    temp=temp->getNext();
  }
  return *temp;
}

Laptime Laptime::getTotalLaptime() const {
  int total=0;
  Laptime temp2=*this;
  Laptime *temp=&temp2;
  while(temp) {
    total+=temp->laptime;
    temp=temp->getNext();
  }
  return Laptime(total);
}

Laptime Laptime::getFastestLaptime() const {
  Laptime temp2=*this;
  Laptime *temp=&temp2;
  Laptime *fastest=&temp2;
  while(temp) {
    if(*fastest > *temp) {
      fastest=temp;
    }
    temp=temp->getNext();
  }
  return *fastest;
}

bool Laptime::operator==(const Laptime& rhs) const {
  if(this) {
    return (this->laptime)==(rhs.getLaptime());
  }
  return false;
}

int Laptime::getTotalLapCount() const {
  int total=0;
  Laptime temp2=*this;
  Laptime *temp=&temp2;
  while(temp) {
    total++;
    temp=temp->getNext();
  }
  return total;
}

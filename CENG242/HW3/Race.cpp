#include "Race.h"

/*
YOU MUST WRITE THE IMPLEMENTATIONS OF THE REQUESTED FUNCTIONS
IN THIS FILE. START YOUR IMPLEMENTATIONS BELOW THIS LINE
*/

#include "Utilizer.h"
#include <iostream>
#include <random>

Race::Race(std::string race_name) : average_laptime(Utilizer::generateAverageLaptime()) {
  this->race_name=race_name;
  this->head=nullptr;
  this->seed=1;
}

Race::Race(const Race& rhs) : average_laptime(rhs.average_laptime) {
  this->race_name=race_name;
  Car* temp=rhs.head;
  Car* next=this->head;
  this->head=nullptr;
  int c=0;
  Car* prev=nullptr;
  while(temp) {
    Car* addCar=new Car(temp); //don't forget to free them!!!
  //  addCar->clearLaptimes();
    garbageCar.push_back(addCar);
    next=addCar;
    if(!c) this->head=addCar;
    else if (prev) prev->addCar(addCar);
    prev=addCar;
    next=next->getNext();
    temp=temp->getNext();
    c++;
  }
  this->seed=1;
}

Race::~Race() {
  // DONT FORGET TO FREE THE CARS IF YOU DEEP COPIED THEM!!!
  for(auto i:garbageCar) {
    delete i;
  }
}

std::string Race::getRaceName() const {
  return this->race_name;
}

void Race::addCartoRace() {
  char uppercase[]="ABCDEFGHIJKLMNOPQRSTUVWXYZ";
  char lowercase[]="abcdefghijklmnopqrstuvwxyz";
  std::string randomName;
  std::default_random_engine re;
  for(int i=0;i<31;i++) {
  	    std::uniform_int_distribution<int> distribution(seed,4648916);
        if(i == 0 || i == 16) randomName+=uppercase[distribution(re) % 25];
        else if (i == 15) randomName+=" ";
        else randomName+=lowercase[distribution(re) % 25];
        seed+=79;
    }
  Car* newCar=new Car(randomName); //don't forget to free them!!!
  garbageCar.push_back(newCar);
  Car* next=this->head;
  if(!next) {
    this->head=newCar;
  }
  else {
    while(next->getNext()) {
      next=next->getNext();
    }
    next->addCar(newCar);
  }
}

void Race::addCartoRace(Car& car) {
  Car* next=this->head;
  if(!next) {
    this->head=&car;
  }
  else {
    while(next->getNext()) {
      next=next->getNext();
    }
    next->addCar(&car);
  }
}

int Race::getNumberOfCarsinRace() {
  int res=0;
  Car* next=this->head;
  while(next) {
    next=next->getNext();
    res++;
  }
  return res;
}

int Race::getNumberOfCarsinRaceConst() const {
  int res=0;
  Car* next=this->head;
  while(next) {
    next=next->getNext();
    res++;
  }
  return res;
}

void Race::goBacktoLap(int lap) {
  if(this->head) {
    int total=this->head->getTotalLapCount();
    for(int i=lap;i<total-1;i++) --(*this);
  }
}

void Race::operator++() {
  Car* next=this->head;
  if(next) {
    while(next) {
      next->Lap(this->average_laptime);
      next=next->getNext();
    }
    next=this->head;
    if(next->getNext() && next->getTotalLapCount() > 0)
    bubbleSort(next,this->getNumberOfCarsinRace());
  }
}

void Race::operator--() {
  Car* next=this->head;
  if(next) {
    while(next) {
      next->removeLap();
      next=next->getNext();
    }
    next=this->head;
    if(next->getNext() && next->getTotalLapCount() > 0)
    bubbleSort(next,this->getNumberOfCarsinRace());
  }
}

Car& Race::operator[](const int car_in_position) {
  Car* temp=this->head;
  for(int i=0;i<car_in_position;i++) {
    temp=temp->getNext();
  }
  return *temp;
}

Car& Race::operator[](std::string driver_name) {
  Car* temp=this->head;
  for(int i=0;i<this->getNumberOfCarsinRace();i++) {
    if(temp->getDriverName() == driver_name) break;
    temp=temp->getNext();
  }
  return *temp;
}

Race& Race::operator=(const Race& rhs) {
  this->race_name=rhs.getRaceName();
  this->average_laptime=rhs.getAverageLaptime();
  this->head=rhs.getHeadPtr();
  return *this;
}

std::ostream& operator<<(std::ostream& os, const Race& race) {
  int totalcars=race.getNumberOfCarsinRaceConst();
  Car* walk=race.head;
  int digits=0;
  int temp=totalcars;
  int fastest=-1;
  Laptime tlap=walk->getFastestLaptime();
  int points[10]={25,18,15,12,10,8,6,4,2,1};
  while(temp) {
    temp=temp/10;
    digits++;
  }
  for(int i=0;i<totalcars;i++) {
    if(walk->getFastestLaptime() < tlap) tlap=walk->getFastestLaptime();
    walk=walk->getNext();
  }
  walk=race.head;
  for(int i=0;i<totalcars;i++) {
    char wh[digits];
    sprintf(wh,"%0*d",digits,i+1);
    os << wh << "--" << *walk;
    if(i<10) os << "--" << points[i];
    else os << "--0";
    if(walk->getFastestLaptime() == tlap && i < 10)
    os << "--" << "1";
    if(walk->getNext())
    os << std::endl;
    walk=walk->getNext();
  }
  return os;
}

void Race::bubbleSort(Car* lister, int n) {
  Car* smallest=lister;
  Car* move=lister;
  Car *fprev, *fnext;
  while(move) {
    if(*move < *smallest) {
      smallest=move;
      fnext=move->getNext();
    }
    move=move->getNext();
  }
  move=lister;
  while(move) {
    if(move->getNext() == smallest) {
      fprev=move;
    }
    move=move->getNext();
  }
  if(smallest != lister) {
    //change first
    Car *firstt=this->head;
    this->head=smallest;
    smallest->addCar(firstt);
    fprev->addCar(fnext);
  }
  bool sorted=false;
  for(int i=0;(i<n-1) && !sorted;i++) {
    sorted=true;
    for(int j=1;j<=n-i-1;j++) { //first item should be checked
      Car *walk, *ajm1, *aj, *pjm1, *pj;
      int wai=0;
      walk=this->head;
      pjm1=this->head;
      while(wai!=(j-1)) {
        pjm1=walk;
        walk=walk->getNext();
        wai++;
      }
      ajm1=walk;
      aj=walk->getNext();
      pj=aj->getNext();
      if(*ajm1 > *aj) {
        pjm1->addCar(aj);
        aj->addCar(ajm1);
        ajm1->addCar(pj);
      }
      sorted=false;
    }
  }
}

void Race::printCars() {
  Car *walk = this->head;
  for(int i=0;i<getNumberOfCarsinRace();i++) {
    if(walk) {
      std::cout << walk->getDriverName() << /*" - " << walk->getLastLaptime() << */std::endl;
    }
    walk=walk->getNext();
  }
}

Laptime Race::getAverageLaptime() const {
  return this->average_laptime;
}

Car*  Race::getHeadPtr() const {
  return this->head;
}

std::string Race::getInitials() const {
  return this->head->getInitials();
}

int Race::getPoints(std::string name) const {
  int totalcars=this->getNumberOfCarsinRaceConst();
  Car* walk=this->head;
  int total=0;
  Laptime tlap=walk->getFastestLaptime();
  int points[10]={25,18,15,12,10,8,6,4,2,1};

  for(int i=0;i<totalcars;i++) {
    if(walk->getFastestLaptime() < tlap) tlap=walk->getFastestLaptime();
    walk=walk->getNext();
  }
  walk=this->head;
  for(int i=0;i<totalcars;i++) {
    if(name == walk->getDriverName()) {
      if(i<10) total+=points[i];
      if(walk->getFastestLaptime() == tlap && i < 10)
      total+=1;
    }
    walk=walk->getNext();
  }
  return total;
}
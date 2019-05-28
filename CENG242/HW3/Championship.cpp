#include "Championship.h"

/*
YOU MUST WRITE THE IMPLEMENTATIONS OF THE REQUESTED FUNCTIONS
IN THIS FILE. START YOUR IMPLEMENTATIONS BELOW THIS LINE
*/

#include <iostream>
#include <algorithm>
Championship::Championship() {

}

Championship::Championship(const Championship& rhs) {
  int size=rhs.races.size();
  this->races.resize(size);
  for(int i=0;i<size;i++) {
    Race* newest=new Race(rhs.races[i]->getRaceName());
    for(int j=0;j<rhs.races[i]->getNumberOfCarsinRace();j++) {
      Car* tempCar=new Car((*(rhs.races[i]))[j]);
      newest->addCartoRace(*tempCar);
      this->garbageCar.push_back(tempCar);
    }
    this->garbage.push_back(newest);
    this->races.push_back(newest);
    this->races[i]=newest;
  }
}

Championship::~Championship() {
  // clean the garbage vector contents !!!
  for(auto i:garbage) {
    delete i;
  }
  for(auto i:garbageCar) {
    delete i;
  }
}

void Championship::addNewRace(Race& race) {
  // deep copy the race here.
  this->races.push_back(&race);
}

void Championship::addNewRace(std::string race_name) {
  Race* newest=new Race(race_name);
  for(int i=0;i<this->races[0]->getNumberOfCarsinRace();i++) {
    Car* tempCar=new Car(&((*(this->races[0]))[i]));
    newest->addCartoRace(*tempCar);
    this->garbageCar.push_back(tempCar);
  }
  this->garbage.push_back(newest);
  this->races.push_back(newest);
}

void Championship::removeRace(std::string race_name) {
  for(int i=0;i<(this->races).size();i++) {
    if(this->races[i]->getRaceName() == race_name) {
      races.erase(races.begin()+i);
      break;
    }
  }
}

void Championship::addLap(std::string race_name) {
  for(int i=0;i<(this->races).size();i++) {
    if(this->races[i]->getRaceName() == race_name) {
      Race* temp=this->races[i];
      ++(*temp);
      break;
    }
  }
}

Race& Championship::operator[](std::string race_name) {
  int i=0;
  while((this->races[i])->getRaceName() != race_name) i++;
  return *races[i];
}

std::ostream& operator<<(std::ostream& os, const Championship& championship) {
  int totalCars=championship.getCarNumbers();
  std::vector<Championship::winners> participants(totalCars);
  Car* walkf=championship.races[0]->getHeadPtr();
  for(int i=0;i<totalCars;i++) {
    std::string name=walkf->getInitials();
    participants[i].name=name;
    walkf=walkf->getNext();
  }

  for(int i=0;i<championship.races.size();i++) {
    Race* walk=championship.races[i]; //race
    Car* walkr=walk->getHeadPtr(); //car
    for(int j=0;j<totalCars;j++) {
      std::string name=walkr->getInitials();
      for(int k=0;k<totalCars;k++) {
        if(name == participants[k].name)
        participants[k].points+=walk->getPoints(walkr->getDriverName());
      }
      walkr=walkr->getNext();
    }
  }
  std::sort(participants.begin(), participants.end(), Championship::winnerCompare);
  int digits=0;
  int temp=totalCars;
  while(temp) {
    temp=temp/10;
    digits++;
  }
  char wh[digits];
  //os << "Championship Results" << std::endl;
  for(int i=0;i<totalCars;i++) {
    sprintf(wh,"%0*d",digits,i+1);
    os << wh << "--" << participants[i].name << "--" << participants[i].points << std::endl;
  }
  return os;
}

void Championship::printRaces() const {
  for(auto i:this->races) {
    std::cout << i->getRaceName() << std::endl;
    std::cout << i->getAverageLaptime() << std::endl;
    std::cout << "cars: " << i->getNumberOfCarsinRace() << std::endl;
    i->printCars();
  }
}

int Championship::getCarNumbers() const {
  return this->races[0]->getNumberOfCarsinRace();
}

bool Championship::winnerCompare(winners f, winners s) {
  return f.points > s.points;
}

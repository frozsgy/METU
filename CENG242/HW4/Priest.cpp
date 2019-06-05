#include"Priest.h"

/*
YOU MUST WRITE THE IMPLEMENTATIONS OF THE REQUESTED FUNCTIONS
IN THIS FILE. START YOUR IMPLEMENTATIONS BELOW THIS LINE
*/


Priest::Priest(uint id,int x, int y, Team team) : Player(id,x,y,team) {
  this->setHP(150);
}

Priest::~Priest() { }

int Priest::getAttackDamage() const {
  return 0;
}

int Priest::getHealPower() const {
  return 50;
}

int Priest::getMaxHP() const {
  return 150;
}

std::vector<Goal> Priest::getGoalPriorityList() {
  std::vector<Goal> myGoals;
  myGoals.push_back(HEAL);
  myGoals.push_back(TO_ALLY);
  myGoals.push_back(CHEST);
  return myGoals;
}

const std::string Priest::getClassAbbreviation() const {
  if(this->getTeam() == BARBARIANS) {
    return "PR";
  }
  else {
    return "pr";
  }
}

std::vector<Coordinate> Priest::getAttackableCoordinates() {
  std::vector<Coordinate> empty;
  return empty;
}

std::vector<Coordinate> Priest::getMoveableCoordinates() {
  Coordinate orig=this->getCoord();
  std::vector<Coordinate> canAttack;
  for(int i=-1;i<2;i++) {
    for(int j=-1;j<2;j++) {
      if(j || i) canAttack.push_back(Coordinate(orig.x+i,orig.y+j));
    }
  }
  return canAttack;
}

std::vector<Coordinate> Priest::getHealableCoordinates() {
  Coordinate orig=this->getCoord();
  std::vector<Coordinate> canAttack;
  for(int i=-1;i<2;i++) {
    for(int j=-1;j<2;j++) {
      if(j || i) canAttack.push_back(Coordinate(orig.x+i,orig.y+j));
    }
  }
  return canAttack;
}

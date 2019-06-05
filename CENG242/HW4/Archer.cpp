#include"Archer.h"

/*
YOU MUST WRITE THE IMPLEMENTATIONS OF THE REQUESTED FUNCTIONS
IN THIS FILE. START YOUR IMPLEMENTATIONS BELOW THIS LINE
*/

Archer::Archer(uint id,int x, int y, Team team) : Player(id,x,y,team) {
  this->setHP(200);
}

Archer::~Archer() { }

int Archer::getAttackDamage() const {
  return 50;
}

int Archer::getHealPower() const {
  return 0;
}

int Archer::getMaxHP() const {
  return 200;
}

std::vector<Goal> Archer::getGoalPriorityList() {
  std::vector<Goal> myGoals;
  myGoals.push_back(ATTACK);
  return myGoals;
}

const std::string Archer::getClassAbbreviation() const {
  if(this->getTeam() == BARBARIANS) {
    return "AR";
  }
  else {
    return "ar";
  }
}

std::vector<Coordinate> Archer::getAttackableCoordinates() {
  Coordinate orig=this->getCoord();
  std::vector<Coordinate> canAttack;
  for(int i=-2;i<3;i++) {
    if(i) canAttack.push_back(Coordinate(orig.x+i,orig.y));
  }
  for(int i=-2;i<3;i++) {
    if(i) canAttack.push_back(Coordinate(orig.x,orig.y+i));
  }
  return canAttack;
}

std::vector<Coordinate> Archer::getMoveableCoordinates() {
  std::vector<Coordinate> empty;
  return empty;
}

std::vector<Coordinate> Archer::getHealableCoordinates() {
  std::vector<Coordinate> empty;
  return empty;
}

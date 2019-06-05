#include"Fighter.h"

/*
YOU MUST WRITE THE IMPLEMENTATIONS OF THE REQUESTED FUNCTIONS
IN THIS FILE. START YOUR IMPLEMENTATIONS BELOW THIS LINE
*/


Fighter::Fighter(uint id,int x, int y, Team team) : Player(id,x,y,team) {
  this->setHP(400);
}

Fighter::~Fighter() { }

int Fighter::getAttackDamage() const {
  return 100;
}

int Fighter::getHealPower() const {
  return 0;
}

int Fighter::getMaxHP() const {
  return 400;
}

std::vector<Goal> Fighter::getGoalPriorityList() {
  std::vector<Goal> myGoals;
  myGoals.push_back(ATTACK);
  myGoals.push_back(TO_ENEMY);
  myGoals.push_back(CHEST);
  return myGoals;
}

const std::string Fighter::getClassAbbreviation() const {
  if(this->getTeam() == BARBARIANS) {
    return "FI";
  }
  else {
    return "fi";
  }
}

std::vector<Coordinate> Fighter::getAttackableCoordinates() {
  Coordinate orig=this->getCoord();
  std::vector<Coordinate> canAttack;
  for(int i=-1;i<2;i++) {
    if(i) canAttack.push_back(Coordinate(orig.x+i,orig.y));
  }
  for(int i=-1;i<2;i++) {
    if(i) canAttack.push_back(Coordinate(orig.x,orig.y+i));
  }
  return canAttack;
}

std::vector<Coordinate> Fighter::getMoveableCoordinates() {
  Coordinate orig=this->getCoord();
  std::vector<Coordinate> canAttack;
  for(int i=-1;i<2;i++) {
    if(i) canAttack.push_back(Coordinate(orig.x+i,orig.y));
  }
  for(int i=-1;i<2;i++) {
    if(i) canAttack.push_back(Coordinate(orig.x,orig.y+i));
  }
  return canAttack;
}

std::vector<Coordinate> Fighter::getHealableCoordinates() {
  std::vector<Coordinate> empty;
  return empty;
}

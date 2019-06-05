#include"Tank.h"

/*
YOU MUST WRITE THE IMPLEMENTATIONS OF THE REQUESTED FUNCTIONS
IN THIS FILE. START YOUR IMPLEMENTATIONS BELOW THIS LINE
*/


Tank::Tank(uint id,int x, int y, Team team) : Player(id,x,y,team) {
  this->setHP(1000);
}

Tank::~Tank() { }

int Tank::getAttackDamage() const {
  return 25;
}

int Tank::getHealPower() const {
  return 0;
}

int Tank::getMaxHP() const {
  return 1000;
}

std::vector<Goal> Tank::getGoalPriorityList() {
  std::vector<Goal> myGoals;
  myGoals.push_back(TO_ENEMY);
  myGoals.push_back(ATTACK);
  myGoals.push_back(CHEST);
  return myGoals;
}

const std::string Tank::getClassAbbreviation() const {
  if(this->getTeam() == BARBARIANS) {
    return "TA";
  }
  else {
    return "ta";
  }
}

std::vector<Coordinate> Tank::getAttackableCoordinates() {
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

std::vector<Coordinate> Tank::getMoveableCoordinates() {
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

std::vector<Coordinate> Tank::getHealableCoordinates() {
  std::vector<Coordinate> empty;
  return empty;
}

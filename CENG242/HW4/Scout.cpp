#include"Scout.h"

/*
YOU MUST WRITE THE IMPLEMENTATIONS OF THE REQUESTED FUNCTIONS
IN THIS FILE. START YOUR IMPLEMENTATIONS BELOW THIS LINE
*/


Scout::Scout(uint id,int x, int y, Team team) : Player(id,x,y,team) {
  this->setHP(125);
}

Scout::~Scout() { }

int Scout::getAttackDamage() const {
  return 25;
}

int Scout::getHealPower() const {
  return 0;
}

int Scout::getMaxHP() const {
  return 125;
}

std::vector<Goal> Scout::getGoalPriorityList() {
  std::vector<Goal> myGoals;
  myGoals.push_back(CHEST);
  myGoals.push_back(TO_ALLY);
  myGoals.push_back(ATTACK);
  return myGoals;
}

const std::string Scout::getClassAbbreviation() const {
  if(this->getTeam() == BARBARIANS) {
    return "SC";
  }
  else {
    return "sc";
  }
}

std::vector<Coordinate> Scout::getAttackableCoordinates() {
  Coordinate orig=this->getCoord();
  std::vector<Coordinate> canAttack;
  for(int i=-1;i<2;i++) {
    for(int j=-1;j<2;j++) {
      if(j || i) canAttack.push_back(Coordinate(orig.x+i,orig.y+j));
    }
  }
  return canAttack;
}

std::vector<Coordinate> Scout::getMoveableCoordinates() {
  Coordinate orig=this->getCoord();
  std::vector<Coordinate> canAttack;
  for(int i=-1;i<2;i++) {
    for(int j=-1;j<2;j++) {
      if(j || i) canAttack.push_back(Coordinate(orig.x+i,orig.y+j));
    }
  }
  return canAttack;
}

std::vector<Coordinate> Scout::getHealableCoordinates() {
  std::vector<Coordinate> empty;
  return empty;
}

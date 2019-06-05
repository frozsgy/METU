#include"Player.h"

/*
YOU MUST WRITE THE IMPLEMENTATIONS OF THE REQUESTED FUNCTIONS
IN THIS FILE. START YOUR IMPLEMENTATIONS BELOW THIS LINE
*/


Player::Player(uint id,int x, int y, Team team) : id(id), coordinate(Coordinate(x,y)), team(team) { }

uint Player::getID() const {
  return this->id;
}
const Coordinate& Player::getCoord() const {
  return this->coordinate;
}

int Player::getHP() const {
  return this->HP;
}

Team Player::getTeam() const {
  return this->team;
}

std::string Player::getBoardID() {
  int x=this->id;
  int digits=0;
  int temp=x;
  if(x > 9) {
    while(temp > 0) {
      digits++;
      temp/=10;
    }
  }
  else {
    digits=2;
  }
  char wh[digits+1];
  sprintf(wh,"%0*d",digits,x);
  wh[digits]='\0';
  return std::string(wh);
}

bool Player::attack(Player *enemy) {
  int damageCaused=this->getAttackDamage();
  int enemyHP=enemy->getHP();
  int newHP=enemyHP-damageCaused;
  enemy->setHP(newHP);
  std::cout << "Player " << this->getBoardID() << " attacked Player " << enemy->getBoardID() << " (" << damageCaused << ")" << std::endl;
  if(newHP > 0) {
    return true;
  }
  else {
    return false;
  }
}

void Player::heal(Player *ally) {
  int currentHP=ally->getHP();
  int maxHP=ally->getMaxHP();
  int healPower=this->getHealPower();
  int newHP=currentHP+healPower;
  if(newHP > maxHP) newHP=maxHP;
  ally->setHP(newHP);
  std::cout << "Player "<< this->getBoardID() <<" healed Player " << ally->getBoardID() << std::endl;
}

void Player::movePlayerToCoordinate(Coordinate c) {
  /*don't forget to check if this is a valid coordinate before calling this method!!*/
  std::cout << "Player "<< this->getBoardID() <<" moved from " << this->getCoord() << " to " << c << std::endl;
  this->coordinate.x=c.x;
  this->coordinate.y=c.y;

}

bool Player::isDead() const {
  if(this->getHP() <= 0) return true;
  return false;
}

void Player::setHP(int newHP) {
  this->HP=newHP;
}

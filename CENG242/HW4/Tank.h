#ifndef HW4_TANK_H
#define HW4_TANK_H

#include"Player.h"

class Tank : public Player{
  /**
   * Attack damage 25
   * Heal power 0
   * Max HP 1000
   * Goal Priorities -> {TO_ENEMY,ATTACK,CHEST} in decreasing order
   * Class abbreviation -> "ta" or "TA"
   * Can move to adjacent up, down, left or right square
   * Can attack to adjacent up, down, left or right square
   *
   */

 public:

   Tank(uint id,int x, int y, Team team);
   ~Tank();

  int getAttackDamage() const;
  int getHealPower() const;
  int getMaxHP() const;
  std::vector<Goal> getGoalPriorityList();
  const std::string getClassAbbreviation() const;
  std::vector<Coordinate> getAttackableCoordinates();
  std::vector<Coordinate> getMoveableCoordinates();
  std::vector<Coordinate> getHealableCoordinates();
};

#endif

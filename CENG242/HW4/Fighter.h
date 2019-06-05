#ifndef HW4_FIGHTER_H
#define HW4_FIGHTER_H

#include"Player.h"

class Fighter : public Player{
  /**
   * Attack damage 100
   * Heal power 0
   * Max HP 400
   * Goal Priorities -> {ATTACK,TO_ENEMY,CHEST} in decreasing order
   * Class abbreviation -> "fi" or "FI"
   * Can move to adjacent up, down, left or right square
   * Can attack to adjacent up, down, left or right square
   *
   */
 public:
   
   Fighter(uint id,int x, int y, Team team);
   ~Fighter();

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

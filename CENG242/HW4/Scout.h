#ifndef HW4_SCOUT_H
#define HW4_SCOUT_H

#include"Player.h"

class Scout : public Player{
  /**
   * Attack damage 25
   * Heal power 0
   * Max HP 125
   * Goal Priorities -> {CHEST,TO_ALLY,ATTACK} in decreasing order
   * Class abbreviation -> "sc" or "SC"
   * Can move to all adjacent squares, including diagonals.
   * Can attack all adjacent squares, including diagonals.
   *
   */

 public:

   Scout(uint id,int x, int y, Team team);
   ~Scout();

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

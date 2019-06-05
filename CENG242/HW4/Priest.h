#ifndef HW4_PRIEST_H
#define HW4_PRIEST_H

#include"Player.h"

class Priest : public Player{
  /**
   * Attack damage 0
   * Heal power 50
   * Max HP 150
   * Goal Priorities -> {HEAL,TO_ALLY,CHEST} in decreasing order
   * Class abbreviation -> "pr" or "PR"
   * Can move to all adjacent squares, including diagonals.
   * Can heal all adjacent squares, including diagonals.
   *
   */
 public:

   Priest(uint id,int x, int y, Team team);
   ~Priest();

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

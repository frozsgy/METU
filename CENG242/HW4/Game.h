#ifndef HW4_GAME_H
#define HW4_GAME_H

#include"Board.h"
#include"Archer.h"
#include"Fighter.h"
#include"Priest.h"
#include"Scout.h"
#include"Tank.h"

class Game{

private:
  Board board;
  uint turnNumber;
  uint maxTurnNumber;
  std::vector<Player*> players;

  //DO NOT MODIFY THE UPPER PART
	//ADD YOU OWN PROVATE METHODS/PROPERTIES BELOW

public:
  /**
   * Costructor for Game class.
   * Game manages the memory allocated for future contents the vector (added players).
   * Pass a pointer to the players vector to board constructor so that the board will
   * not miss the addition of players to the game.
   * @param maxTurnNumber turn number to end the game
   * @param boardSize size of the board
   * @param chest coordinate of the chest
   */
  Game(uint maxTurnNumber, uint boardSize, Coordinate chest);

  ~Game();

  Board* getBoard(){
    return &(this->board);
  }

  /**
   * Add a new player to the game. Add a pointer to the new player to the this->players vector.
   * Do not forget that Game will manage the memory allocated for the players.
   * @param id ID of the new player.
   * @param x x coordinate of the new player.
   * @param y y coordinate of the new player.
   * @param team team of the new player.
   * @param cls class of the new player as string, One of "ARCHER", "FIGHTER",
   * "PRIEST", "SCOUT", "TANK".
   *
   */
  void addPlayer(int id, int x, int y, Team team, std::string cls);

  /**
   * The game ends when either of these happens:
   * - All barbarians die (knight victory)
   * - All knights die (barbarian victory)
   * - A barbarian gets to the square containing the chest (barbarian victory)
   * - maxTurnNumber of turns played (knight victory)
   *
   * If the game ends announce it py printing the reason, turn number and the victor
   * as in the following examples:
   *
   * Game ended at turn 13. All barbarians dead. Knight victory.
   * Game ended at turn 121. All knights dead. Barbarian victory.
   * Game ended at turn 52. Chest captured. Barbarian victory.
   * Game ended at turn 215. Maximum turn number reached. Knight victory.
   *
   * @return true if any of the above is satisfied, false otherwise
   *
   */
  bool isGameEnded();

  /**
   * Play a turn for each player.
   * Actions are taken in the order of ID numbers of players (player with
   * smaller ID acts first).
   * At the start of the turn it announces that the turn has started by printing
   * to stdout. Turn numbers starts with 1.
   * Ex: "Turn 13 has started."
   * Call playTurnForPlayer for every player.
   *
   */
  void playTurn();
  /**
   * Play a turn for the given player.
   * If the player is dead announce its death by printing the boardID of the player
   * as in "Player 07 died.". Remove that player from the board and release its resources.
   *
   * Each player has a goal list sorted by its priority for that player.
   * When a player plays a turn it iterates over its goal list and tries to take
   * an action. Valid actions are attack, move and heal. A player can take only
   * one action in a turn, and if there is no action it can take it stops and does nothing.
   * Before moving a player you must check if the coordinate to move is valid.
   * Meaning that, the coordinate is in the bounds of the board and there are no
   * players there.
   *
   * IMPORTANT NOTE: every usage of the word nearest is referencing smallest the manhattan
   * distance, which is formulated as (abs(x_1-x_2) + abs(y_1-y_2)). operator-
   * overloaded in Coordinate.h computes exactly that, so you can use that method to
   * calculate the distance between two coordinates.
   *
   * Below are the explanations for goals:
   *
   * ATTACK:
   *   - If there are any enemies in the attack range of the player attack to it.
   *     If there are more than 1 enemy in the range attack to the one with
   *     lowest ID. If there is no one to attack try the next goal.
   *
   * CHEST:
   *   - Move to the direction of the chest, if both vertical and horizontal moves
   *     are available, pick the horizontal one. If the horizontal move is blocked
   *     but the vertical move is not, move vertically. If all directions towards
   *     the chest is blocked try the next goal.
   *
   * TO_ENEMY:
   *   - Move towards the nearest enemy. If there are more than one enemies with the same distance
   *     move towards the one with the smallest ID. If both vertical and horizontal moves
   *     are available, pick the horizontal one. If an enemy is in the squares
   *     that the player can move or every move that brings the player closer to
   *     the selected enemy is blocked, try the next goal.
   *
   * TO_ALLY:
   *   - Move towards the nearest ally. If there are more than one allies with the same distance
   *     move towards the one with the smallest ID.  If both vertical and horizontal moves
   *     are available, pick the horizontal one. If an ally is in the squares
   *     that the player can move or every move that brings the player closer to
   *     the selected ally is blocked, try the next goal.
   *
   * HEAL:
   *   - If there are any allies in the healing range heal all of them. if there
   *     is no one to heal try the next goal.
   *
   *
   * @return the goal that the action was taken upon. NO_GOAL if no action was taken.
   */
  Goal playTurnForPlayer(Player* player);

  static bool playerSort(Player* f, Player* s);
};

#endif

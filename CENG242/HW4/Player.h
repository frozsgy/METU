#ifndef HW4_PLAYER_H
#define HW4_PLAYER_H

#include<vector>
#include<iostream>
#include<string>
#include"Constants.h"
#include"Coordinate.h"


class Player{
protected:
	const uint id;
	Coordinate coordinate;
	int HP;
	Team team;
	//DO NOT MODIFY THE UPPER PART
	//ADD YOU OWN PROVATE METHODS/PROPERTIES BELOW


public:

	/**
	 * Main constructor
	 *
	 * @param id id of the player.
	 * @param x x-coordinate of the player
	 * @param y y-coordinate of the player
	 * @param team team of the player, BARBARIAN or KNIGHT
	 *
	 */

	Player(uint id,int x, int y, Team team);
	virtual ~Player() = default;

	uint getID() const;
	const Coordinate& getCoord() const;

	int getHP() const;

	Team getTeam() const;

	/**
	 * @return the board ID of the player, If the ID is single digit add a prefix
	 * 0, otherwise just turn it into a string.
	 *
	 * Example:
	 * 3 -> "03"
	 * 12 -> "12"
	 *
	 */
	std::string getBoardID();

	virtual int getAttackDamage() const = 0;

	virtual int getHealPower() const = 0;

	virtual int getMaxHP() const = 0;

	/**
	 * For each subclass of Player there are different priority lists defined
	 * that controls the next action to take for that Player. It is given in the
	 * header of the subclasses.
	 *
	 * @return the goal priority list for the Player
	 */
	virtual std::vector<Goal> getGoalPriorityList() = 0;
	/**
	 * @return the class abbreviation of player, if the player is on the barbarian
	 * team, the abbreviation will consist of uppercase characters, otherwise it
	 * will consist of lowercase characters.
	 *
	 */

	virtual const std::string getClassAbbreviation() const = 0;

	/**
	 * Attack the given player.
	 * Enemy HP should decrease as much as the attack damage of attacker. Print
	 * the boardID of the attacker and the attack and the amount of damage as below.
	 * "Player 01 attacked Player 05 (75)"
	 *
	 * @param enemy player that is attacked.
	 * @return true if the opponent is dead false if alive.
	 */

	bool attack(Player *enemy);

	/**
	 * Heal the given player by the adding amount of heal power of this character
	 * to the HP of ally. Print the boardID of the healer and healed players as
	 * below.
	 * "Player 01 healed Player 05"
	 * Healed player should not have more HP than its max HP.
	 */

	void heal(Player *ally);
	/**
	 * @Important The coordinates may not be on the board.
	 *
	 * @return the coordinates that the unit is able to attack given the position
	 * of the unit. Empty vector if the unit cannot attack.
	 */

	virtual std::vector<Coordinate> getAttackableCoordinates() = 0;

	/**
	 * @Important The coordinates may not be on the board.
	 *
	 * @return the coordinates the unit is able to move given the position of the
	 * unit. Empty vector if the unit cannot move.
	 */
	virtual std::vector<Coordinate> getMoveableCoordinates() = 0;

	/**
	 *
	 * @return the coordinates the unit is able to heal allies given the position of the
	 * unit. Empty vector if none available.
	 */
	virtual std::vector<Coordinate> getHealableCoordinates() = 0;

	/**
	 * Move player to coordinate. Print the boardID of the player and the old and new
	 * coordinates as below:
	 * "Player 01 moved from (0/1) to (0/2)"
	 * @Important before calling this method you must verify that this coordinate
	 * is valid to move
	 */
	void movePlayerToCoordinate(Coordinate c);



	/**
	* Decide whether the player is dead.
	*
	* @return true if the player's HP <= 0, false otherwise.
	*/
	bool isDead() const;

	void setHP(int newHP);
};


#endif

#ifndef HW4_BOARD_H
#define HW4_BOARD_H


#include<vector>
#include"Player.h"

class Board{

private:
	uint size;
	std::vector<Player*>* players;
	Coordinate chest;

	//DO NOT MODIFY THE UPPER PART
	//ADD YOU OWN PROVATE METHODS/PROPERTIES BELOW

public:
	Board(uint _size, std::vector<Player*>* _players, Coordinate chest);
	~Board();
	/**
	 * @return true if the coordinate is in the board limits, false otherwise.
	 */
	bool isCoordinateInBoard(const Coordinate& c);
	/**
	 * @return true if there is a player on the given coordinate, false otherwise.
	 */
	bool isPlayerOnCoordinate(const Coordinate& c);
	/**
	 * @return pointer to the player at the given coordinate. Return NULL if no
	 * player is there.
	 */
	Player *operator [](const Coordinate& c);

	/**
	 * @return the chest coordinate
	 */
	Coordinate getChestCoordinates();
	 /**
	  * Print the board with character ID's.
	  * For each empty square print two underscore characters.
		* For the squares with a player on it, print the board id of the player.
		* For the square with the chest, print the string "Ch".
		* If a character is on the square with the chest, only print the ID of the
		* character.
		* For each row print a new line, for each column print a space character.
		* Example:
		* __ __ 01 __
		* __ 02 __ 05
		*	Ch __ __ 03
		*	__ __ __ __
	  */
	void printBoardwithID();
	/**
	 * For each empty square print two underscore characters.
	 * For the squares with a player on it, print the class abbreviation of the
	 * player.
	 * For the square with the chest, print the string "Ch".
	 * If a character is on the square with the chest, only print the abbreviation
	 * of the character.
	 * To separate each row print a new line, to separate each column print a
	 * space character.
	 * Example:
	 * __ __ PR __
	 * __ ar __ TA
	 * Ch __ __ fi
	 * __ __ __ __
	 */
	void printBoardwithClass();

	int getBarbarianCount() const;
	int getKnightCount() const;
	bool barbarianOnChest() const;
};
#endif

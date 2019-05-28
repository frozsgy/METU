#ifndef HW3_CHAMPIONSHIP_H
#define HW3_CHAMPIONSHIP_H
#include "Race.h"

#include <ostream>
#include <vector>

class Championship {

private:

    std::vector< Race* > races;


    // DO NOT MODIFY THE UPPER PART
    // ADD OWN PRIVATE METHODS/PROPERTIES BELOW
    std::vector<Race*> garbage;
    std::vector<Car*> garbageCar;

    typedef struct winners {
      std::string name;
      int points;
    } winners;

public:
    /**
     * Constructor.
     *
     */
    Championship();
    /**
     * Copy Constructor.
     *
     * @param rhs The Championship to be copied.
     */
    Championship(const Championship& rhs);

    ~Championship();


    /**
     * Add a new Race to Championship.
     *
     * @Important: Purpose of this function is to add the first race.
     *
     * @param race Race to add
     */
    void addNewRace(Race& race);

    /**
     * Add a new Race to Championship.
     *
     * @Important: You will use getAverageLaptime function for this
     * @Important: You can use copy constructor of the Race class in order
     * to just copy driver names for your new Race
     * @Important: Driver names should be same for each race
     *
     * @param race_name create a new race with given name
     */

    void addNewRace(std::string race_name);

    /**
     * Remove race from by using its name
     *
     * @param race_name remove race from championship
     *
     */
    void removeRace(std::string race_name);

    /**
     *
     * Add lap to race with the given name
     *
     * @param race_name you will find the race with this name and add a lap to it
     */
    void addLap(std::string race_name);




    /**
     *
     * Indexing overload
     *
     *
     * @param: race name
     * @returns the desired Race
     */
    Race& operator[](std::string race_name);




    /**
     * Stream overload.
     *
     * What to stream:
     * Championship Results
     * Driver Surname first three letters in capital(from winner)--Total Points
     * ...
     * Driver Surname first three letters in capital(to last place)--Total Points
     *
     * Example:
     * Championship Results
     * 01-RAI--194
     * 02-HAM--190
     * 03-LEC--100
     * 77-OCO--60
     * 78-RIC--1
     * 79-GRO--0
     *
     * @Important: for driver placements numbers smaller in size you have to put zeros as much as neccasary to their start
     * Example: if there is 111 racers first position should be 001
     * @Important: You will order drivers according to their total points
     *
     * @param os Stream to be used.
     * @param car Car to be streamed.
     * @return The current Stream.
     */
    friend std::ostream& operator<<(std::ostream& os, const Championship& championship);

    // DO NOT MODIFY THE UPPER PART
    // ADD OWN PUBLIC METHODS/PROPERTIES BELOW

    void printRaces() const;

    int getCarNumbers() const;

    static bool winnerCompare(winners f, winners s);
};

#endif //HW3_CHAMPIONSHIP_H

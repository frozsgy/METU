#ifndef HW3_RACE_H
#define HW3_RACE_H

#include "Car.h"
#include <ostream>
#include <vector>

class Race {

private:
    std::string race_name;
    Laptime average_laptime;
    Car *head;

    // DO NOT MODIFY THE UPPER PART
    // ADD OWN PRIVATE METHODS/PROPERTIES BELOW
    std::vector<Car*> garbageCar;
    int seed;

public:
    /**
     * Constructor.
     *
     * @Important: Generate average_laptime by using Utilizer::generateAverageLaptime()
     *
     * @param std::string The name of the Race.
     */
    Race(std::string race_name);
    /**
     * Copy Constructor.
     *
     * @Important just copy the names and performances of the cars
     * without any laptime.
     * Cars should be deep copied
     *
     * @param rhs The race to be copied.
     */
    Race(const Race& rhs);

    ~Race();

    std::string getRaceName() const;

    /**
     * Add a new car to race.
     *
     * @Important: At the start of the race their ordering is not important
     *
     * No parameter means that you will generate your own car in
     * this function(with a random name)and add it to your Cars
     */

    void addCartoRace();

    /**
     * Add a new car to race.
     *
     * @Important: At the start of the race their ordering is not important
     *
     * @param: car Add given Car to others
     */
    void addCartoRace(Car& car);

    /**
     * Information About how much car is in the race
     *
     * @returns number of cars
     *
     */
    int getNumberOfCarsinRace();

    /**
     * Return state of everything to desired lap's state
     *
     * Your Race will have many laps in the course of its life. In each lap, your cars will have new Laptimes etc.
     * For example, if you have 20 Laps in your Race, but let's say you want to redo last 10 laps of it. By using goBacktoLap,
     * you will take your Race back to 10th Lap. This will also make changes in your Cars. Your cars will have only the information of the first 10 laps.
     * Lap numbers start from zero. If 5 is given as int lap, you will take Race back to 6th lap.
     * @Important: this will also apply to cars and leaderboard too
     *
     * @param lap to return
     *
     */
    void goBacktoLap(int lap);


    /**
     * Prefix addition overload
     *
     * add one more lap to all cars
     *
     * @Important: Update the order of the cars so that the fastest one stays at the front
     *
     */
    void operator++();

    /**
     *  Prefix decrement overload
     *
     * remove one lap from all cars
     *
     * @Important: Update the order of the cars so that the fastest one stays at the front
     *
     */
    void operator--();

    /**
     *
     * Indexing overload
     *
     * This function will not be tested for the cases in which Car in given position does not exist.
     *
     * @param: car_in_position Car in the given position
     * @returns the car in the desired position in the current lap
     */
    Car& operator[](const int car_in_position);

    /**
     *
     * Indexing overload
     *
     * This function will not be tested for the cases in which Car with given driver_name does not exist.
     *
     * @param: driver_name driver's name of the desired car
     * @returns the car whose driver named as the given @param
     */
    Car& operator[](std::string driver_name);
    /**
     * Assignment
     *
     * @param rhs The Race to assign into this race
     * @return The assigned Race
     */
    Race& operator=(const Race& rhs);


    /**
     * Stream overload.
     *
     * What to stream:
     * Position--*Driver Name(leader of the race)--Latest Laptime--Fastest Laptime of the Driver--Sum of Laptimes(in display Laptime format)--Points--ExtraPoint(If applicable)
     * ...
     * Position--*Driver Name(last place of the race)--Latest Laptime--Fastest Laptime of the Driver--Sum of Laptimes(in display Laptime format)--Points--ExtraPoint(If applicable)
     *
     * Example:
     * 001--TUF--1:19.461--1:18.935--60:35.193--25
     * 002--UTA--1:19.335--1:18.335--60:37.321--18--1
     * 003--GRT--1:20.223--1:19.932--60:45.184--15
     * ...
     * 099--CEI--1:21.005--1:19.867--63:47.293
     * 100--ECH--1:23.213--1:21.331--64:00.123
     *
     * @Important: for driver numbers smaller in size you have to put zeros as much as neccasary to their beginning
     * Example: if there is 11 racers first position should be 01
     * @Important. you can use Laptime ostream when neccessary
     * @Important: You should order the racers according to their total laptime
     * @Important: There are two different point types for F1
     * First one is the Fastest Lap point which is 1 point and it is given the fastest car if it is in top 10
     * Other one is normal racing points and they are 25-18-15-12-10-8-6-4-2-1 in this order
     *
     * @param os Stream to be used.
     * @param car Car to be streamed.
     * @return The current Stream.
     */
    friend std::ostream& operator<<(std::ostream& os, const Race& race);

    // DO NOT MODIFY THE UPPER PART
    // ADD OWN PUBLIC METHODS/PROPERTIES BELOW

    void bubbleSort(Car* lister, int n);
    void printCars();
    int getNumberOfCarsinRaceConst() const;
    Laptime getAverageLaptime() const;
    Car*  getHeadPtr() const;
    std::string getInitials() const;
    int getPoints(std::string name) const;
};


#endif //HW3_RACE_H

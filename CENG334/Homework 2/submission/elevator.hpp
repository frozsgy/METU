#ifndef CENG334HOMEWORK2_ELEVATOR_HPP
#define CENG334HOMEWORK2_ELEVATOR_HPP

#include "monitor.h"
#include "person.hpp"

#include <iostream>
#include <vector>
#include <algorithm>
#include <string>

enum Status { IDLE, MOVING_UP, MOVING_DOWN };

class ElevatorMonitor: public Monitor {

    Condition can_write;
    Condition can_read;
    int writecount = 0;
    int readcount = 0;

    int weight_capacity;
    int person_capacity;
    int current_weight;
    int current_people;
    int current_floor;
    int waiting_count;
    Status status = IDLE;

    std::vector<Person*> people;
    std::vector<int> destination_queue;
    std::vector<std::vector<Person*>> floors;
    std::vector<Person*> people_serving;
    std::vector<bool> person_served;
    std::vector<bool> request_acknowledged;

    bool Enter(Person* person);
    bool Leave(Person* person);
    static bool ComparePeople(Person* p1, Person* p2);
    void RemoveFromDestinationQueue(int floor);


public: 
    ElevatorMonitor(int weight_capacity, int person_capacity, int num_people);

    Status GetStatus();
    int GetCurrentFloor();
    int GetPassengerCount();
    int GetNextFloor();
    bool GetServed(int person_id);
    std::vector<std::vector<Person*>>& GetFloors();
    std::string GetDestinationQueueString() const;

    void SetFloors(std::vector<std::vector<Person*>> floors, int waiting_count);

    void PrintElevator();

    void MoveUp();
    void MoveDown();
    void TakePeople(int at_floor, bool init = false);
    void RemovePeople(int at_floor);

    void MakeRequest(Person* person);

    bool InElevator(Person* person);
    
};



#endif //CENG334HOMEWORK2_ELEVATOR_HPP
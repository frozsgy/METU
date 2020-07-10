#ifndef CENG334HOMEWORK2_PERSON_HPP
#define CENG334HOMEWORK2_PERSON_HPP

#include <iostream>

enum Priority { HIGH_PRIORITY = 1, LOW_PRIORITY = 2 };
enum Direction { UP = 1, DOWN = 2 };

class Person {
private:
    int weight;
    int initial_floor;
    int destination_floor;
    int id;
    Priority priority;
    bool served = false;
    
public:
    Person();
    Person(int id, int weight_person, int initial_floor, int destination_floor, int priority);
    Person(const Person& rhs);
    ~Person();

    int GetWeight() const;
    int GetDestination() const;
    int GetID() const;
    int GetInitialFloor() const;
    Priority GetPriority() const;
    Direction GetDirection() const;
    bool IsServed() const;

    void SetServed();

    void PrintEnter() const;
    void PrintLeave() const;
    void PrintRequest() const; 

    
};

#endif //CENG334HOMEWORK2_PERSON_HPP
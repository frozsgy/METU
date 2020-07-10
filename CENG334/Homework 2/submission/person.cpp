#include "person.hpp"

Person::Person()
{

}

Person::Person(int id, int weight_person, int initial_floor, int destination_floor, int priority)
{
    this->id = id;
    this->weight = weight_person;
    this->initial_floor = initial_floor;
    this->destination_floor = destination_floor;
    this->priority = (Priority) priority;
}

Person::Person(const Person& rhs)
{
    this->id = rhs.id;
    this->weight = rhs.weight;
    this->initial_floor = rhs.initial_floor;
    this->destination_floor = rhs.destination_floor;
    this->priority = rhs.priority;
}

Person::~Person()
{

}

int Person::GetWeight() const
{
    return this->weight;
}

Priority Person::GetPriority() const
{
    return this->priority;
}

void Person::PrintRequest() const
{
    std::string pr = this->priority == HIGH_PRIORITY ? "hp" : "lp";
    std::cout << "Person (" << this->id << ", "<< pr << ", " << this->initial_floor << " -> " << this->destination_floor << ", " << this->weight << ") made a request" << std::endl;
}

void Person::PrintEnter() const
{
    std::string pr = this->priority == HIGH_PRIORITY ? "hp" : "lp";
    std::cout << "Person (" << this->id << ", "<< pr << ", " << this->initial_floor << " -> " << this->destination_floor << ", " << this->weight << ") entered the elevator" << std::endl;
}

void Person::PrintLeave() const
{
    std::string pr = this->priority == HIGH_PRIORITY ? "hp" : "lp";
    std::cout << "Person (" << this->id << ", "<< pr << ", " << this->initial_floor << " -> " << this->destination_floor << ", " << this->weight << ") has left the elevator" << std::endl;
}

int Person::GetDestination() const
{
    return this->destination_floor;
}

int Person::GetID() const
{
    return this->id;
}

int Person::GetInitialFloor() const
{
    return this->initial_floor;
}

bool Person::IsServed() const
{
    return this->served;
}

void Person::SetServed()
{
    this->served = true;
}

Direction Person::GetDirection() const
{
    if (this->initial_floor > this->destination_floor) {
        return DOWN;
    } else {
        return UP;
    }
}
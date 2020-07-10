#include "controller.hpp"

Controller::Controller()
{

}

Controller::Controller(int weight_capacity, int person_capacity, int travel_time, int idle_time, int in_out_time, ElevatorMonitor* emon)
{
    this->weight_capacity = weight_capacity;
    this->person_capacity = person_capacity;
    this->travel_time = travel_time;
    this->idle_time = idle_time;
    this->in_out_time = in_out_time;
    this->emon = emon;
}

Controller::Controller(const Controller& rhs)
{
    this->weight_capacity = rhs.weight_capacity;
    this->person_capacity = rhs.person_capacity,
    this->travel_time = rhs.travel_time;
    this->idle_time = rhs.idle_time;
    this->in_out_time = rhs.in_out_time;
    this->emon = rhs.emon;
}

Controller::~Controller()
{

}

void Controller::Serve()
{
    int i = 0;
    bool init_served = false;
    
    while (this->emon->GetNextFloor() != -1) {
        int remaining_people = 0;
        for (auto jj: this->emon->GetFloors()) {
            remaining_people += jj.size();
        }
        if (remaining_people == 0 && this->emon->GetPassengerCount() == 0) {
            break;
        }
        usleep(this->travel_time);

        if (this->emon->GetStatus() == IDLE) {
            if (this->emon->GetNextFloor() > this->emon->GetCurrentFloor()) {
                i++;
                this->emon->MoveUp();
            } 
            else if (this->emon->GetNextFloor() < this->emon->GetCurrentFloor()) {
                i--;
                this->emon->MoveDown();
            } else {

            }
        }
        if (this->emon->GetStatus() == MOVING_DOWN) {
            i--;
            this->emon->MoveDown();
        }
        else if (this->emon->GetStatus() == MOVING_UP){
            i++;
            this->emon->MoveUp();
        } else {

        }

        usleep(this->in_out_time);
        this->emon->RemovePeople(i);
        
        usleep(this->in_out_time);
        this->emon->TakePeople(i);

    }

}

int Controller::GetIdleTime() const
{
    return this->idle_time;
}
#include "monitor.h"
#include "person.hpp"
#include "controller.hpp"
#include "elevator.hpp"

#include <iostream>
#include <fstream>
#include <vector>
#include <unistd.h>
#include <climits>

Controller* ElevatorController;
ElevatorMonitor* EMonitor;

void cleanup(std::vector<Person*>& people, std::vector<pthread_t*>& threads, Controller* controller)
{
    for(auto k: people) {
        delete k;
    }
    for(auto l: threads) {
        delete l;
    }
    delete controller;
}

void* PersonThread(void* person)
{
    Person* p = (Person*) person;
    while(EMonitor->GetServed(p->GetID()) == false) {
        usleep(50);
        if (EMonitor->GetStatus() == IDLE) {
            if (!(EMonitor->InElevator(p))) {
                EMonitor->MakeRequest(p);
            }           
        } else if (EMonitor->GetStatus() == MOVING_UP && p->GetInitialFloor() >= EMonitor->GetCurrentFloor()) {
            EMonitor->MakeRequest(p);
        } else if (EMonitor->GetStatus() == MOVING_DOWN && p->GetInitialFloor() <= EMonitor->GetCurrentFloor()) {
            EMonitor->MakeRequest(p);
        }
    }
    return nullptr;
}

void* ElevatorControl(void* controller)
{
    Controller* c = (Controller*) controller;
    usleep(c->GetIdleTime());
    c->Serve();
    return nullptr;
}

int main(int argc, char **argv) 
{
    if (argc > 1) {

        std::ifstream fs(argv[1]);

        if (!fs) {
            std::cerr << "File " << argv[1] << " is not readable" << std::endl;
            exit(1);
        }

        int num_floors, num_people, weight_capacity, person_capacity, travel_time, idle_time, in_out_time;
        int first_serve = INT_MAX;
        int waiting_count = 0;

        fs >> num_floors >> num_people >> weight_capacity >> person_capacity >> travel_time >> idle_time >> in_out_time; 

        ElevatorMonitor emon(weight_capacity, person_capacity, num_people);
        EMonitor = &emon;

        Controller* controller = new Controller(weight_capacity, person_capacity, travel_time, idle_time, in_out_time, &emon);

        ElevatorController = controller;

        std::vector<std::vector<Person*>> floors(num_floors);

        std::vector<Person*> people;
        std::vector<pthread_t*> threads;
        pthread_t elevator_control_thread;

        for (int i = 0; i < num_people; i++) {
            int weight_person, initial_floor, destination_floor, priority; 
            fs >> weight_person >> initial_floor >> destination_floor >> priority;
            Person* p = new Person(i, weight_person, initial_floor, destination_floor, priority);
            if (initial_floor < first_serve) first_serve = initial_floor;
            pthread_t* t = new pthread_t;
            people.push_back(p);
            threads.push_back(t);
            waiting_count++;
        }
        
        fs.close();

        for (int i = 0; i < num_floors; i++) {
            std::vector<Person*> t;
            floors[i] = t;
        }

        for (int i = 0; i < num_people; i++) {
            int init = people[i]->GetInitialFloor();
            floors[init].push_back(people[i]);
        }

        emon.SetFloors(floors, waiting_count);

        for (int i = 0; i < num_people; i++) {
            pthread_create(threads[i], NULL, PersonThread, (void*) people[i]);
        }

        pthread_create(&elevator_control_thread, NULL, ElevatorControl, (void*) controller);

        for (int i = 0; i < num_people; i++) {
            pthread_join(*threads[i], NULL);    
        }

        pthread_join(elevator_control_thread, NULL);

        cleanup(people, threads, controller);    
    }
    
    return 0;
}
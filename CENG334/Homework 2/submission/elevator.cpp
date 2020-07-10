#include "elevator.hpp"


ElevatorMonitor::ElevatorMonitor(int weight_capacity, int person_capacity, int num_people) : can_write(this), can_read(this)
{
    this->current_weight = 0;
    this->current_people = 0;
    this->current_floor = 0;
    this->weight_capacity = weight_capacity;
    this->person_capacity = person_capacity;
    std::vector<bool> t(num_people, false);
    std::vector<bool> y(num_people, false);
    this->person_served = t;
    this->request_acknowledged = y;
}

bool ElevatorMonitor::ComparePeople(Person* p1, Person* p2)
{
    if(p1->GetPriority() < p2->GetPriority()) {
        return true;
    } else if (p1->GetPriority() == p2->GetPriority()) {
        return (p1->GetID() < p2->GetID());
    } else {
        return false;    
    }
}


void ElevatorMonitor::TakePeople(int at_floor, bool init)
{
    __synchronized__;
    while(this->writecount || this->readcount) {
        can_write.wait();
    }
    this->writecount++;

    auto people_waiting_now = this->floors[at_floor];
    auto people_waiting_later = people_waiting_now;
    if (!(people_waiting_now.empty())) {
        //have folks
        if (init == false)
            std::sort(people_waiting_now.begin(), people_waiting_now.end(), this->ComparePeople);
        for (auto k: people_waiting_now) {
            if (this->Enter(k)) {
                // remove from waiting list :: floors
                people_waiting_later.erase(std::find(people_waiting_later.begin(), people_waiting_later.end(), k));
                // add dest to dest queue
                int dest = k->GetDestination();
                auto j = std::find(this->destination_queue.begin(), this->destination_queue.end(), dest);
                if (j == this->destination_queue.end()) {
                    this->destination_queue.push_back(dest);
                }
                this->PrintElevator();
            } else {
                // remove this person from the people serving list
                //this->people_serving.erase(std::find(this->people_serving.begin(), this->people_serving.end(), k));
            }
        }
        this->floors[at_floor] = people_waiting_later;
    }

    this->writecount--;
    can_read.notifyAll();
    can_write.notify();
}

void ElevatorMonitor::RemovePeople(int at_floor)
{
    __synchronized__;
    while(this->writecount || this->readcount) {
        can_write.wait();
    }
    this->writecount++;

    std::vector<Person*> working_people(this->people);
    for (auto k: working_people) {
        if (this->Leave(k)) {
            this->PrintElevator();
        }
    }

    this->writecount--;
    can_read.notifyAll();
    can_write.notify();
}

bool ElevatorMonitor::Enter(Person* person)
{
    bool entered = false;
    if (this->current_floor != person->GetInitialFloor()) {
        return entered;
    }
    if ((this->current_people + 1 > this->person_capacity) || (this->current_weight + person->GetWeight() > this->weight_capacity)) {
        // keep the person waiting, as they cannot fit
        //this->people_serving.erase(std::find(this->people_serving.begin(), this->people_serving.end(), person));
        this->request_acknowledged[person->GetID()] == false;
        return entered;
    } else {
        // take the person in
        if (this->person_served[person->GetID()] == true) return entered;
        if ((this->status == MOVING_UP && person->GetDestination() > person->GetInitialFloor()) || (this->status == MOVING_DOWN && person->GetDestination() < person->GetInitialFloor())) {
            entered = true;
            this->people.push_back(person);
            this->current_people++;
            this->current_weight += person->GetWeight();
        } else {
            //keep waiting as direction does not match
        }
    }
    if (entered) {
        person->PrintEnter();   
    }
    return entered;
}

bool ElevatorMonitor::Leave(Person* person)
{
    bool left = false;
    if (this->current_floor == person->GetDestination()) {
        // let them leave
        left = true;
        auto k = std::find(this->people.begin(), this->people.end(), person);
        if (k == this->people.end()) {
            return left;
        }
        this->people.erase(k);
        this->current_people--;
        this->current_weight -= person->GetWeight();
    } else {
        // dont let them leave      
    }
    if (left) {
        this->person_served[person->GetID()] = true;
        person->SetServed();
        person->PrintLeave();   
    }
    return left;
}

Status ElevatorMonitor::GetStatus()
{
    __synchronized__;
    while(this->writecount) {
        can_read.wait();
    }
    this->readcount++;

    Status r = this->status;

    this->readcount--;
    if (this->readcount == 0) {
        can_write.notify();
    }
    return r;
}

int ElevatorMonitor::GetCurrentFloor()
{
    __synchronized__;
    while(this->writecount) {
        can_read.wait();
    }
    this->readcount++;

    int r = this->current_floor;

    this->readcount--;
    if (this->readcount == 0) {
        can_write.notify();
    }

    return r;
}

int ElevatorMonitor::GetPassengerCount()
{
    __synchronized__;
    while(this->writecount) {
        can_read.wait();
    }
    this->readcount++;

    int r = this->people.size();

    this->readcount--;
    if (this->readcount == 0) {
        can_write.notify();
    }

    return r;
}

std::string ElevatorMonitor::GetDestinationQueueString() const
{
    std::string res = "";
    std::vector<int> t(this->destination_queue);
    if (this->status == MOVING_UP) {
        std::sort(t.begin(), t.end());
    } else {
        std::sort(t.begin(), t.end(), std::greater<int>());
    }
    if (!(t.empty())) {
        res += " ";
    }
    for (size_t i = 0; i < t.size(); i++) {
        res += std::to_string(t[i]);
        if (i != t.size() - 1) {
            res += ",";
        }
    }
    return res;
}

void ElevatorMonitor::PrintElevator()
{
    // Moving-up
    // Moving-down
    // Idle
    std::string statuss;
    switch(this->status) {
        case IDLE : 
          statuss = "Idle";
          break;
        case MOVING_UP: 
          statuss = "Moving-up";
          break;
        case MOVING_DOWN : 
          statuss = "Moving-down";
          break;
    }
    std::cout << "Elevator (" << statuss << ", " << this->current_weight << ", " << this->current_people << ", " << this->current_floor << " ->" << this->GetDestinationQueueString() << ")" << std::endl;
}

void ElevatorMonitor::SetFloors(std::vector<std::vector<Person*>> floors, int waiting_count)
{
    __synchronized__;
    while (this->readcount || this->writecount) {
        can_write.wait();
    }
    this->writecount++;

    this->floors = floors;
    this->waiting_count = waiting_count;
    
    this->writecount--;
    can_read.notifyAll();
    can_write.notify();
}

void ElevatorMonitor::MakeRequest(Person* person)
{
    __synchronized__;
    while (this->readcount || this->writecount) {
        can_write.wait();
    }
    this->writecount++;

    if (this->request_acknowledged[person->GetID()] == true && this->status != IDLE) {
        this->writecount--;
        can_read.notifyAll();
        can_write.notify();
        return;
    }

    if ((this->status == MOVING_UP && person->GetDirection() == DOWN) || (this->status == MOVING_DOWN && person->GetDirection() == UP)) {
        this->writecount--;
        can_read.notifyAll();
        can_write.notify();
        return;
    }    
    
    bool is_init = false;
    int initial_floor = -1;
    if (!(this->person_served[person->GetID()])) {
        initial_floor = person->GetInitialFloor();
        bool is_empty = this->destination_queue.empty();
        auto k = std::find(this->destination_queue.begin(), this->destination_queue.end(), initial_floor);
        Status current_status = this->status;
        
        if (initial_floor == this->current_floor) {
            is_init = true;
            initial_floor = person->GetDestination();
            k = std::find(this->destination_queue.begin(), this->destination_queue.end(), initial_floor);            
        } 

        if (initial_floor < this->current_floor) {
            current_status = MOVING_DOWN;
        } else if (initial_floor > this->current_floor) {
            current_status = MOVING_UP;
        } 

        this->status = current_status;
        
        if (k == this->destination_queue.end() && is_init == false) {
            this->destination_queue.push_back(initial_floor);
        }        
        
    } 
    
    if (!(this->person_served[person->GetID()])) {
        this->people_serving.push_back(person);
        this->request_acknowledged[person->GetID()] = true;
        person->PrintRequest();
        this->PrintElevator();

        if (is_init && this->current_floor == 0 && this->Enter(person)) {
            this->destination_queue.push_back(initial_floor);    
            this->PrintElevator();
            auto people_waiting_later = this->floors[0];
            people_waiting_later.erase(std::find(people_waiting_later.begin(), people_waiting_later.end(), person));
            this->floors[0] = people_waiting_later;
            
        }

    }

    this->writecount--;
    can_read.notifyAll();
    can_write.notify();
    
}

std::vector<std::vector<Person*>>& ElevatorMonitor::GetFloors()
{
    return this->floors;
}

int ElevatorMonitor::GetNextFloor()
{
    __synchronized__;
    while (this->writecount) {
        can_read.wait();
    }
    this->readcount++;

    std::vector<int> t(this->destination_queue);
    int lbv = 0;
    std::sort(t.begin(), t.end());
    std::vector<int>::iterator lb = std::lower_bound(t.begin(), t.end(), this->current_floor);
    switch(this->status) {
        case IDLE : 
          // DECIDE ON THE WAY TO GO -- TODO
          // break; -- INITIAL STATE? FALLBACK?
        case MOVING_UP: 
          lbv = lb - t.begin();
          if (!(t.empty()) && t[lbv] == this->current_floor) lbv++;
          break;
        case MOVING_DOWN : 
          lbv = lb - t.begin() - 1;
          if (t[lbv] == this->current_floor) lbv--;
          break;
    }
    
    int res = -1;
    if (!t.empty()) {
        res = t[lbv];    
    } 

    this->readcount--;
    if (this->readcount == 0) {
        can_write.notify();
    }

    return res;

}

void ElevatorMonitor::MoveUp()
{
    __synchronized__;
    while (this->readcount || this->writecount) {
        can_write.wait();
    }
    this->writecount++;

    this->current_floor++;
    this->RemoveFromDestinationQueue(this->current_floor);
    if (this->destination_queue.empty()) {
        this->status = IDLE;
        this->people_serving.clear();
    }
    this->PrintElevator();

    this->writecount--;
    can_read.notifyAll();
    can_write.notify();
}

void ElevatorMonitor::MoveDown()
{
    __synchronized__;
    while (this->readcount || this->writecount) {
        can_write.wait();
    }
    this->writecount++;

    this->current_floor--;
    this->RemoveFromDestinationQueue(this->current_floor);
    if (this->destination_queue.empty()) {
        this->status = IDLE;
        this->people_serving.clear();
    }
    this->PrintElevator();

    this->writecount--;
    can_read.notifyAll();
    can_write.notify();
}

void ElevatorMonitor::RemoveFromDestinationQueue(int floor)
{
    auto j = std::find(this->destination_queue.begin(), this->destination_queue.end(), floor);
    if (j != this->destination_queue.end()) {
        this->destination_queue.erase(j);    
    }
}

bool ElevatorMonitor::InElevator(Person* person)
{
    __synchronized__;
    while (this->writecount) {
        can_read.wait();
    }
    this->readcount++;

    auto j = std::find(this->people.begin(), this->people.end(), person);
    bool r = j != this->people.end();

    this->readcount--;
    if (this->readcount == 0) {
        can_write.notify();
    }
    
    return r;
}

bool ElevatorMonitor::GetServed(int person_id)
{
    __synchronized__;
    while (this->writecount) {
        can_read.wait();
    }
    this->readcount++;

    bool r = this->person_served[person_id];

    this->readcount--;
    if (this->readcount == 0) {
        can_write.notify();
    }
    
    return r;
}
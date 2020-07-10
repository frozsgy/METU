CC=g++
CXXFLAGS=-c -std=c++14
LDFLAGS=-pthread -lpthread

all: main.o person.o controller.o elevator.o
	$(CC) $(LDFLAGS) main.o person.o controller.o elevator.o -o Elevator

person.o: person.cpp
	$(CC) $(CXXFLAGS) person.cpp -o person.o

main.o: main.cpp elevator.cpp controller.cpp person.cpp
	$(CC) $(CXXFLAGS) main.cpp -o main.o

elevator.o: elevator.cpp person.cpp
	$(CC) $(CXXFLAGS) elevator.cpp -o elevator.o

controller.o: controller.cpp elevator.cpp person.cpp
	$(CC) $(CXXFLAGS) controller.cpp -o controller.o

clean:
	-rm -f *.o
	-rm Elevator

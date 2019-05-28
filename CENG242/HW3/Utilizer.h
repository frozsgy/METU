#ifndef HW3_UTILIZER_H
#define HW3_UTILIZER_H

#include <random>


// Use this class as-is.
// Usage Example:
// double new_performance = Utilizer::generatePerformance();
// Car newCar = Car("blabla", new_performance);

// int laptime_variance = Utilizer::generateLaptimeVariance(car_performance);
// Laptime variance(laptime_variance)


// DO NOT MODIFY THIS FILE.
// YOU WILL NOT SUBMIT THIS FILE

class Utilizer {
private:
    
    

public:

    static double generatePerformance() {
        std::random_device generator;
        std::normal_distribution<double> distribution(1,0.3);
        double number = distribution(generator);
        return number;

    }
    static int generateLaptimeVariance(double performance) {
        std::random_device generator;
        double std_var = 0.5;
        std::normal_distribution<double> distribution(performance,std_var);
        double number = distribution(generator);
        return number*10000;
    }

    static int generateAverageLaptime() {
        std::random_device generator;
        std::normal_distribution<double> minute_distribution(4.0,1.0);
        std::normal_distribution<double> second_distribution(30.0,15.0);
        std::normal_distribution<double> milisecond_distribution(500.0,250.0);
        double minute = minute_distribution(generator);
        double second = second_distribution(generator);
        double milisecond = milisecond_distribution(generator);
        int my_time = int(minute) * 60000 + int(second) * 1000 + int(milisecond);
        return my_time;
    }
};


#endif //HW3_UTILIZER_H
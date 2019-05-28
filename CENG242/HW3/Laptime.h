#ifndef HW3_LAPTIME_H
#define HW3_LAPTIME_H


#include <ostream>


class Laptime {

private:
    int laptime;

    Laptime *next;

    // DO NOT MODIFY THE UPPER PART
    // ADD OWN PRIVATE METHODS/PROPERTIES BELOW

public:
    /**
     * Constructor.
     *
     * @param int value in laptime.
     */
    Laptime(int laptime);

    /**
     * Copy Constructor.
     *
     * @param rhs The laptime to be copied.
     */
    Laptime(const Laptime& rhs);

    ~Laptime();

    /**
     * Sets the next chain for this Laptime.
     * You should insert the given Laptime to the object which the method is called upon
     *
     * @param next The next Laptime.
     */
    void addLaptime(Laptime *next);

    /**
     * Less than overload.
     *
     * True if this Laptime less than the rhs Laptime.
     *
     * @param rhs The Laptime to compare.
     * @return True if this laptime is smaller, false otherwise.
     */
    bool operator<(const Laptime& rhs) const;

    /**
     * Greater than overload.
     *
     * True if this Laptime greater than the rhs Laptime.
     *
     * @param rhs The Laptime to compare.
     * @return True if this laptime is bigger, false otherwise.
     */
    bool operator>(const Laptime& rhs) const;



    /**
     *  Plus overload
     *
     *  Add two Laptime and return the lhs Laptime
     *
     *  @param Laptime to add
     *  @returns Summation of the two laptime
     */
    Laptime& operator+(const Laptime& rhs);

    /**
     * Stream overload.
     *
     * What to stream:
     * minute:second.miliseconds
     *
     * Example:
     * 1:19.125
     *
     * @important Your laptime variable is representation in terms of miliseconds
     * and you have to turn it to desired outcome type
     * Print the Laptime of the object which the method is called upon.
     * @param os Stream to be used.
     * @param laptime Laptime to be streamed.
     * @return The current Stream.
     */
    friend std::ostream& operator<<(std::ostream& os, const Laptime& laptime);

    // DO NOT MODIFY THE UPPER PART
    // ADD OWN PUBLIC METHODS/PROPERTIES BELOW

    Laptime* getNext();
    int getLaptime() const;
    Laptime getLastLaptime() const;
    Laptime getTotalLaptime() const;
    Laptime getFastestLaptime() const;
    bool operator==(const Laptime& rhs) const;
    int getTotalLapCount() const;
    Laptime* getNextConst() const;

};



#endif //HW3_LAPTIME_H

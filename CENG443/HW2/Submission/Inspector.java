package project.parts.logics;

import project.SimulationRunner;
import project.components.Robot;
import project.utility.Common;

public class Inspector extends Logic {
    @Override
    public void run(Robot robot) {
        // TODO
        // Following messages are appropriate for this class
        // System.out.printf( "Robot %02d : Detected a broken robot (%02d), adding it to broken robots list.%n", ...);
        // System.out.printf( "Robot %02d : Notifying waiting fixers.%n", ...);

        /*
        The inspector checks each worker robot to see if it has lost
        one of its part (due to wear and tear). If so, the inspector puts that robot
        in a broken robots list and notifies the fixers.
         */

        // get the robot serial number
        int robotId = (Integer) Common.get(robot, "serialNo");
        // synchronize robots to avoid race conditions
        synchronized (SimulationRunner.factory.robots) {
            // check all robots to see if there is a robot with missing pieces
            for (Robot r : SimulationRunner.factory.robots) {
                // synchronize the robot being checked to avoid race conditions
                synchronized (r) {
                    // get the id of the robot that is being checked
                    int brokenRobotId = (Integer) Common.get(r, "serialNo");
                    // if the arm, payload or the logic is null, that means there is at least one missing piece
                    if (Common.get(r, "arm") == null || Common.get(r, "payload") == null || Common.get(r, "logic") == null) {
                        // arm, payload or logic is broken
                        // synchronize the broken robots list to avoid race conditions
                        synchronized (SimulationRunner.factory.brokenRobots) {
                            // check if that robot is already in the broken robots list
                            if (!SimulationRunner.factory.brokenRobots.contains(r)) {
                                // if not, add it to the list
                                SimulationRunner.factory.brokenRobots.add(r);
                                // synchronize system out to print
                                System.out.printf("Robot %02d : Detected a broken robot (%02d), adding it to broken robots list.%n", robotId, brokenRobotId);
                                System.out.printf("Robot %02d : Notifying waiting fixers.%n", robotId);
                                // notify fixers
                                SimulationRunner.factory.brokenRobots.notifyAll();
                            }
                        }
                    }
                }
            }
        }
    }

    public Inspector() {
    }
}
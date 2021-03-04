package project.parts.logics;

import project.SimulationRunner;
import project.components.Factory;
import project.components.Robot;
import project.parts.Part;
import project.utility.Common;

public class Fixer extends Logic {
    @Override
    public void run(Robot robot) {
        // TODO
        // Following messages are appropriate for this class
        // System.out.printf("Robot %02d : Fixed and waken up robot (%02d).%n", ...);
        // System.out.printf("Robot %02d : Nothing to fix, waiting!%n", ...);
        // System.out.printf("Robot %02d : Fixer woke up, going back to work.%n", ...);

        /*
        Fixer: The fixer fetches the first broken robot from the broken robots
        list. Then, it fixes and wakes up the broken robot. If there are no broken
        robots in the list, then the fixer waits.
         */

        // get the robot serial number
        int robotId = (Integer) Common.get(robot, "serialNo");
        // synchronize the broken robots list to avoid race conditions
        synchronized (SimulationRunner.factory.brokenRobots) {
            try {
                // wait until signal was received, which means there is a broken robot
                //if (SimulationRunner.factory.brokenRobots.isEmpty())
                SimulationRunner.factory.brokenRobots.wait();
            } catch (InterruptedException ignored) {
            }
        }
        // synchronize system out to print
        System.out.printf("Robot %02d : Fixer woke up, going back to work.%n", robotId);

        // synchronize broken robots before fix
        synchronized (SimulationRunner.factory.brokenRobots) {
            // is the list is empty, that means another fixer fixed the broken one before
            // print and exit peacefully
            if (SimulationRunner.factory.brokenRobots.isEmpty()) {
                // synchronize system out before print
                System.out.printf("Robot %02d : Nothing to fix, waiting!%n", robotId);
            } else {
                // there is at least one broken robot
                // get the first one
                Robot brokenRobot = SimulationRunner.factory.brokenRobots.get(0);
                // get robot id
                int brokenRobotId = (Integer) Common.get(brokenRobot, "serialNo");
                // fix the robot
                // synchronize the broken robot to avoid others fixing it as well
                synchronized (brokenRobot) {
                    // check which part is missing
                    if (Common.get(brokenRobot, "arm") == null) {
                        // need an arm
                        // create one and attach it
                        Part arm = Factory.createPart("Arm");
                        Common.set(brokenRobot, "arm", arm);
                    } else if (Common.get(brokenRobot, "payload") == null) {
                        // need payload
                        // payload must match the logic, thus we need to know the logic of the robot
                        String payloadType = Common.get(brokenRobot, "logic").getClass().getName();
                        // jump table to match payloads with logic
                        String missingPayload = "";
                        switch (payloadType) {
                            case "project.parts.logics.Fixer":
                                missingPayload = "MaintenanceKit";
                                break;
                            case "project.parts.logics.Builder":
                                missingPayload = "Welder";
                                break;
                            case "project.parts.logics.Inspector":
                                missingPayload = "Camera";
                                break;
                            case "project.parts.logics.Supplier":
                                missingPayload = "Gripper";
                                break;
                        }
                        // create proper one and attach it
                        Part missingPayloadPart = Factory.createPart(missingPayload);
                        Common.set(brokenRobot, "payload", missingPayloadPart);
                    } else if (Common.get(brokenRobot, "logic") == null) {
                        // need logic
                        // payload must match the logic, thus we need to know the payload of the robot
                        String logicType = Common.get(brokenRobot, "payload").getClass().getName();
                        // jump table to match payloads with logic
                        String missingLogic = "";
                        switch (logicType) {
                            case "project.parts.payloads.MaintenanceKit":
                                missingLogic = "Fixer";
                                break;
                            case "project.parts.payloads.Welder":
                                missingLogic = "Builder";
                                break;
                            case "project.parts.payloads.Camera":
                                missingLogic = "Inspector";
                                break;
                            case "project.parts.payloads.Gripper":
                                missingLogic = "Supplier";
                                break;
                        }
                        // create proper one and attach it
                        Part missingLogicPart = Factory.createPart(missingLogic);
                        Common.set(brokenRobot, "logic", missingLogicPart);
                    }
                    // update is waiting as false, since the robot is fixed
                    Common.set(brokenRobot, "isWaiting", false);
                    // remove from the broken robots list
                    SimulationRunner.factory.brokenRobots.remove(brokenRobot);
                    // notify
                    brokenRobot.notifyAll();
                }
                SimulationRunner.factory.brokenRobots.notifyAll();
                // synchronize and repaint robots display
                synchronized (SimulationRunner.robotsDisplay) {
                    SimulationRunner.robotsDisplay.repaint();
                }
                // synchronize system out and print
                System.out.printf("Robot %02d : Fixed and waken up robot (%02d).%n", robotId, brokenRobotId);
            }
        }
    }

    public Fixer() {
    }
}
package project.parts.logics;

import project.SimulationRunner;
import project.components.Robot;
import project.parts.Arm;
import project.parts.Base;
import project.parts.Part;
import project.parts.payloads.Payload;
import project.utility.Common;

public class Builder extends Logic {
    @Override
    public void run(Robot robot) {
        // TODO
        // Following messages are appropriate for this class
        // System.out.printf("Robot %02d : Builder cannot build anything, waiting!%n", ...);
        // System.out.printf("Robot %02d : Builder woke up, going back to work.%n", ...);
        // System.out.printf("Robot %02d : Builder attached some parts or relocated a completed robot.%n", ...);

        /*
        The builder checks all parts on the production line to see if there
        is a possibility to fulfill one production step. A production step might be
        to take an arm and attach it to a base, or to take a payload and attach it
        to a base-arm, or to finish a robot by adding the correct logic chip, or to
        pick up a completed robot and add it alongside of worker robots (to speed
        up the production), or to store the completed robot if there is enough
        storage space. If there is no possibility of fulfilling a production step, then
        the builder waits. The builder also signals the factory to stop production
        once the storage space is full.
         */

        /*
        the below portion provides a summary to the logic of the if-else blocks below.

        check if completed robot exists
            if yes, move it to either robots or storage
            if storage is full -> signal the factory to stop production
        check if robot missing a logic chip exits (base + arm + payload)
            if yes, add a logic chip
        check if robot missing payload exists (base + arm)
            if yes, add a payload
        check if robot missing arm exists (base)
            if yes, add an arm
        else
            wait
         */

        // get the robot serial number
        int robotId = (Integer) Common.get(robot, "serialNo");
        // flag that is used to know if the builder cannot build anything
        boolean canBuild = true;
        // synchronize production line to avoid race conditions
        synchronized (SimulationRunner.factory.productionLine) {
            // synchronize system out and print
            System.out.printf("Robot %02d : Builder woke up, going back to work.%n", robotId);
            // synchronize parts
            synchronized (SimulationRunner.factory.productionLine.parts) {
                // iterate through parts to check current production line
                for (Part p : SimulationRunner.factory.productionLine.parts) {
                    try {
                        // try to cast the part to a base, if it's not successful, that means the part is not a
                        // robot candidate, but it's a part only.
                        Base b = (Base) p;
                        // we have a base now, so we can check the parts of the base.
                        Arm arm = (Arm) Common.get(b, "arm");
                        Payload payload = (Payload) Common.get(b, "payload");
                        Logic logic = (Logic) Common.get(b, "logic");
                        if (logic != null) {
                            // robot is complete, move to robots line or storage
                            // check if capacity is full afterwards
                            // synchronize robots line first
                            synchronized (SimulationRunner.factory.robots) {
                                // check if there is space left in the robots line
                                if (SimulationRunner.factory.robots.size() < SimulationRunner.factory.maxRobots) {
                                    // move robot here
                                    SimulationRunner.factory.robots.add(b);
                                    // synchronize production line and remove the robot from there
                                    synchronized (SimulationRunner.factory.productionLine.parts) {
                                        SimulationRunner.factory.productionLine.parts.remove(p);
                                    }
                                    // synchronize the production display and repaint
                                    synchronized (SimulationRunner.productionLineDisplay) {
                                        SimulationRunner.productionLineDisplay.repaint();
                                    }
                                    // synchronize the robots display and repaint
                                    synchronized (SimulationRunner.robotsDisplay) {
                                        SimulationRunner.robotsDisplay.repaint();
                                    }
                                    // start the robot
                                    new Thread(b).start();
                                    // if the storage has capacity 0, and the robot line is full, then stop the production
                                    if (SimulationRunner.factory.robots.size() == SimulationRunner.factory.maxRobots && 0 == SimulationRunner.factory.storage.maxCapacity) {
                                        SimulationRunner.factory.initiateStop();
                                    }
                                    break;
                                } else if (SimulationRunner.factory.storage.robots.size() < SimulationRunner.factory.storage.maxCapacity) {
                                    // check if there is space left in the storage
                                    // synchronize storage and move robot there
                                    synchronized (SimulationRunner.factory.storage.robots) {
                                        SimulationRunner.factory.storage.robots.add(b);
                                    }
                                    // synchronize production line and remove the robot from the line
                                    synchronized (SimulationRunner.factory.productionLine.parts) {
                                        SimulationRunner.factory.productionLine.parts.remove(p);
                                    }
                                    // synchronize production line display and repaint
                                    synchronized (SimulationRunner.productionLineDisplay) {
                                        SimulationRunner.productionLineDisplay.repaint();
                                    }
                                    // synchronize storage display and repaint
                                    synchronized (SimulationRunner.storageDisplay) {
                                        SimulationRunner.storageDisplay.repaint();
                                    }
                                    // check if the storage is full
                                    if (SimulationRunner.factory.storage.robots.size() == SimulationRunner.factory.storage.maxCapacity) {
                                        // stop simulation
                                        SimulationRunner.factory.initiateStop();
                                    }
                                    break;
                                } else {
                                    // capacity is full, trigger shutdown
                                    // the logic should never reach this block, but i didn't want to remove it.
                                    SimulationRunner.factory.initiateStop();
                                    break;
                                }
                            }
                        } else if (payload != null) {
                            // the robot is missing a logic chip, check if we have the proper one in the production line
                            // flag to check if we found the logic chip
                            boolean foundLogic = false;
                            // synchronize production line to avoid race conditions
                            synchronized (SimulationRunner.factory.productionLine.parts) {
                                // iterate all parts to find a proper logic chip
                                for (Part p2 : SimulationRunner.factory.productionLine.parts) {
                                    // get class name of the part to know which kind of a chip we're looking at
                                    String partClassName = p2.getClass().getName();
                                    // if the part is a logic chip, continue
                                    if (partClassName.startsWith("project.parts.logics")) {
                                        // get the payload of current robot
                                        String attachedPayload = Common.get(p, "payload").getClass().getName();
                                        // jump table to match payload to the logic chip
                                        String missingLogic = "project.parts.logics.";
                                        switch (attachedPayload) {
                                            case "project.parts.payloads.MaintenanceKit":
                                                missingLogic += "Fixer";
                                                break;
                                            case "project.parts.payloads.Welder":
                                                missingLogic += "Builder";
                                                break;
                                            case "project.parts.payloads.Camera":
                                                missingLogic += "Inspector";
                                                break;
                                            case "project.parts.payloads.Gripper":
                                                missingLogic += "Supplier";
                                                break;
                                        }
                                        // if the logic chip name matches the jump table, attach it
                                        if (partClassName.equals(missingLogic)) {
                                            // attach it
                                            Common.set(p, "logic", p2);
                                            // synchronize and print
                                            System.out.printf("Robot %02d : Builder attached some parts or relocated a completed robot.%n", robotId);
                                            // set flag and break
                                            foundLogic = true;
                                            canBuild = true;
                                            break;
                                        }

                                    }
                                }
                                if (foundLogic) {
                                    // if attached a logic board, remove it from the production line
                                    Part attachedLogic = (Part) Common.get(p, "logic");
                                    synchronized (SimulationRunner.factory.productionLine.parts) {
                                        SimulationRunner.factory.productionLine.parts.remove(attachedLogic);
                                    }
                                    // synchronize production line display and repaint
                                    synchronized (SimulationRunner.productionLineDisplay) {
                                        SimulationRunner.productionLineDisplay.repaint();
                                    }
                                    break;
                                }
                            }
                        } else if (arm != null) {
                            // the robot is missing payload and logic, check payload first
                            // flag to check if we found a payload
                            boolean foundPayload = false;
                            // synchronize production line
                            synchronized (SimulationRunner.factory.productionLine.parts) {
                                // iterate over all parts to find a payload
                                for (Part p2 : SimulationRunner.factory.productionLine.parts) {
                                    // check if the found part is a payload
                                    String partClassName = p2.getClass().getName();
                                    if (partClassName.startsWith("project.parts.payloads")) {
                                        // attach the payload
                                        Common.set(p, "payload", p2);
                                        // synchronize system out and print
                                        System.out.printf("Robot %02d : Builder attached some parts or relocated a completed robot.%n", robotId);
                                        // set flag
                                        foundPayload = true;
                                        canBuild = true;
                                        break;
                                    }
                                }
                                if (foundPayload) {
                                    // if found payload, remove if from the line
                                    Part attachedPayload = (Part) Common.get(p, "payload");
                                    synchronized (SimulationRunner.factory.productionLine.parts) {
                                        SimulationRunner.factory.productionLine.parts.remove(attachedPayload);
                                    }
                                    // synchronize production line display and repaint
                                    synchronized (SimulationRunner.productionLineDisplay) {
                                        SimulationRunner.productionLineDisplay.repaint();
                                    }
                                    break;
                                }
                            }
                        } else {
                            // the robot is just a base, attach arm first
                            // flag to check if found an arm
                            boolean foundArm = false;
                            // synchronize production line parts
                            synchronized (SimulationRunner.factory.productionLine.parts) {
                                // iterate over production line
                                for (Part p2 : SimulationRunner.factory.productionLine.parts) {
                                    // check if the part is an arm
                                    String partClassName = p2.getClass().getName();
                                    if (partClassName.equals("project.parts.Arm")) {
                                        // attach the arm
                                        Common.set(p, "arm", p2);
                                        // synchronize system out and print
                                        System.out.printf("Robot %02d : Builder attached some parts or relocated a completed robot.%n", robotId);
                                        // set flag
                                        foundArm = true;
                                        canBuild = true;
                                        break;
                                    }
                                }
                                if (foundArm) {
                                    // if attached an arm, remove from the production line
                                    Part connectedArm = (Part) Common.get(p, "arm");
                                    synchronized (SimulationRunner.factory.productionLine.parts) {
                                        SimulationRunner.factory.productionLine.parts.remove(connectedArm);
                                    }
                                    // synchronize production line display and repaint
                                    synchronized (SimulationRunner.productionLineDisplay) {
                                        SimulationRunner.productionLineDisplay.repaint();
                                    }
                                    break;
                                }
                            }
                        }
                    } catch (ClassCastException ex) {
                        // part without a base, ignore that since it cannot be converted to a robot by itself
                        canBuild = false;
                    } catch (Exception ignore) {
                    }
                }
                SimulationRunner.factory.productionLine.parts.notifyAll();
            }
        }
        // if we successfully attached something, print it
        if (!canBuild) {
            // synchronize system out and print
            System.out.printf("Robot %02d : Builder cannot build anything, waiting!%n", robotId);
            // wait on production line
            try {
                synchronized (SimulationRunner.factory.productionLine) {
                    SimulationRunner.factory.productionLine.wait();
                }
            } catch (InterruptedException ignored) {

            }
        }
    }

    public Builder() {
    }
}
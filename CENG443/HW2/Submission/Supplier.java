package project.parts.logics;

import project.SimulationRunner;
import project.components.Factory;
import project.components.Robot;
import project.parts.Part;
import project.utility.Common;

public class Supplier extends Logic {
    @Override
    public void run(Robot robot) {
        // TODO
        // Following messages are appropriate for this class
        // System.out.printf( "Robot %02d : Supplying a random part on production line.%n", ...);
        // System.out.printf( "Robot %02d : Production line is full, removing a random part from production line.%n", ...);
        // System.out.printf( "Robot %02d : Waking up waiting builders.%n", ...);

        /*
        Supplier: If the production line is not full, the supplier randomly
        generates a robot part and places it at the next available location on the
        production line. If the production line is full, the supplier removes a
        randomly selected part on the production line. After completing either action,
        the supplier notifies the builders.
         */

        // get the robot serial number
        int robotId = (Integer) Common.get(robot, "serialNo");
        // synchronize the production line to avoid race conditions
        synchronized (SimulationRunner.factory.productionLine) {
            // check if there is empty space in the production line
            if (SimulationRunner.factory.productionLine.parts.size() < SimulationRunner.factory.productionLine.maxCapacity) {
                // there is enough empty space in the production line
                // randomly generate a robot part and place it at the next available location on the production line
                // at first i used 10 as the random integer boundary, however that caused way less arms and bases being created
                // so i incremented arms and bases by 1, which was enough for the production line.
                int randomValue = Common.random.nextInt(12);
                Part randomPart;
                switch (randomValue) {
                    case 0:
                    case 1:
                        randomPart = Factory.createPart("Arm");
                        break;
                    case 2:
                        randomPart = Factory.createPart("Builder");
                        break;
                    case 3:
                        randomPart = Factory.createPart("Fixer");
                        break;
                    case 4:
                        randomPart = Factory.createPart("Inspector");
                        break;
                    case 5:
                        randomPart = Factory.createPart("Supplier");
                        break;
                    case 6:
                        randomPart = Factory.createPart("Camera");
                        break;
                    case 7:
                        randomPart = Factory.createPart("Gripper");
                        break;
                    case 8:
                        randomPart = Factory.createPart("MaintenanceKit");
                        break;
                    case 9:
                        randomPart = Factory.createPart("Welder");
                        break;
                    default:
                        randomPart = Factory.createBase();
                        break;
                }
                // synchronize the parts and add the random generated part
                synchronized (SimulationRunner.factory.productionLine.parts) {
                    SimulationRunner.factory.productionLine.parts.add(randomPart);
                    SimulationRunner.factory.productionLine.parts.notifyAll();
                }
                // synchronize the production line display and repaint to display the newly added part
                synchronized (SimulationRunner.productionLineDisplay) {
                    SimulationRunner.productionLineDisplay.repaint();
                }
                // synchronize the system out and print
                System.out.printf("Robot %02d : Supplying a random part on production line.%n", robotId);
            } else {
                // production line is full
                // remove a random part from the production line
                // randomly pick a part using the max capacity as the boundary
                int toBeRemoved = Common.random.nextInt(SimulationRunner.factory.productionLine.maxCapacity);
                // synchronize the parts and remove the part
                synchronized (SimulationRunner.factory.productionLine.parts) {
                    SimulationRunner.factory.productionLine.parts.remove(toBeRemoved);
                }
                // synchronize the production line display and repaint
                synchronized (SimulationRunner.productionLineDisplay) {
                    SimulationRunner.productionLineDisplay.repaint();
                }
                // synchronize the system out and print
                System.out.printf("Robot %02d : Production line is full, removing a random part from production line.%n", robotId);
            }

            // synchronize system out and print
            System.out.printf("Robot %02d : Waking up waiting builders.%n", robotId);

            // synchronize production line and notify builders
            SimulationRunner.factory.productionLine.notifyAll();


        }

    }

    public Supplier() {
    }

}
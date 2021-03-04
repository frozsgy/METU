public class GotoXY extends State {

    // Variables to store the target dimensions, and the estimated time of arrival to calculate speed.
    private double targetX;
    private double targetY;
    private double eta;

    public GotoXY() {
        // Constructor calculates a random target within the upper line and the country flags.
        // A random estimated time of arrival gets calculated, so it can be used for speed calculations.
        // If the ETA is 0, then it is assigned to a random value to avoid division by zero errors.
        targetY = Common.getRandomGenerator().nextInt(Common.getCountryY() - Common.getUpperLineY() - 200) + Common.getUpperLineY();
        targetX = Common.getRandomGenerator().nextInt(Common.getWindowWidth() - 100);
        eta = (Common.getRandomGenerator().nextInt(256) + 1561963) & 0b11111111;
        if (eta == 0) eta = 8291329;
    }

    @Override
    public String toString() {
        return "GotoXY";
    }

    @Override
    public void move(Agent agent) {
        // gotoXY - determine a target and move to that target
        // The agent moves to the target with a randomly calculated speed.
        double newX = agent.position.getX() + (targetX - agent.position.getX()) / eta;
        double newY = agent.position.getY() + (targetY - agent.position.getY()) / eta;
        agent.position = new Position(newX, newY);
    }
}
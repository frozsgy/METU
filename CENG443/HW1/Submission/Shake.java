public class Shake extends State {
    @Override
    public String toString() {
        return "Shake";
    }


    @Override
    public void move(Agent agent) {
        // Shake - shakes the agent vertically and horizontally
        // A random pixel length of 3 seemed sufficient for disposition.
        int dispositionX = Common.getRandomGenerator().nextInt() & 0b11;
        int dispositionY = Common.getRandomGenerator().nextInt() & 0b11;
        double nextX = agent.position.getX() + dispositionX - 1;
        double nextY = agent.position.getY() + dispositionY - 1;
        // If the object reaches to the borders of the Y axis
        // of if the object touches the country flags, it should not move further
        // but it should shake to the other way. This was achieved with the following
        // if statements.
        if (nextY < Common.getUpperLineY()) {
            nextY += 4;
        }
        if (nextY > Common.getCountryY() - 150) {
            nextY -= 4;
        }
        if (nextX < 0) {
            nextX += 4;
        }
        if (nextX > Common.getWindowWidth() - 150) {
            nextX -= 4;
        }
        agent.position = new Position(nextX, nextY);

    }
}
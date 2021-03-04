public class ChaseClosest extends State {
    @Override
    public String toString() {
        return "ChaseClosest";
    }

    @Override
    public void move(Agent agent) {
        // Chase Closest type picks the closest order and follows it
        // Iterates through all order objects and finds the closest one using Euclidean distance.
        Order closest = null;
        double minDistance = 2400; // arbitrary number that is bigger than the diagonal resolution of the screen
        for (Order order : Common.getOrders()) {
            // Linear search to find the closest order object
            if (order.isCompleted()) continue;
            double distance = agent.position.distanceTo(order.getPosition().getX(), order.getPosition().getY());
            if (distance < minDistance) {
                minDistance = distance;
                closest = order;
            }
        }
        if (closest != null) {
            // Closest order object exists, calculate the distance
            double distanceX = closest.getPosition().getX() - agent.position.getX();
            double distanceY = closest.getPosition().getY() - agent.position.getY();
            // Generate a random estimated time of arrival to calculate a speed value
            int eta = Common.getRandomGenerator().nextInt() & 0b11111111;
            if (eta == 0) eta = 8291329;
            // Move towards the object with the given speed
            double newX = agent.position.getX() + distanceX / eta;
            double newY = agent.position.getY() + distanceY / eta;
            agent.position = new Position(newX, newY);
        }

    }
}
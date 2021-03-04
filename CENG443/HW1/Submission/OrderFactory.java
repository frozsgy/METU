public abstract class OrderFactory {


    public static boolean shouldCreateNewOrder() {
        // Randomly calculates if a new order should be generated.
        int r = Common.getRandomGenerator().nextInt() % 32;
        return r > 30;
    }

    protected double[] getOrderData(Country country) {
        // Returns a list of doubles to use with Orders.
        // r[0] = amount of order
        // r[1] = speed of order
        // r[2] = current x position of order
        // r[3] = current y position of order
        // r[4] = target's x position
        // r[5] = target's y position
        double[] r = new double[6];
        int amount = Math.abs(Common.getRandomGenerator().nextInt() % 5) + 1;
        int speed = Math.abs(Common.getRandomGenerator().nextInt() % 5);
        if (speed < 1) speed = 1;
        Position position = new Position(country.getPosition().getX() + 25 + Common.getRandomGenerator().nextInt(50), country.getPosition().getY() - 15);
        int targetX = Common.getRandomGenerator().nextInt() % Common.getWindowWidth();
        if (targetX < 0) {
            targetX = -targetX;
        }
        Position target = new Position(targetX, Common.getUpperLineY());
        r[0] = amount;
        r[1] = speed;
        r[2] = position.getX();
        r[3] = position.getY();
        r[4] = target.getX();
        r[5] = target.getY();
        return r;
    }

    abstract protected Order createNewOrder(Country country);
}
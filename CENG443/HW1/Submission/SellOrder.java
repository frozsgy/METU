import java.awt.*;

public class SellOrder extends Order {

    public SellOrder(double x, double y, Country country, int amount, int speed, Position target) {
        super(x, y);
        this.country = country;
        this.amount = amount;
        this.speed = speed;
        this.target = target;
        this.sell = true;
    }

    @Override
    public void draw(Graphics2D g2d) {
        this.createOrderStub(g2d, false);
    }

    @Override
    public void step() {
        // Moves the sell order towards the target, by a randomly determined speed.
        // If the distance between the target and the object is less than 5, then the
        // object considered as reached to the target due to the circular shape.
        // The order objects have a diameter of 10 pixels, therefore 5 is used.
        double[] distance = getDistances(this.target, speed);
        if (distance[2] < 5) {
            this.country.sellGold(this.amount);
            this.completed = true;
        } else {
            this.position.setX(this.position.getX() + distance[0]);
            this.position.setY(this.position.getY() + distance[1]);
        }
    }

}
public class BuyOrderFactory extends OrderFactory {

    @Override
    protected Order createNewOrder(Country country) {
        // An order has a random amount (between 1 and 5), a random speed, and a random path.
        // Creates a random Buy Order.
        double[] orderData = getOrderData(country);
        return new BuyOrder(orderData[2], orderData[3], country, (int) orderData[0], (int) orderData[1], new Position(orderData[4], orderData[5]));
    }
}
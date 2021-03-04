import java.util.ArrayList;
import java.util.Iterator;
import java.util.Random;

public class Common {
    private static final String title = "Gold Wars";
    private static final int windowWidth = 1366;
    private static final int windowHeight = 768;

    private static final GoldPrice goldPrice = new GoldPrice(486, 52);

    private static final Random randomGenerator = new Random(1234);
    private static final int upperLineY = 70;

    // Object arrays for the game
    private static final ArrayList<Country> countries;
    private static final ArrayList<Agent> agents;
    private static final ArrayList<OrderFactory> factories;
    private static final ArrayList<Order> orders;

    // The starting Y value for the agents
    private static final int agentY = 250;
    // The Y value for the countries
    private static final int countryY = 500;

    static {
        countries = new ArrayList<>();
        countries.add(new Country(100, countryY, "USA", "US", 50, 10000));
        countries.add(new Country(375, countryY, "Israel", "IL", 50, 10000));
        countries.add(new Country(600, countryY, "Turkey", "TR", 50, 10000));
        countries.add(new Country(850, countryY, "Russia", "RU", 50, 10000));
        countries.add(new Country(1100, countryY, "China", "CN", 50, 10000));
        agents = new ArrayList<>();
        agents.add(new BasicAgent(100, agentY, "CIA"));
        agents.add(new BasicAgent(375, agentY, "Mossad"));
        agents.add(new BasicAgent(600, agentY, "MIT"));
        agents.add(new BasicAgent(850, agentY, "SVR"));
        agents.add(new BasicAgent(1100, agentY, "MSS"));
        factories = new ArrayList<>();
        factories.add(new BuyOrderFactory());
        factories.add(new SellOrderFactory());
        orders = new ArrayList<>();

    }

    // getters
    public static String getTitle() {
        return title;
    }

    public static int getWindowWidth() {
        return windowWidth;
    }

    public static int getWindowHeight() {
        return windowHeight;
    }

    // getter
    public static GoldPrice getGoldPrice() {
        return goldPrice;
    }

    // getters
    public static Random getRandomGenerator() {
        return randomGenerator;
    }

    public static int getUpperLineY() {
        return upperLineY;
    }

    // country getters
    public static ArrayList<Country> getCountries() {
        return countries;
    }

    // agent getters
    public static ArrayList<Agent> getAgents() {
        return agents;
    }

    // factory getters
    public static ArrayList<OrderFactory> getFactories() {
        return factories;
    }

    // order getters
    public static ArrayList<Order> getOrders() {
        return orders;
    }

    // dimension getters
    public static int getAgentY() {
        return agentY;
    }
    public static int getCountryY() {
        return countryY;
    }

    public static void stepAllEntities() {
        if (randomGenerator.nextInt(200) == 0) goldPrice.step();
        // Call step method for all countries
        for (Country country : countries) {
            country.step();
        }
        // Call step method for all agents
        // Due to the possible need of removing orders while iterating,
        // an iterator was used.
        Iterator<Order> itr = orders.iterator();
        for (Agent agent : agents) {
            itr = orders.iterator();
            while (itr.hasNext()) {
                Order order = itr.next();
                // If an agent is close to the object, then it can be intercepted.
                // The hardcoded values rely on the dimensions of the objects.
                if (order.position.distanceTo(agent.getPosition().getX() + 37.5, agent.getPosition().getY() + 37.5) < 50) {
                    /*In  other words, the IA gains [order amount x current gold price] cash. If it is
                    a buy order, order’s country loses while IA’s country gains the amount of
                    cash described above. When it is a sell order, order’s country loses while
                    IA’s country gains [order amount] gold.*/
                    double gainedCash = order.amount * getGoldPrice().getCurrentPrice();
                    agent.increaseStolenMoney((int) gainedCash);
                    Country agentCountry = countries.get(agents.indexOf(agent));
                    if (order.isSell()) {
                        order.getCountry().setGold(order.getCountry().getGold() - order.amount);
                        agentCountry.setGold(agentCountry.getGold() + order.amount);
                    } else {
                        order.getCountry().setCash(order.getCountry().getCash() - (int) gainedCash);
                        agentCountry.setCash(agentCountry.getCash() + (int) gainedCash);
                    }
                    // Safe remove using iterators
                    itr.remove();
                }
            }
            agent.step();
            // Check if agent can be decorated, and decorate if so
            int index = agents.indexOf(agent);
            agent = decorate(agent);
            agents.set(index, agent);
            // Update the state of the agent with 1 in 64 chance.
            // Bitwise and operation used because the modulo operator might provide negative values.
            int r = Common.getRandomGenerator().nextInt() & 63;
            if (r == 42) {
                // 42, because it's the answer to the ultimate question of life the universe and everything.
                agent.setState(nextState());
            }
        }

        // Similarly, an iterator was used because of the possibility of removal of order.
        // An iteration without the iterator can be seen commented below.
        /*
        for (Order order: orders) {
            if (!order.isCompleted()) {
                order.step();
            } else {
                orders.remove(order);
            }
        }*/
        itr = orders.iterator();
        while (itr.hasNext()) {
            Order order = itr.next();
            if (!order.isCompleted()) {
                order.step();
            } else {
                itr.remove();
            }
        }

    }

    protected static Agent decorate(Agent agent) {
        // The static method that decorates the Agent according to the stolen money.
        if (agent.stolenMoney > 6000) {
            return new Expert(agent);
        } else if (agent.stolenMoney > 4000) {
            return new Master(agent);
        } else if (agent.stolenMoney > 2000) {
            return new Novice(agent);
        } else {
            return agent;
        }
    }

    public static State nextState() {
        // A random state generator.
        // Similarly, a bitmask was used to avoid negative values.
        int r = Common.getRandomGenerator().nextInt() & 0b1111;
        switch (r) {
            case 0:
            case 4:
            case 11:
            case 15:
                return new Rest();
            case 1:
            case 5:
            case 8:
            case 12:
                return new ChaseClosest();
            case 2:
            case 3:
            case 9:
            case 7:
                return new GotoXY();
            default:
                return new Shake();
        }
    }

}
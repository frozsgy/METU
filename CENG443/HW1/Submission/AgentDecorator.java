public abstract class AgentDecorator extends Agent {

    public AgentDecorator(Agent agent) {
        // Decorator constructor.
        super(agent.getPosition().getX(), agent.getPosition().getY());
        this.state = agent.getState();
        this.stolenMoney = agent.getStolenMoney();
        this.name = agent.getName();
        this.font = agent.font;
    }

}
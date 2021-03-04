public abstract class State {

    @Override
    public abstract String toString();

    // Moves the agent according to the state.
    public abstract void move(Agent agent);

}
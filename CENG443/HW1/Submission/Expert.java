import java.awt.*;

public class Expert extends AgentDecorator {
    public Expert(Agent agent) {
        // Decorates the agent as Expert
        super(agent);
    }

    @Override
    public void draw(Graphics2D g2d) {
        // Draws the rank badges
        super.draw(g2d);
        g2d.setColor(Color.WHITE);
        g2d.fillRect(position.getIntX() + 60, position.getIntY() - 30, 10, 10);
        g2d.setColor(Color.YELLOW);
        g2d.fillRect(position.getIntX() + 75, position.getIntY() - 30, 10, 10);
        g2d.setColor(Color.RED);
        g2d.fillRect(position.getIntX() + 90, position.getIntY() - 30, 10, 10);
    }


    // TODO
}
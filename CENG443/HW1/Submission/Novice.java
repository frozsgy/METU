import java.awt.*;

public class Novice extends AgentDecorator {
    public Novice(Agent agent) {
        // Decorates the agent as Novice
        super(agent);
    }

    @Override
    public void draw(Graphics2D g2d) {
        // Draws the rank badges
        super.draw(g2d);
        g2d.setColor(Color.WHITE);
        g2d.fillRect(position.getIntX() + 60, position.getIntY() - 30, 10, 10);
    }

}
import java.awt.*;

public class Master extends AgentDecorator {
    public Master(Agent agent) {
        // Decorates the agent as Master
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
    }

}
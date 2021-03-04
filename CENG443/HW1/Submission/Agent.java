import javax.swing.*;
import java.awt.*;
import java.io.IOException;

public abstract class Agent extends Entity {

    protected String name;
    protected int stolenMoney = 0;
    protected State state;
    protected Font font = new Font("Verdana", Font.BOLD, 14);

    public Agent(double x, double y) {
        super(x, y);
        this.state = Common.nextState();
    }

    public int getStolenMoney() {
        return stolenMoney;
    }

    public State getState() {
        return state;
    }

    public void setState(State state) {
        this.state = state;
    }

    public void increaseStolenMoney(int money) {
        this.stolenMoney += money;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    @Override
    public void step() {
        // Calls the move method from the state, so the Agent can move accordingly
        this.state.move(this);
    }

    protected Image getImage() throws IOException {
        // Reads the image of the Agency and returns an Image object
        String IMG_PATH = "images/" + this.getName().toLowerCase() + ".png";
        return new ImageIcon(IMG_PATH).getImage();
    }

    protected void drawCenteredString(Graphics2D g2d, String s, int columnWidth, int x, int y) {
        // Creates a centered string according to the column width, adapted from
        // https://coderanch.com/t/336616/java/Center-Align-text-drawString
        int stringLength = (int) g2d.getFontMetrics().getStringBounds(s, g2d).getWidth();
        int start = columnWidth / 2 - stringLength / 2;
        g2d.drawString(s, start + x, y);
    }

    @Override
    public void draw(Graphics2D g2d) {
        // General draw method for the Agent
        // Since the screen resolution has a width of 1376, 175 seemed fair for the agencies.
        int colWidth = 175;
        try {
            Image img = this.getImage();
            g2d.drawImage(img, position.getIntX() + 50, position.getIntY() + 15, 75, 75, null);
        } catch (IOException e) {
            e.printStackTrace();
        }
        g2d.setColor(Color.BLACK);
        g2d.setFont(font);
        drawCenteredString(g2d, this.getName(), colWidth, position.getIntX(), position.getIntY());
        g2d.setColor(Color.BLUE);
        drawCenteredString(g2d, this.getState().toString(), colWidth, position.getIntX(), position.getIntY() + 110);
        g2d.setColor(Color.RED);
        drawCenteredString(g2d, Integer.toString(this.getStolenMoney()), colWidth, position.getIntX(), position.getIntY() + 130);
    }
}
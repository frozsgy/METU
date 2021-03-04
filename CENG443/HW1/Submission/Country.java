import javax.swing.*;
import java.awt.*;
import java.io.IOException;

public class Country extends Entity {

    // Countries generate buy and sell orders at random. A country
    // has a name, some gold, some cash, and a dynamic worth (cash + gold x
    // current gold price).
    private String name;
    private int gold;
    private int cash;
    private String initials;

    private Font font = new Font("Verdana", Font.BOLD, 14);

    public Country(double x, double y, String name, String initials, int gold, int cash) {
        super(x, y);
        this.name = name;
        this.initials = initials;
        this.gold = gold;
        this.cash = cash;
    }

    private Image getImage() throws IOException {
        // Reads the image of the Agency and returns an Image object
        String IMG_PATH = "images/" + this.name.toLowerCase() + ".jpg";
        Image img = new ImageIcon(IMG_PATH).getImage();
        return img;
    }

    private void drawCenteredString(Graphics2D g2d, String s, int columnWidth, int x, int y) {
        // Creates a centered string according to the column width, adapted from
        // https://coderanch.com/t/336616/java/Center-Align-text-drawString
        int stringLength = (int) g2d.getFontMetrics().getStringBounds(s, g2d).getWidth();
        int start = columnWidth / 2 - stringLength / 2;
        g2d.drawString(s, start + x, y);
    }

    public String getInitials() {
        return initials;
    }

    public void buyGold(int amount) {
        // Called when a country buys some gold.
        this.gold += amount;
        this.cash -= Common.getGoldPrice().getCurrentPrice() * amount;
    }

    public void sellGold(int amount) {
        // Called when a country sells some gold.
        this.gold -= amount;
        this.cash += Common.getGoldPrice().getCurrentPrice() * amount;
    }

    public int getGold() {
        return gold;
    }

    public void setGold(int gold) {
        this.gold = gold;
    }

    public int getCash() {
        return cash;
    }

    public void setCash(int cash) {
        this.cash = cash;
    }

    @Override
    public void draw(Graphics2D g2d) {
        // General draw method for the Agent
        // Since the screen resolution has a width of 1376, 175 seemed fair for the countries.
        g2d.setColor(Color.BLACK);
        g2d.setFont(font);
        int colWidth = 175;
        try {
            Image img = this.getImage();
            int imgHeight = img.getHeight(null);
            int imgWidth = img.getWidth(null);
            int flagHeight = 100;
            int flagWidth = (int) ((double) flagHeight * imgWidth / imgHeight);
            // The aspect ratio of the flags were preserved while resizing.
            // Afterwards, the width of the flag was set as the column width for that country.
            colWidth = flagWidth;
            g2d.drawImage(img, position.getIntX(), position.getIntY(), flagWidth, flagHeight, Color.BLACK, null);
        } catch (IOException e) {
            e.printStackTrace();
        }

        drawCenteredString(g2d, this.name, colWidth, position.getIntX(), position.getIntY() + 125);
        g2d.setColor(Color.YELLOW);
        drawCenteredString(g2d, this.gold + " gold", colWidth, position.getIntX(), position.getIntY() + 150);
        g2d.setColor(new Color(19, 145, 53));
        drawCenteredString(g2d, this.cash + " cash", colWidth, position.getIntX(), position.getIntY() + 175);
        g2d.setColor(Color.BLUE);
        drawCenteredString(g2d, "Worth: " + (int) this.getDynamicWorth(), colWidth, position.getIntX(), position.getIntY() + 200);

    }

    @Override
    public void step() {
        // Creates a new order if the random order generator decides to create.
        if (OrderFactory.shouldCreateNewOrder()) {
            // I wanted to take the modulo of the random integer, however I learnt that in Java
            // % operator is the remainder, not the modulo. Thus, I had to use a bitmask to
            // calculate the modulo of 2 using a bitmask.
            int nextOrderType = Common.getRandomGenerator().nextInt() & 0x1;
            Common.getOrders().add(Common.getFactories().get(nextOrderType).createNewOrder(this));
        }
    }

    public double getDynamicWorth() {
        // Method that calculates the dynamic worth of a country according to the cash, gold and gold price.
        return this.cash + this.gold * Common.getGoldPrice().getCurrentPrice();
    }

}
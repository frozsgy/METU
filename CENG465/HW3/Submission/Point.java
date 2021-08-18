import static java.lang.Math.pow;
import static java.lang.Math.sqrt;

public class Point {

    private double x;
    private double y;
    private double z;

    public Point(double x, double y, double z) {
        this.x = x;
        this.y = y;
        this.z = z;
    }

    public double getX() {
        return x;
    }

    public void setX(double x) {
        this.x = x;
    }

    public double getY() {
        return y;
    }

    public void setY(double y) {
        this.y = y;
    }

    public double getZ() {
        return z;
    }

    public void setZ(double z) {
        this.z = z;
    }

    public double euclidean(Point p) {
        double x_distance = this.x - p.x;
        double y_distance = this.y - p.y;
        double z_distance = this.z - p.z;
        return sqrt(pow(x_distance, 2) + pow(y_distance, 2) + pow(z_distance, 2));
    }
}

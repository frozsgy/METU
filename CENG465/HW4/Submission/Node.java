public class Node implements Comparable<Node> {

    private String name;
    private int degree;

    public Node(String name, int degree) {
        this.name = name;
        this.degree = degree;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public int getDegree() {
        return degree;
    }

    public void setDegree(int degree) {
        this.degree = degree;
    }


    @Override
    public int compareTo(Node o) {
        int intCompare = Integer.compare(this.degree, o.getDegree());
        if (intCompare == 0) {
            return this.name.compareTo(o.getName());
        } else {
            return intCompare;
        }
    }

    @Override
    public String toString() {
        return "Node{" +
                "name='" + name + '\'' +
                ", degree=" + degree +
                '}';
    }
}

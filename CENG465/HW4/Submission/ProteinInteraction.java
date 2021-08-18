import java.util.*;

import static java.util.Collections.max;

public class ProteinInteraction {

    private Map<String, HashSet<String>> graph;
    private Map<String, Integer> degrees;
    private Map<String, Integer> cores;
    private List<Node> nodes;

    public ProteinInteraction() {
        this.graph = new HashMap<>();
        this.degrees = new HashMap<>();
        this.cores = new HashMap<>();
        this.nodes = new ArrayList<>();
    }

    public void insert(String interaction) {
        String[] split = interaction.split("\t");
        HashSet<String> strings;
        if (this.graph.containsKey(split[0])) {
            strings = this.graph.get(split[0]);
            strings.add(split[1]);
        } else {
            strings = new HashSet<>();
            strings.add(split[1]);
            this.graph.put(split[0], strings);
        }


        if (this.graph.containsKey(split[1])) {
            strings = this.graph.get(split[1]);
            strings.add(split[0]);
        } else {
            strings = new HashSet<>();
            strings.add(split[0]);
            this.graph.put(split[1], strings);
        }

    }


    public void calculateDegrees() {
        for (String key : this.graph.keySet()) {
            HashSet<String> value = this.graph.get(key);
            int memberSize = value.size();
            this.degrees.put(key, memberSize);
            this.cores.put(key, memberSize);
            this.nodes.add(new Node(key, memberSize));
        }
        Collections.sort(this.nodes);
    }

    public void calculateCoreValues() {
        List<Integer> boundaries = new ArrayList<>();
        boundaries.add(0);
        int current = 0;
        ListIterator<Node> it = this.nodes.listIterator();
        while (it.hasNext()) {
            int index = it.nextIndex();
            Node value = it.next();
            if (this.degrees.get(value.getName()) > current) {
                int difference = this.degrees.get(value.getName()) - current;
                for (int i = 0; i < difference; i++) {
                    boundaries.add(index);
                }
                current = this.degrees.get(value.getName());
            }
        }
        Map<String, Integer> positions = new HashMap<>();
        it = this.nodes.listIterator();
        while (it.hasNext()) {
            int index = it.nextIndex();
            Node value = it.next();
            positions.put(value.getName(), index);
        }

        for (Node node : this.nodes) {
            for (String neighbour : this.graph.get(node.getName())) {
                if (this.cores.get(neighbour) > this.cores.get(node.getName())) {
                    this.graph.get(neighbour).remove(node.getName());
                    int position = positions.get(neighbour);
                    int binStart = boundaries.get(this.cores.get(neighbour));
                    positions.replace(neighbour, binStart);
                    positions.replace(this.nodes.get(binStart).getName(), position);
                    Collections.swap(this.nodes, binStart, position);
                    Integer neighbourBoundary = boundaries.get(this.cores.get(neighbour));
                    boundaries.set(this.cores.get(neighbour), ++neighbourBoundary);
                    Integer neighbourCore = this.cores.get(neighbour);
                    this.cores.replace(neighbour, --neighbourCore);
                }
            }
        }

    }

    public void printCores() {
        int maxCore = max(this.cores.values()) + 1;
        for (int i = 1; i < maxCore; i++) {
            int finalI = i;
            long proteinCount = this.cores.values().stream().filter(x -> x == finalI).count();
            if (proteinCount != 0) {
                System.out.println("For k = " + i + " there are " + proteinCount + " proteins.");
            }
        }
    }

}

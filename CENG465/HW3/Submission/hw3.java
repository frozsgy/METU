import java.io.BufferedReader;
import java.io.FileNotFoundException;
import java.io.FileReader;
import java.io.IOException;
import java.text.DecimalFormat;
import java.text.DecimalFormatSymbols;
import java.util.*;

import static java.lang.System.exit;

public class hw3 {

    private final List<Atom> atoms = new ArrayList<>();
    private double maxDistance = 0;
    private Atom pairOne = null;
    private Atom pairTwo = null;

    private List<String> parsePdb(String fileName) {
        List<String> lines = new ArrayList<>();
        BufferedReader reader = null;
        try {
            reader = new BufferedReader(new FileReader(fileName));
        } catch (FileNotFoundException e) {
            System.out.println("File " + fileName + " cannot be found");
            exit(-1);
        }
        String currentLine = null;
        do {
            try {
                currentLine = reader.readLine();
                lines.add(currentLine);
            } catch (IOException e) {
                System.out.println("File " + fileName + " cannot be read");
                exit(-1);
            }
        } while (currentLine != null);
        try {
            reader.close();
        } catch (IOException e) {
            e.printStackTrace();
            System.out.println("File " + fileName + " cannot be found");
            exit(-1);
        }
        return lines;
    }

    private void findMostDistantPair() {
        for (Atom a : this.atoms) {
            for (Atom b : this.atoms) {
                if (a == b) {
                    continue;
                }
                double euclidean = a.getP().euclidean(b.getP());
                if (euclidean > this.maxDistance) {
                    this.maxDistance = euclidean;
                    this.pairOne = a;
                    this.pairTwo = b;
                }
            }
        }
    }

    public hw3(String fileName) {
        List<String> strings = this.parsePdb(fileName);
        for (String s : strings) {
            if (s == null) {
                continue;
            }
            if (!s.startsWith("ATOM")) {
                continue;
            }
            try {
                Atom t = new Atom(s);
                if (t.isAlphaCarbon()) {
                    this.atoms.add(t);
                }
            } catch (Exception e) {
                System.err.println("Given pdb file does not contain valid ATOM descriptions!");
            }           
        }
    }

    private static String handle(String fileName) {
        hw3 h = new hw3(fileName);
        h.findMostDistantPair();
        DecimalFormat format = new DecimalFormat("0.000");
		format.setDecimalFormatSymbols(DecimalFormatSymbols.getInstance(Locale.ENGLISH));
        return "Diameter = " + format.format(h.maxDistance) + " Angstroms\n" + "Between " + h.pairOne + " and " + h.pairTwo;
    }

    public static String testCase(Integer key, String value) {
        return "#" + key + "\n" + value + "\n" + handle(value);
    }

    public static void main(String[] args) {
        if (args.length == 0) {
            Map<Integer, String> proteins = new HashMap<>();
            proteins.put(1, "1aon.pdb");
            proteins.put(2, "3i84.pdb");
            proteins.put(3, "3wtg.pdb");
            proteins.put(4, "5roo.pdb");
            proteins.put(5, "6zgd.pdb");
            proteins.put(6, "7bjs.pdb");
            proteins.put(7, "7c3a.pdb");
            proteins.put(8, "7kmm.pdb");
            proteins.put(9, "7m5e.pdb");
            proteins.put(10, "7oco.pdb");
            proteins.forEach((k, v) -> System.out.println(testCase(k,v)));
        } else {
            System.out.println(handle(args[0]));
        }
        
    }
}

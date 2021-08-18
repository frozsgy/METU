import java.io.BufferedReader;
import java.io.FileNotFoundException;
import java.io.FileReader;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import static java.lang.System.exit;

public class KCore {

    private List<String> parseFile(String fileName) {
        List<String> lines = new ArrayList<>();
        BufferedReader reader = null;
        try {
            reader = new BufferedReader(new FileReader(fileName));
        } catch (FileNotFoundException e) {
            System.err.println("File " + fileName + " cannot be found");
            exit(-1);
        }
        String currentLine = null;
        do {
            try {
                currentLine = reader.readLine();
                if (currentLine != null) {
                    lines.add(currentLine);
                }
            } catch (IOException e) {
                System.err.println("File " + fileName + " cannot be read");
                exit(-1);
            }
        } while (currentLine != null);
        try {
            reader.close();
        } catch (IOException e) {
            e.printStackTrace();
            System.err.println("File " + fileName + " cannot be found");
            exit(-1);
        }
        return lines;
    }


    private static void calculateCores(String filename) {
        ProteinInteraction proteinInteraction = new ProteinInteraction();
        KCore kc = new KCore();
        List<String> q = kc.parseFile(filename);
        for (String s : q) {
            proteinInteraction.insert(s);
        }
        proteinInteraction.calculateDegrees();
        proteinInteraction.calculateCoreValues();
        proteinInteraction.printCores();
    }

    private static void printUsage() {
        System.out.println("Usage: java KCore filename");
        exit(1);
    }


    public static void main(String[] args) {
        if (args.length == 0) {
            printUsage();
        } else {
            calculateCores(args[0]);
        }
    }

}

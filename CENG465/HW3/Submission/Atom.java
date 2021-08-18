public class Atom {

    private String recordName;
    private int serial;
    private String name;
    private char altLoc;
    private String resName;
    private char chainId;
    private int resSeq;
    private char iCode;
    private Point p;
    private double occupancy;
    private double tempFactor;
    private String element;
    private String charge;

    public Atom(String line) {
        this.recordName = line.substring(0, 6);
        String ss = line.substring(6, 11);
        this.serial = Integer.parseInt(line.substring(6, 11).trim());
        this.name = line.substring(12, 16);
        this.altLoc = line.charAt(16);
        this.resName = line.substring(17, 20);
        this.chainId = line.charAt(21);
        this.resSeq = Integer.parseInt(line.substring(22, 26).trim());
        this.iCode = line.charAt(26);
        double x = Double.parseDouble(line.substring(30, 38).trim());
        double y = Double.parseDouble(line.substring(38, 46).trim());
        double z = Double.parseDouble(line.substring(46, 54).trim());
        this.p = new Point(x, y, z);
        this.occupancy = Double.parseDouble(line.substring(54, 60).trim());
        this.tempFactor = Double.parseDouble(line.substring(60, 66).trim());
        this.element = line.substring(76, 78);
        this.charge = line.substring(78, 80);
    }

    public Point getP() {
        return p;
    }

    public boolean isAlphaCarbon() {
        return this.name.contains("CA");
    }

    @Override
    public String toString() {
        return this.chainId + ":" + this.resName + "(" + this.resSeq + ")";
    }
}

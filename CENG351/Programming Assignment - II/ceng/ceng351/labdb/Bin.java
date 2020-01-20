package ceng.ceng351.labdb;


public class Bin {

    private int bucketSize;
    private int localDepth = 0;
    private String[] buckets;
    private int loadFactor = 0;


    public Bin(int bucketSize) {
        this.bucketSize = bucketSize;
        this.localDepth = 1;
        this.buckets = new String[bucketSize];
    }

    public int getBucketSize() {
        return this.bucketSize;
    }

    public int getLoadFactor() {
        return this.loadFactor;
    }

    public int getLocalDepth() {
        return this.localDepth;
    }

    public void setLocalDepth(int ld) {
        this.localDepth = ld;
    }

    public String getBinContents() {
        String line = "";
        for (int i = 0; i < this.loadFactor; i++) {
            line += "<" + this.buckets[i] + ">";
        }
        return line;
    }

    public int insert(String val) throws Exception {
        if (this.loadFactor < this.bucketSize) {
            this.buckets[this.loadFactor] = val;
            this.loadFactor++;
            return this.loadFactor;
        } else if (this.bucketSize != 0) {
            /** The user should never reach this state anyway, 
             *  but let's throw an exception if that happens 
             */
            throw new Exception("Couldn't insert " + val + "; bin is full, try splitting the bins");
        } else {
            return -1;
        }

    }

    public int find(String val) {
        if (this.bucketSize > 0) {
            for (int i = 0; i < this.loadFactor; i++) {
                if (val.equals(this.buckets[i])) {
                    return i;
                }
            }
            return -1;
        } else {
            return -1;
        }
    }

    protected String[] getBucketElements() {
        return this.buckets;
    }

    protected void increaseLocalDepth() {
        this.localDepth++;
    }

    protected void decreaseLocalDepth() {
        if (this.localDepth > 1) {
            this.localDepth--;    
        }        
    }

    public void delete(String val) {
        int wh = this.find(val);
        if (wh != -1) {
            String[] newBuckets = new String[this.bucketSize];
            for (int i = 0, j = 0; i < this.bucketSize; i++) {
                if (i != wh) {
                    newBuckets[j] = this.buckets[i];
                    j++;
                }
            }
            this.buckets = newBuckets;
            this.loadFactor--;
        }
    }

    
}

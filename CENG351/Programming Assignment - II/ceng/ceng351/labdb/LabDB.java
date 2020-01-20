package ceng.ceng351.labdb;

import java.util.ArrayList;

public class LabDB {

    private int bucketSize;
    private int globalDepth = 0;
    private ArrayList<Bin> table;


    public LabDB(int bucketSize) {
        this.bucketSize = bucketSize;
        this.globalDepth = 1;
        this.table = new ArrayList<Bin>(2);
        Bin bucket0 = new Bin(bucketSize);
        Bin bucket1 = new Bin(bucketSize);
        this.table.add(bucket0);
        this.table.add(bucket1);
    }

    public void enter(String studentID) {
        int id = Integer.parseInt(studentID.split("e")[1]);
        int hash = calculateHash(id);
        Bin proposed = this.table.get(hash);
        if (proposed.find(studentID) == -1) {
            if (proposed.getLoadFactor() < this.bucketSize) {
                // good nothing to do besides insert
                try {
                    proposed.insert(studentID);    
                } catch (Exception e) {
                    System.out.println("Bad things happened");
                }
            
            } else {
                // oh no split
                if (proposed.getLocalDepth() == this.globalDepth) {
                    increaseGlobalDepth();
                }
                int hh = calculateHash(Integer.parseInt(this.table.get(hash).getBucketElements()[0].split("e")[1]));
                splitBin(hh, proposed.getLocalDepth(), this.globalDepth);

               // increaseLocalDepth(id);
                enter(studentID);
            }
        } else {
            // student is already in lab, do nothing
        }
    }

    public void leave(String studentID) {
        int wh = findBinIndex(studentID);
        if (wh != -1) {
            Bin t = this.table.get(wh);
            t.delete(studentID);
            int loadFactor = t.getLoadFactor();

            int bias = 1 << (this.globalDepth - 1);
            int buddyIndex = wh > bias ? wh - bias : wh + bias; 
            int maxIndex = 1 << this.globalDepth;
            buddyIndex = buddyIndex % maxIndex;
            
            Bin buddy = this.table.get(buddyIndex);
         
            for (int i = this.globalDepth; i > 0; i--) {
                bias = 1 << (i - 1);
                buddyIndex = wh > bias ? wh - bias : wh + bias; 
                buddyIndex = buddyIndex % maxIndex;
                buddy = this.table.get(buddyIndex);
                if (buddy.getLoadFactor() != 0) {
                    break;
                }
            }
            
            ArrayList<Integer> whall = findAllBinIndexes(studentID);
            
            if (loadFactor == 0 && t.getLocalDepth() == buddy.getLocalDepth()) {
                // merge
                for (Integer m : whall) {
                    this.table.set(m, buddy);
                }
                buddy.decreaseLocalDepth();
                decreaseGlobalDepth();
            }
        }
        decreaseGlobalDepth();

        for (int i = 0; i <= this.globalDepth; i++) {
            if (this.globalDepth == 1) break;
            mergeIfEmpty(wh % (1 << this.globalDepth));
            decreaseGlobalDepth();

        }


    }

    private boolean mergeIfEmpty(int wh) {
        int bucketCount = 1 << (this.globalDepth - 1);
        int possibleBuddy = (wh + bucketCount) % (1 << this.globalDepth);
            if (this.table.get(wh).getLocalDepth() == this.table.get(possibleBuddy).getLocalDepth()) {
                if (this.table.get(wh).getLoadFactor() == 0 && this.table.get(possibleBuddy).getLoadFactor() == 0) {
                    this.table.set(wh, this.table.get(possibleBuddy));
                    this.table.get(wh).decreaseLocalDepth();
                    return true;
                }
            }
            return false;
    }

    public String search(String studentID) {
        int wh = findIndex(studentID);
        if (wh == -1) {
            return "-1";
        } else {
            return convertToBinary(findBinIndex(studentID));
        }
    }

    public void printLab() {
        System.out.println("Global depth : " + this.globalDepth);
        for(int i=0; i < this.table.size(); i++) {
            String binLine = convertToBinary(i) + " : [Local depth:" + this.table.get(i).getLocalDepth() + "]" + this.table.get(i).getBinContents();
            System.out.println(binLine);
        }
    }

    private int findIndex(String studentID) {
        int id = Integer.parseInt(studentID.split("e")[1]);
        int hash = calculateHash(id);
        Bin proposed = this.table.get(hash);
        return proposed.find(studentID);
    }

    private int findBinIndex(String studentID) {
        int id = Integer.parseInt(studentID.split("e")[1]);
        int hash = calculateHash(id);
        return hash;
    }

    private ArrayList<Integer> findAllBinIndexes(String studentID) {
        int hash = findBinIndex(studentID);
        ArrayList<Integer> indexes = new ArrayList<Integer>();
        for (int i = 0; i < this.table.size(); i++) {
            if (this.table.get(i) == this.table.get(hash)) {
                indexes.add(i);
            }
        }
        return indexes;
    }

    private String convertToBinary(int val) {
        int l = this.globalDepth;
        String r = Integer.toBinaryString(val);
        int m = r.length();
        String rr = "";
        if (m < l) {
            for (int i = 0; i < (l-m); i++)
                rr += "0";
        }
        rr += r;
        return rr;
    }


    protected int calculateHash(int val) {
        /** 
         * The math.pow method of Java returns a double, 
         * therefore it was useless for this particular method.
         * So I had to create this as a hash generator.
         * Thank you, Java.
         */
        int digits = this.globalDepth;
        int res = 0;
        int t = 1;
        for (int i = 0; i < digits; i++) {
            res |=  t << i;
        }
        return val & res;
    }

    private void increaseGlobalDepth() {
        int currentDepth = this.globalDepth;
        int newBinCount = this.table.size();
        this.globalDepth++;
        for (int i = 0; i < newBinCount; i++) {
            this.table.add(this.table.get(i));
        }
    }

    private void increaseLocalDepth(int id) {
        Bin t = this.table.get(id);
        Bin nbucket = new Bin(this.bucketSize);
        int localDepth = t.getLocalDepth();
        if (localDepth < this.globalDepth) {
            nbucket.setLocalDepth(localDepth + 1);
            int m = 1;
            int r = 0;
            for (int i = 0; i < localDepth; i++) {
                r |= (m << i) & id;
            }
            int b = 1 << localDepth;
            for (int i = r; i < this.table.size(); i += b) {
                if ((i - r) % (b*2) != 0) {
                    this.table.set(i, nbucket);
                }
            }

            t.increaseLocalDepth();

        }

    }

    private void splitBin(int id, int localDepth, int oldGlobalDepth) {
        Bin nbucket0 = new Bin(this.bucketSize);
        Bin nbucket1 = new Bin(this.bucketSize);

        nbucket0.setLocalDepth(localDepth + 1);
        nbucket1.setLocalDepth(localDepth + 1);

        if (localDepth < oldGlobalDepth) {
            int oldBias = 1 << (oldGlobalDepth - 1);
            id = id % oldBias;
        }

        Bin oldBin = this.table.get(id);
        String[] elements = oldBin.getBucketElements();

        int bias = 1 << (localDepth);

        for (int i = 0; i < this.bucketSize; i++) {
            String t = elements[i];
            int studentID = Integer.parseInt(t.split("e")[1]);
            int hash = calculateHash(studentID);
            if (hash >= bias) {
                try {
                    nbucket1.insert(t);
                } catch (Exception e) {
                    System.out.println("Bad things happened");
                }
            } else {
                try {
                    nbucket0.insert(t);
                } catch (Exception e) {
                    System.out.println("Bad things happened");
                }
            }
        }

        int walk = id;

        for (int i = 0; i < (oldGlobalDepth - localDepth + 1); i++) {
            this.table.set(walk, nbucket0);
            this.table.set((walk + bias) % this.table.size(), nbucket1);
            walk += 2*bias;
        	walk = walk % this.table.size();
        }
        
    }

    private boolean canDecreaseGlobalDepth() {
        boolean canDecrease = true;
        for (int i = 0; i < this.table.size(); i++) {
            if (this.table.get(i).getLocalDepth() == this.globalDepth) {
                canDecrease = false;
            }
        }
        return canDecrease;
    }

    private void decreaseGlobalDepth() {
        if (canDecreaseGlobalDepth()) {
            int bias = 1 << (this.globalDepth - 1);
            this.table.subList(bias, this.table.size()).clear();
            this.globalDepth--;
        }
    }


}

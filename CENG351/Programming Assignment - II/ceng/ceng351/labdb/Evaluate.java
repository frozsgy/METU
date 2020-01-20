package ceng.ceng351.labdb;

public class Evaluate {



    public static void output1(String[] args) {
        LabDB labdb = new LabDB(4);
        try {
            labdb.printLab();

        } catch (Exception e) {
            e.printStackTrace();
        }

    }


    public static void output2(String[] args) {
        LabDB labdb = new LabDB(4);
        try {
            labdb.enter("e4");
            labdb.printLab();

        } catch (Exception e) {
            e.printStackTrace();
        }

    }

    public static void output3(String[] args) {
        LabDB labdb = new LabDB(4);
        try {
            labdb.enter("e4");
            labdb.enter("e12");
            labdb.enter("e32");
            labdb.enter("e16");
            labdb.enter("e1");
            labdb.enter("e5");
            labdb.enter("e21");
            labdb.enter("e10");
            labdb.enter("e15");
            labdb.enter("e7");
            labdb.enter("e19");
            labdb.printLab();

        } catch (Exception e) {
            e.printStackTrace();
        }

    }

    public static void output4(String[] args) {
        LabDB labdb = new LabDB(4);
        try {

            labdb.enter("e4");
            labdb.enter("e12");
            labdb.enter("e32");
            labdb.enter("e16");
            labdb.enter("e1");
            labdb.enter("e5");
            labdb.enter("e21");
            labdb.enter("e10");
            labdb.enter("e15");
            labdb.enter("e7");
            labdb.enter("e19");
            labdb.enter("e13");
            /*System.out.println("After e13 enters");
            labdb.printLab();*/
            labdb.enter("e20");
            /*System.out.println("After e20 enters");
            labdb.printLab();*/
            labdb.enter("e9");
            labdb.printLab();

        } catch (Exception e) {
            e.printStackTrace();
        }

    }

    public static void output5(String[] args) {
        LabDB labdb = new LabDB(4);
        try {

            labdb.enter("e4");
            labdb.enter("e12");
            labdb.enter("e32");
            labdb.enter("e16");
            labdb.enter("e1");
            labdb.enter("e5");
            labdb.enter("e21");
            labdb.enter("e10");
            labdb.enter("e15");
            labdb.enter("e7");
            labdb.enter("e19");
            labdb.enter("e13");
            labdb.enter("e20");
            labdb.enter("e9");

            System.out.println(labdb.search("e20"));
            System.out.println(labdb.search("e21212121"));

        } catch (Exception e) {
            e.printStackTrace();
        }

    }

    public static void output6(String[] args) {
        LabDB labdb = new LabDB(4);
        try {

            labdb.enter("e4");
            labdb.enter("e12");
            labdb.enter("e32");
            labdb.enter("e16");
            labdb.enter("e1");
            labdb.enter("e5");
            labdb.enter("e21");
            labdb.enter("e10");
            labdb.enter("e15");
            labdb.enter("e7");
            labdb.enter("e19");
            labdb.enter("e13");
            labdb.enter("e20");
            labdb.enter("e9");
            labdb.leave("e32");
            labdb.leave("e16");
            labdb.leave("e10");
            labdb.leave("e9");
            labdb.leave("e1");
            labdb.leave("e4");
            labdb.leave("e12");
            labdb.leave("e20");
            labdb.leave("e5");
            labdb.leave("e21");
            labdb.leave("e13");
            labdb.printLab();

        } catch (Exception e) {
            e.printStackTrace();
        }

    }

    public static void output7(String[] args) {
        LabDB labdb = new LabDB(4);
        try {

            labdb.enter("e32");
            labdb.enter("e16");
            labdb.enter("e1");
            labdb.enter("e9");
            labdb.enter("e17");
            labdb.enter("e15");
            labdb.enter("e7");
            labdb.enter("e19");
            labdb.enter("e11");

            labdb.printLab();

        } catch (Exception e) {
            e.printStackTrace();
        }

    }

    public static void output8(String[] args) {
        LabDB labdb = new LabDB(4);
        try {

            for(int i = 1 ; i <= 140;i++){
                labdb.enter("e"+Integer.toString(i) );
            }
            labdb.printLab();
            for(int i = 135; i >=7; i--){
                labdb.leave("e"+Integer.toString(i));
            }

           /*labdb.printLab();
            labdb.leave("e137");
            labdb.leave("e140");
            labdb.leave("e139");
            labdb.leave("e138");
            labdb.leave("e136");
            labdb.leave("e2");*/

            labdb.printLab();
            System.out.println("goodbye");

        } catch (Exception e) {
            e.printStackTrace();
        }

    }

     public static void output9(String[] args) {
        LabDB labdb = new LabDB(4);
        try {

            for(int i = 1 ; i <= 125;i++){
                labdb.enter("e"+Integer.toString(i) );
            }
            labdb.printLab();
            for(int i = 120; i >=3; i--){
                labdb.leave("e"+Integer.toString(i));
            }

            labdb.printLab();

            labdb.leave("e2");

            labdb.printLab();
            System.out.println("goodbye");

        } catch (Exception e) {
            e.printStackTrace();
        }

    }



    public static void output11(String[] args) {
        LabDB labdb = new LabDB(4);
        try {

            labdb.enter("e4");
            labdb.enter("e8");
            labdb.enter("e16");
            labdb.enter("e32");
            labdb.enter("e64");
            labdb.printLab();


        } catch (Exception e) {
            e.printStackTrace();
        }

    }

    public static void output12(String[] args) {
        LabDB labDB = new LabDB(1);
        labDB.debug = true;
        try {


            labDB.enter("e16");
            labDB.enter("e32");
            labDB.printLab();
            labDB.leave("e16");
            labDB.printLab();
            labDB.leave("e32");
            labDB.printLab();


        } catch (Exception e) {
            e.printStackTrace();
        }

    }

    public static void output13(String[] args) {
        LabDB labDB = new LabDB(1);
        try {


            labDB.enter("e0");
            labDB.enter("e1");
            labDB.enter("e8");
            labDB.printLab();


        } catch (Exception e) {
            e.printStackTrace();
        }

    }

    public static void output14(String[] args) {

        try {

            LabDB labDB = new LabDB(4);
            labDB.enter("e128");
            labDB.enter("e256");
            labDB.enter("e2");
            labDB.leave("e2");
            labDB.enter("e19");
            labDB.enter("e10");
            labDB.enter("e65");
            labDB.enter("e64");
            labDB.enter("e32");
            labDB.leave("e32");
            labDB.enter("e16");
            labDB.enter("e1024");
            labDB.enter("e512");
            labDB.enter("e199");
            labDB.enter("e8");
            labDB.enter("e19");
            labDB.leave("e256");
            labDB.leave("e16");
            labDB.leave("e1024");
            labDB.leave("e512");
            labDB.leave("e199");
            labDB.leave("e128");
            labDB.leave("e65");
            labDB.leave("e10");
            labDB.leave("e8");
            labDB.printLab();
            labDB.leave("e64");
            labDB.printLab();


        } catch (Exception e) {
            e.printStackTrace();
        }

    }

    public static void output15(String[] args) {

        try {

            LabDB labdb = new LabDB(1);
            labdb.enter("e0");
            labdb.printLab();
            labdb.enter("e1");
            labdb.printLab();
            labdb.enter("e8");
            labdb.printLab();
            /*int hash = labdb.calculateHash(1);
            System.out.println("localdepth: " + labdb.table.get(hash).getLocalDepth());
            System.out.println("globaldepth: " + labdb.globalDepth);
            labdb.splitBin(hash, labdb.table.get(hash).getLocalDepth(), labdb.globalDepth);
            labdb.printLab();*/
            /*labdb.splitBin(hash, labdb.table.get(hash).getLocalDepth(), labdb.globalDepth);
            labdb.printLab();*/
/*
            labdb.increaseLocalDepth(1);
            labdb.increaseLocalDepth(1);*/
            //labdb.printLab();
            labdb.enter("e5");
            labdb.printLab();
           /* labdb.enter("e5");
            labdb.printLab();*/


        } catch (Exception e) {
            e.printStackTrace();
        }

    }


    public static void main(String[] args) {

        if (args.length > 0) {

            int val = Integer.parseInt(args[0]);
            switch(val) {
                case 1:
                    output1(args);
                break;
                case 2:
                    output2(args);
                break;
                case 3:
                    output3(args);
                break;
                case 4:
                    output4(args);
                break;
                case 5:
                    output5(args);
                break;
                case 6:
                    output6(args);
                break;
                case 7:
                    output7(args);
                break;
                case 8:
                    output8(args);
                break;
                case 9:
                    output9(args);
                break;
                case 11:
                    output11(args);
                break;
                case 12:
                    output12(args);
                break;
                case 13:
                    output13(args);
                break;
                case 14:
                    output14(args);
                break;
                case 15:
                    output15(args);
                break;

            }
        } else {
            output15(args);
        }

       


       /* System.out.println("BIN TESTS");
        Bin bin = new Bin(4);
        System.out.println("Bucket size: " + bin.getBucketSize());
        for (int i = 1; i < 5; i++) {
            System.out.println("--------------------");
            System.out.println("i: " + i); 
            System.out.println("--------------------");
            System.out.println("Load factor: " + bin.getLoadFactor());
            System.out.println("Local depth: " + bin.getLocalDepth());
            System.out.println("Contents: ");
            bin.printBinContents();
            System.out.println("Inserting " + i);
            try {
                int r = bin.insert(i);
                System.out.println("Return value: " + r);
            } catch (Exception e) {
                e.printStackTrace();
            }
            System.out.println("Contents after insertion: ");
            bin.printBinContents();
                

        }*/
        
      /*  System.out.println("HASH TESTS");
        LabDB labdb = new LabDB(4);
        for (int i = 0; i < 16; i++) {
            System.out.println("i : "  + i );
            System.out.println("hashed: " + labdb.calculateHash(i));
        }*/




        
        /*System.out.println("--------------------");
        System.out.println("DEFAULT TESTS ");
        System.out.println("--------------------");
        System.out.println("Test case 1 ");*/
     //   output1(args);
        /*System.out.println("--------------------");
        System.out.println("Test case 2 ");*/
    //    output2(args);
        /*System.out.println("--------------------");
        System.out.println("Test case 3 ");*/
    //    output3(args);
        /*System.out.println("--------------------");
        System.out.println("Test case 4 ");*/
     //   output4(args);
        /*System.out.println("--------------------");
        System.out.println("Test case 5 ");*/
     //  output5(args);
        /*System.out.println("--------------------");
        System.out.println("Test case 6 ");*/
       // output6(args);
        /*System.out.println("--------------------");
        System.out.println("DEFAULT TESTS COMPLETE ");
        System.out.println("--------------------");
        System.out.println("Test case 7 ");
        output7(args);
        System.out.println("--------------------");*/

    }

}

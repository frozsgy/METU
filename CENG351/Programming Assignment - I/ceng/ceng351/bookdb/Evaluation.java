package ceng.ceng351.bookdb;

import ceng.ceng351.bookdb.QueryResult.ResultQ1;
import ceng.ceng351.bookdb.QueryResult.ResultQ2;
import ceng.ceng351.bookdb.QueryResult.ResultQ3;
import ceng.ceng351.bookdb.QueryResult.ResultQ4;
import ceng.ceng351.bookdb.QueryResult.ResultQ5;
import ceng.ceng351.bookdb.QueryResult.ResultQ6;
import ceng.ceng351.bookdb.QueryResult.ResultQ7;
import ceng.ceng351.bookdb.QueryResult.ResultQ8;

import java.io.BufferedWriter;
import java.io.FileWriter;
import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.Vector;
import java.util.*;

public class Evaluation {

    private static String user = "1234567"; // TODO: Your userName
    private static String password = "password"; //  TODO: Your password
    private static String host = "144.122.71.65"; // host name
    private static String database = "db1234567"; // TODO: Your database name
    private static int port = 8084; // port

    private static Connection connection = null;

    public static void connect() {

        String url = "jdbc:mysql://" + host + ":" + port + "/" + database;

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            connection = DriverManager.getConnection(url, user, password);
        } catch (SQLException | ClassNotFoundException e) {
            e.printStackTrace();
        }
    }

    public static void disconnect() {

        if (connection != null) {
            try {
                connection.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
    }

    public static void addInputTitle(String title, BufferedWriter bufferedWriter) throws IOException {
        bufferedWriter.write("*** " + title + " ***" + System.getProperty("line.separator"));
    }

    public static void printAllTables(BufferedWriter bufferedWriter) throws IOException {

        String sql1 = "show tables";
        String sql2 = "describe ";

        Vector<String> tables = new Vector<>();

        try {
            // Execute query
            Statement st = connection.createStatement();
            ResultSet rs = st.executeQuery(sql1);

            // Process the result set
            while (rs.next()) {
                tables.add(rs.getString(1));
            }

            for (int i = 0; i < tables.size(); i++) {
                rs = st.executeQuery(sql2 + tables.get(i));

                // Print table name
                bufferedWriter.write("--- " + tables.get(i) + " ---" + System.getProperty("line.separator"));

                // Print field names and types
                while (rs.next()) {
                    bufferedWriter.write(rs.getString(1) + " " + rs.getString(2) + System.getProperty("line.separator"));
                }

                bufferedWriter.write(System.getProperty("line.separator"));
            }

        } catch (SQLException e) {
            printException(e);
        }
    }

    private static void printException(SQLException ex) {
        System.out.println(ex.getMessage() + "\n");
    }

    public static void printLine(String result, BufferedWriter bufferedWriter) throws IOException {
        bufferedWriter.write(result + System.getProperty("line.separator"));
    }

    public static void addDivider(BufferedWriter bufferedWriter) throws IOException {
        bufferedWriter.write(System.getProperty("line.separator") + "--------------------------------------------------------------" + System.getProperty("line.separator"));
    }

    public static void main(String[] args) {

        int numberofInsertions = 0;
        int numberofTablesCreated = 0;
        int numberofTablesDropped = 0;

        /**
         * ********************************************************
         */
        // TODO While running on your local machine, change bookdbDirectory accordingly
        String bookdbDirectory = "src" + System.getProperty("file.separator")
                + "ceng" + System.getProperty("file.separator")
                + "ceng351" + System.getProperty("file.separator")
                + "bookdb";
        /**
         * ********************************************************
         */

        // FileWriter fileWriter = null;
        BufferedWriter bufferedWriter = null;
        List<BufferedWriter> outputfiles = new ArrayList<>();

        //Connect to the database
        connect();

        // Create BOOKDB object
        BOOKDB bookDB = null;

        String dumpAuthor = "dump_author.txt";
        String dumpPublisher = "dump_publisher.txt";
        String dumpBook = "dump_book.txt";
        String dumpAuthor_of = "dump_author_of.txt";

        try {
            // Create BOOKDB object and initialize
            bookDB = new BOOKDB();
            bookDB.initialize();

            int currentCounter = 0;
            /**
             * ********************************************************
             */
            /**
             * ***********Create File Writer starts********************
             */
            /**
             * ********************************************************
             */

            for (int i = 0; i <= 15; i++) {
                FileWriter fileWriter = FileOperations.createFileWriter(bookdbDirectory + System.getProperty("file.separator")+"output" + System.getProperty("file.separator") + "Output_" + i + ".txt");
                outputfiles.add(new BufferedWriter(fileWriter));
            }
            /**
             * ********************************************************
             */
            /**
             * ***********Create File Writer ends**********************
             */
            /**
             * ********************************************************
             */
            bufferedWriter = outputfiles.get(currentCounter++);
            /**
             * ********************************************************
             */
            /**
             * ***********Drop tables starts***************************
             */
            /**
             * ********************************************************
             */
            addDivider(bufferedWriter);
            addInputTitle("Drop tables", bufferedWriter);
            numberofTablesDropped = 0;

            // Drop tables
            try {
                numberofTablesDropped = bookDB.dropTables(); 
            } catch (Exception e) {
                e.printStackTrace();
            }

            // Check if tables are dropped
            printLine("Dropped " + numberofTablesDropped + " tables.", bufferedWriter);

            addDivider(bufferedWriter);
            /**
             * ********************************************************
             */
            /**
             * ***********Drop tables ends*****************************
             */
            /**
             * ********************************************************
             */
            bufferedWriter.close();
            bufferedWriter = outputfiles.get(currentCounter++);
            /**
             * ********************************************************
             */
            /**
             * *****************Create tables starts*******************
             */
            /**
             * ********************************************************
             */
            addDivider(bufferedWriter);
            addInputTitle("Create tables", bufferedWriter);
            numberofTablesCreated = 0;

            // Create Tables
            try {
                numberofTablesCreated = bookDB.createTables(); 

                // Check if tables are created
                printLine("Created " + numberofTablesCreated + " tables.", bufferedWriter);

            } catch (Exception e) {
                printLine("Q3.1: Exception occured: \n\n" + e.toString(), bufferedWriter);
            }

            addDivider(bufferedWriter);
            /**
             * ********************************************************
             */
            /**
             * *****************Create tables ends*********************
             */
            /**
             * ********************************************************
             */
            bufferedWriter.close();
            bufferedWriter = outputfiles.get(currentCounter++);
            /**
             * ********************************************************
             */
            /**
             * *****************Insert INTO Author starts*********
             */
            /**
             * ********************************************************
             */
            addDivider(bufferedWriter);
            addInputTitle("Insert into Author", bufferedWriter);

            numberofInsertions = 0;
            Author[] authors = FileOperations.readAuthorFile(bookdbDirectory
                    + System.getProperty("file.separator") + "data" + System.getProperty("file.separator")
                    + dumpAuthor);

            numberofInsertions = bookDB.insertAuthor(authors);
            printLine(numberofInsertions + " authors are inserted.", bufferedWriter);
            addDivider(bufferedWriter);
            /**
             * ********************************************************
             */
            /**
             * *****************Insert INTO Author ends***********
             */
            /**
             * ********************************************************
             */
            bufferedWriter.close();
            bufferedWriter = outputfiles.get(currentCounter++);
            /**
             * ********************************************************
             */
            /**
             * *****************Insert INTO publisher starts****************
             */
            /**
             * ********************************************************
             */
            addDivider(bufferedWriter);
            addInputTitle("Insert into Publisher", bufferedWriter);

            numberofInsertions = 0;
            Publisher[] publishers = FileOperations.readPublisherFile(bookdbDirectory + System.getProperty("file.separator")
                    + "data" + System.getProperty("file.separator") + dumpPublisher);

            numberofInsertions = bookDB.insertPublisher(publishers);
            printLine(numberofInsertions + " publishers are inserted.", bufferedWriter);
            addDivider(bufferedWriter);
            /**
             * ********************************************************
             */
            /**
             * *****************Insert INTO publisher ends******************
             */
            /**
             * ********************************************************
             */
            bufferedWriter.close();
            bufferedWriter = outputfiles.get(currentCounter++);
            /**
             * ********************************************************
             */
            /**
             * *****************Insert INTO book starts*********
             */
            /**
             * ********************************************************
             */
            addDivider(bufferedWriter);
            addInputTitle("Insert into Book", bufferedWriter);

            numberofInsertions = 0;
            Book[] books = FileOperations.readBookFile(bookdbDirectory
                    + System.getProperty("file.separator") + "data" + System.getProperty("file.separator")
                    + dumpBook);

            numberofInsertions = bookDB.insertBook(books);
            printLine(numberofInsertions + " books are inserted.", bufferedWriter);
            addDivider(bufferedWriter);
            /**
             * ********************************************************
             */
            /**
             * *****************Insert INTO book ends***********
             */
            /**
             * ********************************************************
             */
            bufferedWriter.close();
            bufferedWriter = outputfiles.get(currentCounter++);
            /**
             * ********************************************************
             */
            /**
             * *****************Insert INTO Author_of starts************
             */
            /**
             * ********************************************************
             */
            addDivider(bufferedWriter);
            addInputTitle("Insert into Author_Of", bufferedWriter);

            numberofInsertions = 0;
            Author_of[] author_ofs = FileOperations.readAuthorOfFile(bookdbDirectory
                    + System.getProperty("file.separator") + "data" + System.getProperty("file.separator")
                    + dumpAuthor_of);

            numberofInsertions = bookDB.insertAuthor_of(author_ofs);
            printLine(numberofInsertions + " Author_ofs are inserted.", bufferedWriter);
            addDivider(bufferedWriter);
            /**
             * ********************************************************
             */
            /**
             * *****************Insert INTO Author_of ends**************
             */
            /**
             * ********************************************************
             */
            bufferedWriter.close();
            bufferedWriter = outputfiles.get(currentCounter++);

            /**
             * ********************************************************
             */
            /**
             * ********************************************************
             */
            /**
             * ********************************************************
             */
            addDivider(bufferedWriter);
            addInputTitle("Q1", bufferedWriter);
            try {

                QueryResult.ResultQ1[] q1Array = bookDB.functionQ1();

                //Header Line
                printLine("isbn" + "\t" + "first_publish_year" + "\t" + "page_count" + "\t" + "publisher_name", bufferedWriter);

                if (q1Array != null) {
                    for (ResultQ1 res : q1Array) {
                        printLine(res.toString(), bufferedWriter);
                    }
                }

            } catch (Exception e) {
                printLine("Q1: Exception occured: \n\n" + e.toString(), bufferedWriter);
            }
            addDivider(bufferedWriter);
            bufferedWriter.close();
            bufferedWriter = outputfiles.get(currentCounter++);

            /////////////////////////////////////////////////
            ////////////////////////////////////////////////
            addDivider(bufferedWriter);
            addInputTitle("Q2", bufferedWriter);
            try {

                QueryResult.ResultQ2[] q2Array = bookDB.functionQ2(14187, 29350);

                //Header Line
                printLine("publisher_id" + "\t" + "average_page_count", bufferedWriter);

                if (q2Array != null) {
                    for (ResultQ2 res : q2Array) {
                        printLine(res.toString(), bufferedWriter);
                    }
                }

            } catch (Exception e) {
                printLine("Q2: Exception occured: \n\n" + e.toString(), bufferedWriter);
            }
            addDivider(bufferedWriter);
            bufferedWriter.close();
            bufferedWriter = outputfiles.get(currentCounter++);
            /////////////////////////////////////
            ////////////////////////////////////
            addDivider(bufferedWriter);
            addInputTitle("Q3", bufferedWriter);
            try {

                QueryResult.ResultQ3[] q3Array = bookDB.functionQ3("Sue Donaldson");

                //Header Line
                printLine("book_name" + "\t" + "category" + "\t" + "first_publish_year", bufferedWriter);

                if (q3Array != null) {
                    for (ResultQ3 res : q3Array) {
                        printLine(res.toString(), bufferedWriter);
                    }
                }

            } catch (Exception e) {
                printLine("Q3: Exception occured: \n\n" + e.toString(), bufferedWriter);
            }

            addDivider(bufferedWriter);
            bufferedWriter.close();
            bufferedWriter = outputfiles.get(currentCounter++);
            /////////////////////////////////////
            ////////////////////////////////////
            /////////////////////////////////////////////////
            ////////////////////////////////////////////////
            addDivider(bufferedWriter);
            addInputTitle("Q4", bufferedWriter);
            try {

                QueryResult.ResultQ4[] q4Array = bookDB.functionQ4();

                //Header Line
                printLine("publisher_id" + "\t" + "category", bufferedWriter);

                if (q4Array != null) {
                    for (ResultQ4 res : q4Array) {
                        printLine(res.toString(), bufferedWriter);
                    }
                }

            } catch (Exception e) {
                printLine("Q4: Exception occured: \n\n" + e.toString(), bufferedWriter);
            }
            addDivider(bufferedWriter);
            bufferedWriter.close();
            bufferedWriter = outputfiles.get(currentCounter++);
            /////////////////////////////////////
            ////////////////////////////////////
            /////////////////////////////////////////////////
            ////////////////////////////////////////////////
            addDivider(bufferedWriter);
            addInputTitle("Q5", bufferedWriter);
            try {

                QueryResult.ResultQ5[] q5Array = bookDB.functionQ5(11151);

                //Header Line
                printLine("author_id" + "\t" + "author_name", bufferedWriter);

                if (q5Array != null) {
                    for (ResultQ5 res : q5Array) {
                        printLine(res.toString(), bufferedWriter);
                    }
                }

            } catch (Exception e) {
                printLine("Q5: Exception occured: \n\n" + e.toString(), bufferedWriter);
            }
            addDivider(bufferedWriter);
            bufferedWriter.close();
            bufferedWriter = outputfiles.get(currentCounter++);
            /////////////////////////////////////
            ////////////////////////////////////
            addDivider(bufferedWriter);
            addInputTitle("Q6", bufferedWriter);
            try {

                QueryResult.ResultQ6[] q6Array = bookDB.functionQ6();

                //Header Line
                printLine("author_id" + "\t" + "isbn", bufferedWriter);

                if (q6Array != null) {
                    for (ResultQ6 res : q6Array) {
                        printLine(res.toString(), bufferedWriter);
                    }
                }

            } catch (Exception e) {
                printLine("Q6: Exception occured: \n\n" + e.toString(), bufferedWriter);
            }
            addDivider(bufferedWriter);
            bufferedWriter.close();
            bufferedWriter = outputfiles.get(currentCounter++);
            /////////////////////////////////////
            ////////////////////////////////////

            addDivider(bufferedWriter);
            addInputTitle("Q7", bufferedWriter);
            try {

                QueryResult.ResultQ7[] arr = bookDB.functionQ7(3.0);

                //Header Line
                printLine("publisher_id" + "\t" + "publisher_name", bufferedWriter);

                if (arr != null) {
                    for (ResultQ7 res : arr) {
                        printLine(res.toString(), bufferedWriter);
                    }
                }

            } catch (Exception e) {
                printLine("Q7: Exception occured: \n\n" + e.toString(), bufferedWriter);
            }
            addDivider(bufferedWriter);
            bufferedWriter.close();
            bufferedWriter = outputfiles.get(currentCounter++);
            /////////////////////////////////////
            ////////////////////////////////////
            /////////////////////////////////////
            ////////////////////////////////////

            addDivider(bufferedWriter);
            addInputTitle("Q8", bufferedWriter);
            try {

                QueryResult.ResultQ8[] arr = bookDB.functionQ8();

                //Header Line
                printLine("isbn" + "\t" + "book_name" + "\t" + "rating", bufferedWriter);

                if (arr != null) {
                    for (ResultQ8 res : arr) {
                        printLine(res.toString(), bufferedWriter);
                    }
                }

            } catch (Exception e) {
                printLine("Q8: Exception occured: \n\n" + e.toString(), bufferedWriter);
            }
            addDivider(bufferedWriter);
            bufferedWriter.close();
            bufferedWriter = outputfiles.get(currentCounter++);
            /////////////////////////////////////
            ////////////////////////////////////

            /////////////////////////////////////
            ////////////////////////////////////
            addDivider(bufferedWriter);
            addInputTitle("Q9", bufferedWriter);
            try {

                double sumRating = bookDB.functionQ9("is");

                //Header Line
                printLine("Sum of all ratings is:" + sumRating, bufferedWriter);

            } catch (Exception e) {
                printLine("Q9: Exception occured: \n\n" + e.toString(), bufferedWriter);
            }
            addDivider(bufferedWriter);
            bufferedWriter.close();
            bufferedWriter = outputfiles.get(currentCounter++);
            /////////////////////////////////////
            ////////////////////////////////////

            addDivider(bufferedWriter);
            addInputTitle("Q10", bufferedWriter);
            try {

                int rowCount = bookDB.function10();

                //Header Line
                printLine("There are " + rowCount + " rows in publisher table", bufferedWriter);

            } catch (Exception e) {
                printLine("10: Exception occured: \n\n" + e.toString(), bufferedWriter);
            }
            addDivider(bufferedWriter);
            bufferedWriter.close();
            
            /////////////////////////////////////
            ////////////////////////////////////

        } catch (IOException e) {
            e.printStackTrace();
        } finally {
            try {
                //Close Writer
                if (bufferedWriter != null) {
                    bufferedWriter.close();
                }
            } catch (IOException e) {
                e.printStackTrace();
            }
            //Close Connection
            disconnect();
        }
    }

}//class

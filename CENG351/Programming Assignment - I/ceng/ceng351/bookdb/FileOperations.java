package ceng.ceng351.bookdb;

import java.io.BufferedReader;
import java.io.File;
import java.io.FileReader;
import java.io.FileWriter;
import java.io.IOException;
import java.sql.Timestamp;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

public class FileOperations {

    public static FileWriter createFileWriter(String path) throws IOException {
        File f = new File(path);

        FileWriter fileWriter = null;

        if (f.isDirectory() && !f.exists()) {
            f.mkdirs();
        } else if (!f.isDirectory() && !f.getParentFile().exists()) {
            f.getParentFile().mkdirs();
        }

        if (!f.isDirectory() && f.exists()) {
            f.delete();
        }

        fileWriter = new FileWriter(f, false);

        return fileWriter;
    }

    public static Author[] readAuthorFile(String pathToFile) {

        FileReader fileReader = null;
        BufferedReader bufferedReader = null;

        String strLine;

        List<Author> authorList = new ArrayList<>();
        Author[] authorArray = null;

        try {

            fileReader = new FileReader(pathToFile);
            bufferedReader = new BufferedReader(fileReader);

            while ((strLine = bufferedReader.readLine()) != null) {

                //parse strLine
                String[] words = strLine.split("\t");

                if (words.length < 2) {
                    System.out.println("There is a problem in Author File Reading phase");
                } else {
                    authorList.add(new Author(Integer.parseInt(words[0]), words[1]));
                }

            }//End of while

            //Close bufferedReader
            bufferedReader.close();

            authorArray = new Author[authorList.size()];
            authorList.toArray(authorArray);

        } catch (IOException e) {
            e.printStackTrace();
        }

        return authorArray;
    }

    public static Publisher[] readPublisherFile(String pathToFile) {

        FileReader fileReader = null;
        BufferedReader bufferedReader = null;

        String strLine;

        List<Publisher> publisherList = new ArrayList<>();
        Publisher[] publisherArray = null;

        try {

            fileReader = new FileReader(pathToFile);
            bufferedReader = new BufferedReader(fileReader);

            while ((strLine = bufferedReader.readLine()) != null) {

                //parse strLine
                String[] words = strLine.split("\t");

                if (words.length < 2) {
                    System.out.println("There is a problem in Publisher File Reading phase");
                } else {
                    publisherList.add(new Publisher(Integer.parseInt(words[0]), words[1]));
                }

            }//End of while

            //Close bufferedReader
            bufferedReader.close();

            publisherArray = new Publisher[publisherList.size()];
            publisherList.toArray(publisherArray);

        } catch (IOException e) {
            e.printStackTrace();
        }

        return publisherArray;
    }

    public static Book[] readBookFile(String pathToFile) {

        FileReader fileReader = null;
        BufferedReader bufferedReader = null;

        String strLine;

        List<Book> bookList = new ArrayList<>();
        Book[] bookArray = null;

        try {

            fileReader = new FileReader(pathToFile);
            bufferedReader = new BufferedReader(fileReader);

            while ((strLine = bufferedReader.readLine()) != null) {

                //parse strLine
                String[] words = strLine.split("\t");

                if (words.length < 7) {
                    System.out.println("There is a problem in Book File Reading phase");
                } else {
                    bookList.add(new Book(words[0], words[1], Integer.parseInt(words[2]), words[3], Integer.parseInt(words[4]), words[5], Double.parseDouble(words[6])));
                }

            }//End of while

            //Close bufferedReader
            bufferedReader.close();

            bookArray = new Book[bookList.size()];
            bookList.toArray(bookArray);

        } catch (IOException e) {
            e.printStackTrace();
        }

        return bookArray;
    }

    public static Author_of[] readAuthorOfFile(String pathToFile) {

        FileReader fileReader = null;
        BufferedReader bufferedReader = null;

        String strLine;
        List<Author_of> authorOfList = new ArrayList<>();
        Author_of[] authorOfArray = null;

        try {

            fileReader = new FileReader(pathToFile);
            bufferedReader = new BufferedReader(fileReader);

            while ((strLine = bufferedReader.readLine()) != null) {

                //parse strLine
                String[] words = strLine.split("\t");

                if (words.length < 2) {
                    System.out.println("There is a problem in Author_of File Reading phase");
                } else {
                    authorOfList.add(new Author_of(words[0], Integer.parseInt(words[1])));
                }

            }//End of while

            //Close bufferedReader
            bufferedReader.close();

            authorOfArray = new Author_of[authorOfList.size()];
            authorOfList.toArray(authorOfArray);

        } catch (IOException e) {
            e.printStackTrace();
        }

        return authorOfArray;
    }

}

package ceng.ceng351.bookdb;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;


/**
 * @author Mustafa Ozan Alpay
 * @project ceng 
 *
 */
public class BOOKDB implements IBOOKDB{
	
    private static String user = "2309615"; // TODO: Your userName
    private static String password = "ad3f032f"; //  TODO: Your password
    private static String host = "144.122.71.65"; // host name
    private static String database = "db2309615"; // TODO: Your database name
    private static int port = 8084; // port
     
    private static Connection connection = null;

    public BOOKDB() {
        // TODO Auto-generated constructor stub
    }

    @Override
    public void initialize() {
        String url = "jdbc:mysql://" + this.host + ":" + this.port + "/" + this.database;

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            this.connection =  DriverManager.getConnection(url, this.user, this.password);
        } catch (SQLException | ClassNotFoundException e) {
            e.printStackTrace();
        } 
    }
    
    @Override
    public int createTables() {

    	int result;
        int numberofTablesInserted = 0;

        String[] createQueries = {
        	"CREATE TABLE IF NOT EXISTS `author` ( `author_id` INT NOT NULL , `author_name` VARCHAR(60) NOT NULL , PRIMARY KEY (`author_id`));",
        	"CREATE TABLE IF NOT EXISTS `publisher` ( `publisher_id` INT NOT NULL , `publisher_name` VARCHAR(50) NOT NULL , PRIMARY KEY (`publisher_id`));",
        	"CREATE TABLE IF NOT EXISTS `book` ( `isbn` CHAR(13) NOT NULL , `book_name` VARCHAR(120) NOT NULL , `publisher_id` INT NOT NULL , `first_publish_year` CHAR(4) NOT NULL , `page_count` INT NOT NULL , `category` VARCHAR(25) NOT NULL , `rating` FLOAT NOT NULL , PRIMARY KEY (`isbn`));",
        	"CREATE TABLE IF NOT EXISTS `author_of` ( `isbn` CHAR(13) NOT NULL , `author_id` INT NOT NULL , PRIMARY KEY (`isbn`, `author_id`));",
        	"CREATE TABLE IF NOT EXISTS `phw1` ( `isbn` CHAR(13) NOT NULL , `book_name` VARCHAR(120) NOT NULL , `rating` FLOAT NOT NULL , PRIMARY KEY (`isbn`)); "
        };

        String[] alterQueries = {
        	"ALTER TABLE `book` ADD CONSTRAINT `fk_publisher_id` FOREIGN KEY (`publisher_id`) REFERENCES `publisher`(`publisher_id`) ON DELETE NO ACTION ON UPDATE RESTRICT;",
        	"ALTER TABLE `author_of` ADD CONSTRAINT `fk_author_id` FOREIGN KEY (`author_id`) REFERENCES `author`(`author_id`) ON DELETE NO ACTION ON UPDATE RESTRICT;",
        	"ALTER TABLE `author_of` ADD CONSTRAINT `fk_isbn` FOREIGN KEY (`isbn`) REFERENCES `book`(`isbn`) ON DELETE NO ACTION ON UPDATE RESTRICT;"
        };
    							
        for(String s:createQueries) {
	       	try {
	            Statement statement = this.connection.createStatement();
	            result = statement.executeUpdate(s);
	            System.out.println(result);
	            numberofTablesInserted++;
	            statement.close();
	        } catch (SQLException e) {
	            e.printStackTrace();
	        }
        }

        for(String s:alterQueries) {
	       	try {
	            Statement statement = this.connection.createStatement();
	            result = statement.executeUpdate(s);
	            System.out.println(result);
	            statement.close();
	        } catch (SQLException e) {
	            e.printStackTrace();
	        }
        }

        return numberofTablesInserted;

    }

   
    @Override
    public int dropTables() {

    	int result;
        int numberofTablesDropped = 0;
        String[] tableNames = {"author_of", "book", "publisher", "author", "phw1"};
        String queryDropTable = "DROP TABLE IF EXISTS `";

        for(String t:tableNames) {
        	try {
            Statement statement = this.connection.createStatement();
            result = statement.executeUpdate(queryDropTable + t + "`");
            numberofTablesDropped++;
            System.out.println(result);
            statement.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }

        return numberofTablesDropped;

    }

    @Override
    public int insertAuthor(Author[] authors) {

    	int result;
        int numberofInsertions = 0;

        for(Author a:authors) {
        	try {
            Statement statement = this.connection.createStatement();
            int authorID = a.getAuthor_id();
            String authorName = a.getAuthor_name();
            String authorNameStripped = authorName.replaceAll("'", "''");
            String authorQuery = "INSERT INTO `author` (`author_id`, `author_name`) VALUES ('" + authorID + "', '" + authorNameStripped + "');";
            result = statement.executeUpdate(authorQuery);
            numberofInsertions++;
            System.out.println(result);
            statement.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }

        return numberofInsertions;
    	
    }

    @Override
    public int insertBook(Book[] books) {

    	int result;
        int numberofInsertions = 0;

        for(Book b:books) {
        	try {
            Statement statement = this.connection.createStatement();
            String isbn = b.getIsbn().replaceAll("'", "''");
            String book_name = b.getBook_name().replaceAll("'", "''");
            int publisher_id = b.getPublisher_id();
            String first_publish_year = b.getFirst_publish_year().replaceAll("'", "''");
            int page_count = b.getPage_count();
            String category = b.getCategory().replaceAll("'", "''");
            double rating = b.getRating();
            String bookQuery = "INSERT INTO `book` (`isbn`, `book_name`, `publisher_id`, `first_publish_year`, `page_count`, `category`, `rating`) VALUES ('" + isbn + "', '" + book_name + "', '" + publisher_id + "', '" + first_publish_year + "', '" + page_count + "', '" + category + "', '" + rating + "');";
            result = statement.executeUpdate(bookQuery);
            numberofInsertions++;
            System.out.println(result);
            statement.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }

        return numberofInsertions;

    }

    @Override
    public int insertPublisher(Publisher[] publishers) {

    	int result;
        int numberofInsertions = 0;

        for(Publisher p:publishers) {
            try {
            Statement statement = this.connection.createStatement();
            int publisherID = p.getPublisher_id();
            String publisherName = p.getPublisher_name();
            String publisherNameStripped = publisherName.replaceAll("'", "''");
            String publisherQuery = "INSERT INTO `publisher` (`publisher_id`, `publisher_name`) VALUES ('" + publisherID + "', '" + publisherNameStripped + "');";
            result = statement.executeUpdate(publisherQuery);
            numberofInsertions++;
            System.out.println(result);
            statement.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }

        return numberofInsertions;

    }

    @Override
    public int insertAuthor_of(Author_of[] author_ofs) {

    	int result;
        int numberofInsertions = 0;

        for(Author_of a:author_ofs) {
            try {
            Statement statement = this.connection.createStatement();
            int authorID = a.getAuthor_id();
            String isbn = a.getIsbn();
            String isbnStripped = isbn.replaceAll("'", "''");
            String author_ofQuery = "INSERT INTO `author_of` (`isbn`, `author_id`) VALUES ('" + isbnStripped + "', '" + authorID + "');";
            result = statement.executeUpdate(author_ofQuery);
            numberofInsertions++;
            System.out.println(result);
            statement.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }

        return numberofInsertions;

    }

    @Override
    public QueryResult.ResultQ1[] functionQ1() {
        
        String query = "SELECT B1.isbn, B1.first_publish_year, B1.page_count, P.publisher_name FROM book B1, publisher P WHERE B1.page_count = (SELECT  MAX(B2.page_count) FROM book B2) and P.publisher_id = B1.publisher_id ORDER by B1.isbn ASC;";

        ResultSet rs;
        ArrayList<QueryResult.ResultQ1> resList = new ArrayList<QueryResult.ResultQ1>();

        try {
            Statement st = this.connection.createStatement();
            rs = st.executeQuery(query);
            int c = 0;
            while (rs.next()) {
                String isbn = rs.getString("isbn");
                String first_publish_year = rs.getString("first_publish_year");
                int page_count = rs.getInt("page_count");
                String publisher_name = rs.getString("publisher_name");
                QueryResult.ResultQ1 book = new QueryResult.ResultQ1(isbn, first_publish_year, page_count, publisher_name);
                resList.add(book);
                c++;
            }
            st.close();
        } catch (SQLException e) {
            e.printStackTrace();
        }

        QueryResult.ResultQ1[] res = new QueryResult.ResultQ1[resList.size()];

        for (int i = 0; i < resList.size(); i++) {
            res[i] = resList.get(i);
        }

    	return res;

    }
    
    @Override
    public QueryResult.ResultQ2[] functionQ2(int author_id1, int author_id2) {

        String query = "SELECT publisher_id, AVG(page_count) from book WHERE publisher_id IN (SELECT DISTINCT publisher_id from book WHERE isbn IN (SELECT DISTINCT A1.isbn from author_of A1, author_of A2 WHERE A1.isbn = A2.isbn and A1.author_id = " + author_id1 + " and A2.author_id = " + author_id2 + ")) GROUP by publisher_id ORDER by publisher_id ASC;";

        //String query = "SELECT DISTINCT A1.isbn from author_of A1, author_of A2 WHERE A1.isbn = A2.isbn and A1.author_id = " + author_id1 + " and A2.author_id = " + author_id2 + ";";

    	ResultSet rs;
        ArrayList<QueryResult.ResultQ2> resList = new ArrayList<QueryResult.ResultQ2>();

        try {
            Statement st = this.connection.createStatement();
            rs = st.executeQuery(query);
            int c = 0;
            while (rs.next()) {
                double page_count = rs.getDouble(2);
                int publisher_id = rs.getInt("publisher_id");
                QueryResult.ResultQ2 publisher = new QueryResult.ResultQ2(publisher_id, page_count);
                resList.add(publisher);
                c++;
            }
            st.close();
        } catch (SQLException e) {
            e.printStackTrace();
        }

        QueryResult.ResultQ2[] res = new QueryResult.ResultQ2[resList.size()];

        for (int i = 0; i < resList.size(); i++) {
            res[i] = resList.get(i);
        }

        return res;

    }
    
    @Override
    public QueryResult.ResultQ3[] functionQ3(String author_name) {

        String author_name_parsed = author_name.replaceAll("'", "''");
        String query = "SELECT book_name, category, first_publish_year FROM book JOIN author_of ON author_of.isbn = book.isbn WHERE author_id = (SELECT `author_id` FROM `author` WHERE `author_name` = '" + author_name_parsed + "') and first_publish_year = (SELECT MIN(first_publish_year) FROM book JOIN author_of ON author_of.isbn = book.isbn WHERE author_id = (SELECT `author_id` FROM `author` WHERE `author_name` = '" + author_name_parsed + "')) ORDER by book_name, category, first_publish_year ASC;";

        // SELECT book_name, category, first_publish_year FROM book JOIN author_of ON author_of.isbn = book.isbn WHERE author_id = (SELECT `author_id` FROM `author` WHERE `author_name` = 'Berkan M. Simsek') and first_publish_year = (SELECT MIN(first_publish_year) FROM book JOIN author_of ON author_of.isbn = book.isbn WHERE author_id = (SELECT `author_id` FROM `author` WHERE `author_name` = 'Berkan M. Simsek')) ORDER by book_name, category, first_publish_year;


        ResultSet rs;
        ArrayList<QueryResult.ResultQ3> resList = new ArrayList<QueryResult.ResultQ3>();

        try {
            Statement st = this.connection.createStatement();
            rs = st.executeQuery(query);
            int c = 0;
            while (rs.next()) {
                String book_name = rs.getString("book_name");
                String category = rs.getString("category");
                String first_publish_year = rs.getString("first_publish_year");
                QueryResult.ResultQ3 book = new QueryResult.ResultQ3(book_name, category, first_publish_year);
                resList.add(book);
                c++;
            }
            st.close();
        } catch (SQLException e) {
            e.printStackTrace();
        }

        QueryResult.ResultQ3[] res = new QueryResult.ResultQ3[resList.size()];

        for (int i = 0; i < resList.size(); i++) {
            res[i] = resList.get(i);
        }

        return res;

    }

    @Override
    public QueryResult.ResultQ4[] functionQ4() {

        ResultSet rs;
        ArrayList<QueryResult.ResultQ4> resList = new ArrayList<QueryResult.ResultQ4>();
        
        String query = "SELECT P.publisher_id, P.category from (SELECT DISTINCT publisher_id FROM `book` GROUP BY publisher_id HAVING COUNT(*) > 2 and AVG(rating) > 3 and `publisher_id` IN (SELECT publisher_id from publisher WHERE LENGTH(publisher_name)-LENGTH(REPLACE(publisher_name, ' ', '')) > 1) ORDER by publisher_id) Q, (SELECT DISTINCT category, publisher_id from book ORDER by category) P WHERE P.publisher_id = Q.publisher_id ORDER by P.publisher_id, P.category ASC";

        try {
            Statement st = this.connection.createStatement();
            rs = st.executeQuery(query);
            int c = 0;
            while (rs.next()) {
                int publisher_id = rs.getInt("publisher_id");
                String category = rs.getString("category");
                QueryResult.ResultQ4 temp = new QueryResult.ResultQ4(publisher_id, category);
                resList.add(temp);
                c++;
            }
            st.close();
        } catch (SQLException e) {
            e.printStackTrace();
        }

        QueryResult.ResultQ4[] res = new QueryResult.ResultQ4[resList.size()];

        for (int i = 0; i < resList.size(); i++) {
            res[i] = resList.get(i);
        }

    	return res;

    }
    
    @Override
    public QueryResult.ResultQ5[] functionQ5(int author_id) {
        
        /*SELECT Q.dpid, P.aname, P.aid from 
        (SELECT DISTINCT B.publisher_id AS dpid FROM book B, author_of A WHERE A.isbn = B.isbn and A.author_id = 35933) AS Q
        INNER JOIN 
        (SELECT A2.author_name AS aname, A2.author_id AS aid, B1.publisher_id AS bpid from book B1, author_of A1, author A2 WHERE B1.isbn = A1.isbn and A1.author_id = A2.author_id) AS P
        ON 
        Q.dpid = P.bpid;*/

        //String findPublishers = "SELECT DISTINCT B.publisher_id FROM book B, author_of A WHERE A.isbn = B.isbn and A.author_id = " + author_id;

        String query = "SELECT P.aid, P.aname from (SELECT DISTINCT B.publisher_id AS dpid FROM book B, author_of A WHERE A.isbn = B.isbn and A.author_id = " + author_id + ") AS Q LEFT OUTER JOIN (SELECT DISTINCT A2.author_name AS aname, A2.author_id AS aid, B1.publisher_id AS bpid from book B1, author_of A1, author A2 WHERE B1.isbn = A1.isbn and A1.author_id = A2.author_id) AS P ON Q.dpid = P.bpid  GROUP by P.aname, P.aid HAVING COUNT(P.aid) = (SELECT DISTINCT COUNT(B.publisher_id) FROM book B, author_of A WHERE A.isbn = B.isbn and A.author_id = " + author_id + ") ORDER BY `P`.`aid` ASC";

        ResultSet rs;
        ArrayList<QueryResult.ResultQ5> resList = new ArrayList<QueryResult.ResultQ5>();

        try {
            Statement st = this.connection.createStatement();
            rs = st.executeQuery(query);
            int c = 0;
            while (rs.next()) {
                String author_name = rs.getString("aname");
                int author_id_2 = rs.getInt("aid");
                QueryResult.ResultQ5 author = new QueryResult.ResultQ5(author_id_2, author_name);
                resList.add(author);
                c++;
            }
            st.close();
        } catch (SQLException e) {
            e.printStackTrace();
        }

        QueryResult.ResultQ5[] res = new QueryResult.ResultQ5[resList.size()];

        for (int i = 0; i < resList.size(); i++) {
            res[i] = resList.get(i);
        }

        return res;

    }
    
    @Override
    public QueryResult.ResultQ6[] functionQ6() {

        //String query = "SELECT DISTINCT baid FROM (SELECT COUNT(B.book_name) AS bc, A.author_id as baid  FROM book B, author_of A WHERE B.isbn = A.isbn and NOT EXISTS (SELECT * from book B2, author_of A2 WHERE A2.author_id != A.author_id and B.publisher_id = B2.publisher_id and B2.isbn = A2.isbn) GROUP by A.author_id) Q JOIN (SELECT COUNT(B1.book_name) AS ac, A1.author_id AS aaid FROM book B1, author_of A1 WHERE B1.isbn = A1.isbn GROUP by A1.author_id) P ON Q.bc = P.ac and Q.baid = P.aaid ORDER by baid ASC"; // authors

        String query = "SELECT baid, isbn from (SELECT DISTINCT baid FROM (SELECT COUNT(B.book_name) AS bc, A.author_id as baid  FROM book B, author_of A WHERE B.isbn = A.isbn and NOT EXISTS (SELECT * from book B2, author_of A2 WHERE A2.author_id != A.author_id and B.publisher_id = B2.publisher_id and B2.isbn = A2.isbn) GROUP by A.author_id) Q JOIN (SELECT COUNT(B1.book_name) AS ac, A1.author_id AS aaid FROM book B1, author_of A1 WHERE B1.isbn = A1.isbn GROUP by A1.author_id) P ON Q.bc = P.ac and Q.baid = P.aaid ORDER by baid ASC) Q, (SELECT * from author_of ORDER by isbn ASC) P WHERE P.author_id = Q.baid ORDER by baid, P.isbn ASC;";

        ResultSet rs;
        ArrayList<QueryResult.ResultQ6> resList = new ArrayList<QueryResult.ResultQ6>();

        try {
            Statement st = this.connection.createStatement();
            rs = st.executeQuery(query);
            int c = 0;
            while (rs.next()) {
                int authorID = rs.getInt("baid");
                String isbn = rs.getString("isbn");
                QueryResult.ResultQ6 book = new QueryResult.ResultQ6(authorID, isbn);
                resList.add(book);
                c++;
            }
            st.close();
        } catch (SQLException e) {
            e.printStackTrace();
        }

        QueryResult.ResultQ6[] res = new QueryResult.ResultQ6[resList.size()];

        for (int i = 0; i < resList.size(); i++) {
            res[i] = resList.get(i);
        }

        return res;

    }

    @Override
    public QueryResult.ResultQ7[] functionQ7(double rating) {

        /* SELECT * from publisher PP
        WHERE PP.publisher_id IN 
        (SELECT P.publisher_id from 
        (SELECT * FROM `book`
        WHERE category = 'Roman'
        GROUP by publisher_id
        HAVING COUNT(publisher_id) > 1) AS P
        INNER JOIN 
        (SELECT AVG(rating) as QA, publisher_id FROM book GROUP by publisher_id) AS Q
        ON P.publisher_id = Q.publisher_id
        WHERE QA > 3
        ORDER by publisher_id ASC)
        ORDER by PP.publisher_id ASC */

        String query = "SELECT * from publisher PP WHERE PP.publisher_id IN (SELECT P.publisher_id from (SELECT publisher_id FROM `book` WHERE category = 'Roman' GROUP by publisher_id HAVING COUNT(publisher_id) > 1) AS P INNER JOIN (SELECT AVG(rating) as QA, publisher_id FROM book GROUP by publisher_id) AS Q ON P.publisher_id = Q.publisher_id WHERE QA > " + rating + " ORDER by publisher_id ASC) ORDER by PP.publisher_id ASC";

        ResultSet rs;
        ArrayList<QueryResult.ResultQ7> resList = new ArrayList<QueryResult.ResultQ7>();

        try {
            Statement st = this.connection.createStatement();
            rs = st.executeQuery(query);
            int c = 0;
            while (rs.next()) {
                String publisher_name = rs.getString("publisher_name");
                int publisher_id = rs.getInt("publisher_id");
                QueryResult.ResultQ7 publisher = new QueryResult.ResultQ7(publisher_id, publisher_name);
                resList.add(publisher);
                c++;
            }
            st.close();
        } catch (SQLException e) {
            e.printStackTrace();
        }

        QueryResult.ResultQ7[] res = new QueryResult.ResultQ7[resList.size()];

        for (int i = 0; i < resList.size(); i++) {
            res[i] = resList.get(i);
        }

        return res;

    }
    
    @Override
    public QueryResult.ResultQ8[] functionQ8() {
        
        //String query = "INSERT into phw1(isbn,book_name,rating) SELECT B.isbn, B.book_name, B.rating from book B RIGHT JOIN (SELECT MIN(rating) AS mr, book_name AS bn from book WHERE book_name IN (SELECT DISTINCT book_name FROM `book` GROUP by `book_name` HAVING COUNT(book_name) > 1)) AS Q ON B.book_name = Q.bn and B.rating = Q.mr";

        String query = "INSERT into phw1(isbn,book_name,rating) SELECT isbn, book_name, rating from book B, (SELECT MIN(rating) as mr, book_name as bn from book WHERE book_name IN (SELECT DISTINCT book_name AS dbn FROM `book` GROUP by `book_name` HAVING COUNT(book_name) > 1) GROUP by book_name) Q WHERE  B.book_name = Q.bn and B.rating = Q.mr";

        ResultSet rs;

        try {
            Statement st = this.connection.createStatement();
            int t = st.executeUpdate(query);
            st.close();
        } catch (SQLException e) {
            e.printStackTrace();
        }

        String listQuery = "SELECT * from phw1 ORDER by isbn ASC";
        ArrayList<QueryResult.ResultQ8> resList = new ArrayList<QueryResult.ResultQ8>();

        try {
            Statement st = this.connection.createStatement();
            rs = st.executeQuery(listQuery);
            int c = 0;
            while (rs.next()) {
                String isbn = rs.getString("isbn");
                String book_name = rs.getString("book_name");
                double rating = rs.getDouble("rating");
                QueryResult.ResultQ8 book = new QueryResult.ResultQ8(isbn, book_name, rating);
                resList.add(book);
                c++;
            }
            st.close();
        } catch (SQLException e) {
            e.printStackTrace();
        }

        QueryResult.ResultQ8[] res = new QueryResult.ResultQ8[resList.size()];

        for (int i = 0; i < resList.size(); i++) {
            res[i] = resList.get(i);
        }

    	return res;

    }
    
    @Override
    public double functionQ9(String keyword) {

        String kw = keyword.replaceAll("'", "''");
        String query = "UPDATE `book` SET `rating` = `rating` + 1 WHERE `book_name` LIKE \"%" + keyword + "%\" AND `rating` <= 4";

        ResultSet rs;
        double res = 0;

        try {
            Statement st = this.connection.createStatement();
            int t = st.executeUpdate(query);
            st.close();
        } catch (SQLException e) {
            e.printStackTrace();
        }

        String querySum = "SELECT SUM(rating) AS s from book";

        try {
            Statement st = this.connection.createStatement();
            rs = st.executeQuery(querySum);
            rs.next();
            res = rs.getInt("s");
            st.close();
        } catch (SQLException e) {
            e.printStackTrace();
        }

    	return res;

    }
    
    @Override
    public int function10() {

        String query = "DELETE from publisher WHERE publisher_id NOT IN (SELECT DISTINCT publisher_id from book)";

        ResultSet rs;
        int res = 0;

        try {
            Statement st = this.connection.createStatement();
            int t = st.executeUpdate(query);
            st.close();
        } catch (SQLException e) {
            e.printStackTrace();
        }
        
        String resQuery = "SELECT COUNT(publisher_id) AS c FROM `publisher`";

        try {
            Statement st = this.connection.createStatement();
            rs = st.executeQuery(resQuery);
            rs.next();
            res = rs.getInt("c");
            st.close();
        } catch (SQLException e) {
            e.printStackTrace();
        }

    	return res;

    }

}

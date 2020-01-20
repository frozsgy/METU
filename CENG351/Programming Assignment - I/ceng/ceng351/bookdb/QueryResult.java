package ceng.ceng351.bookdb;

public class QueryResult {

    public static class ResultQ1 {

        String isbn;
        String first_publish_year;
        int page_count;
        String publisher_name;

        public ResultQ1(String isbn, String first_publish_year, int page_count, String publisher_name) {
            this.isbn = isbn;
            this.first_publish_year = first_publish_year;
            this.page_count = page_count;
            this.publisher_name = publisher_name;
        }

        public String toString() {
            return isbn + "\t" + first_publish_year + "\t" + page_count + "\t" + publisher_name;
        }
    }

    public static class ResultQ2 {

        int publisher_id;
        double average_page_count;

        public ResultQ2(int publisher_id, double average_page_count) {
            this.publisher_id = publisher_id;
            this.average_page_count = average_page_count;
        }

        public String toString() {
            return publisher_id + "\t" + average_page_count;
        }

    }

    public static class ResultQ3 {

        String book_name;
        String category;
        String first_publish_year;

        public ResultQ3(String book_name, String category, String first_publish_year) {
            this.book_name = book_name;
            this.category = category;
            this.first_publish_year = first_publish_year;
        }

        public String toString() {
            return book_name + "\t" + category + "\t" + first_publish_year;
        }

    }

    public static class ResultQ4 {

        int publisher_id;
        String category;

        public ResultQ4(int publisher_id, String category) {
            this.publisher_id = publisher_id;
            this.category = category;
        }

        public String toString() {
            return publisher_id + "\t" + category;
        }

    }

    public static class ResultQ5 {

        int author_id;
        String author_name;

        public ResultQ5(int author_id, String author_name) {
            this.author_id = author_id;
            this.author_name = author_name;
        }

        public String toString() {
            return author_id + "\t" + author_name;
        }

    }

    public static class ResultQ6 {

        int author_id;
        String isbn;

        public ResultQ6(int author_id, String isbn) {
            this.author_id = author_id;
            this.isbn = isbn;
        }

        public String toString() {
            return author_id + "\t" + isbn;
        }

    }

    public static class ResultQ7 {

        int publisher_id;
        String publisher_name;

        public ResultQ7(int publisher_id, String publisher_name) {
            this.publisher_id = publisher_id;
            this.publisher_name = publisher_name;
        }

        public String toString() {
            return publisher_id + "\t" + publisher_name;
        }

    }

    public static class ResultQ8 {

        String isbn;
        String book_name;
        double rating;

        public ResultQ8(String isbn, String book_name, double rating) {
            this.isbn = isbn;
            this.book_name = book_name;
            this.rating = rating;
        }

        public String toString() {
            return isbn + "\t" + book_name + "\t" + rating;
        }

    }

}

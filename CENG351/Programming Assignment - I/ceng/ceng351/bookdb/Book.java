package ceng.ceng351.bookdb;

/**
 *
 * @author abdullah
 */
public class Book {

    private String isbn;
    private String book_name;
    private int publisher_id;
    private String first_publish_year;
    private int page_count;
    private String category;
    private double rating;

    public Book(String isbn, String book_name, int publisher_id, String first_publish_year, int page_count, String category, double rating) {
        this.isbn = isbn;
        this.book_name = book_name;
        this.publisher_id = publisher_id;
        this.first_publish_year = first_publish_year;
        this.page_count = page_count;
        this.category = category;
        this.rating = rating;
    }

    public String getIsbn() {
        return isbn;
    }

    public void setIsbn(String isbn) {
        this.isbn = isbn;
    }

    public String getBook_name() {
        return book_name;
    }

    public void setBook_name(String book_name) {
        this.book_name = book_name;
    }

    public int getPublisher_id() {
        return publisher_id;
    }

    public void setPublisher_id(int publisher_id) {
        this.publisher_id = publisher_id;
    }

    public String getFirst_publish_year() {
        return first_publish_year;
    }

    public void setFirst_publish_year(String first_publish_year) {
        this.first_publish_year = first_publish_year;
    }

    public int getPage_count() {
        return page_count;
    }

    public void setPage_count(int page_count) {
        this.page_count = page_count;
    }

    public String getCategory() {
        return category;
    }

    public void setCategory(String category) {
        this.category = category;
    }

    public double getRating() {
        return rating;
    }

    public void setRating(double rating) {
        this.rating = rating;
    }

    @Override
    public String toString() {
        return isbn + "\t" + book_name + "\t" + publisher_id + "\t" + first_publish_year + "\t" + page_count + "\t" + category + "\t" + rating;
    }
}

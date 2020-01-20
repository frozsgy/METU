package ceng.ceng351.bookdb;

public class Author_of {

    private String isbn;
    private int author_id;

    public Author_of(String isbn, int author_id) {
        this.isbn = isbn;
        this.author_id = author_id;
    }

    public String getIsbn() {
        return isbn;
    }

    public void setIsbn(String isbn) {
        this.isbn = isbn;
    }

    public int getAuthor_id() {
        return author_id;
    }

    public void setAuthor_id(int author_id) {
        this.author_id = author_id;
    }

    @Override
    public String toString() {
        return isbn + "\t" + author_id;
    }

}

package ceng.ceng351.bookdb;

public class Author {

    private int author_id;
    private String author_name;

    public Author(int author_id, String author_name) {
        this.author_id = author_id;
        this.author_name = author_name;
    }

    public int getAuthor_id() {
        return author_id;
    }

    public void setAuthor_id(int author_id) {
        this.author_id = author_id;
    }

    public String getAuthor_name() {
        return author_name;
    }

    public void setAuthor_name(String author_name) {
        this.author_name = author_name;
    }

    @Override
    public String toString() {
        return author_id + "\t" + author_name;
    }

}

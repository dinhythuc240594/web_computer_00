package model;

public class NewsItem {

    private String title;
    private String summary;
    private String category;
    private String author;
    private String imagePath;
    private String link;

    public NewsItem() {
    }

    public NewsItem(String title, String summary, String category, String author, String imagePath, String link) {
        this.title = title;
        this.summary = summary;
        this.category = category;
        this.author = author;
        this.imagePath = imagePath;
        this.link = link;
    }

    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    public String getSummary() {
        return summary;
    }

    public void setSummary(String summary) {
        this.summary = summary;
    }

    public String getCategory() {
        return category;
    }

    public void setCategory(String category) {
        this.category = category;
    }

    public String getAuthor() {
        return author;
    }

    public void setAuthor(String author) {
        this.author = author;
    }

    public String getImagePath() {
        return imagePath;
    }

    public void setImagePath(String imagePath) {
        this.imagePath = imagePath;
    }

    public String getLink() {
        return link;
    }

    public void setLink(String link) {
        this.link = link;
    }
}


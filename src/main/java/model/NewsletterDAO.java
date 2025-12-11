package model;

import java.sql.Timestamp;

public class NewsletterDAO {
    private int id;
    private String email;
    private String status; // active, unsubscribed
    private Timestamp subscribed_at;
    private Timestamp unsubscribed_at;

    public NewsletterDAO() {
    }

    public NewsletterDAO(String email) {
        this.email = email;
        this.status = "active";
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public Timestamp getSubscribed_at() {
        return subscribed_at;
    }

    public void setSubscribed_at(Timestamp subscribed_at) {
        this.subscribed_at = subscribed_at;
    }

    public Timestamp getUnsubscribed_at() {
        return unsubscribed_at;
    }

    public void setUnsubscribed_at(Timestamp unsubscribed_at) {
        this.unsubscribed_at = unsubscribed_at;
    }
}


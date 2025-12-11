package service;

import model.NewsletterDAO;

import java.util.List;

public interface NewsletterService extends Service<NewsletterDAO> {
    NewsletterDAO findByEmail(String email);
    List<NewsletterDAO> findAllActive();
    List<NewsletterDAO> findAll(boolean includeUnsubscribed);
    boolean subscribe(String email);
    boolean unsubscribe(String email);
}


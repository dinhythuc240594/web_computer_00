package repository;

import model.NewsletterDAO;

import java.util.List;

public interface NewsletterRepository extends Repository<NewsletterDAO> {
    NewsletterDAO findByEmail(String email);
    List<NewsletterDAO> findAllActive();
    List<NewsletterDAO> findAll(boolean includeUnsubscribed);
    boolean unsubscribe(String email);
}


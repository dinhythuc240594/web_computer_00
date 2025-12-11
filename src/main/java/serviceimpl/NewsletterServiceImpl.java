package serviceimpl;

import java.util.List;

import javax.sql.DataSource;

import model.NewsletterDAO;
import repository.NewsletterRepository;
import repositoryimpl.NewsletterRepositoryImpl;
import service.NewsletterService;

public class NewsletterServiceImpl implements NewsletterService {

    private NewsletterRepository newsletterRepository;

    public NewsletterServiceImpl() {
        this.newsletterRepository = new NewsletterRepositoryImpl();
    }

    public NewsletterServiceImpl(DataSource ds) {
        this.newsletterRepository = new NewsletterRepositoryImpl(ds);
    }

    @Override
    public List<NewsletterDAO> getAll() {
        return newsletterRepository.getAll();
    }

    @Override
    public NewsletterDAO findById(int id) {
        return newsletterRepository.findById(id);
    }

    @Override
    public Boolean deleteById(int id) {
        return newsletterRepository.deleteById(id);
    }

    @Override
    public int count(String keyword) {
        // Có thể implement sau nếu cần tìm kiếm
        return newsletterRepository.getAll().size();
    }

    @Override
    public Boolean create(NewsletterDAO entity) {
        return newsletterRepository.create(entity);
    }

    @Override
    public Boolean update(NewsletterDAO entity) {
        return newsletterRepository.update(entity);
    }

    @Override
    public NewsletterDAO findByEmail(String email) {
        return newsletterRepository.findByEmail(email);
    }

    @Override
    public List<NewsletterDAO> findAllActive() {
        return newsletterRepository.findAllActive();
    }

    @Override
    public List<NewsletterDAO> findAll(boolean includeUnsubscribed) {
        return newsletterRepository.findAll(includeUnsubscribed);
    }

    @Override
    public boolean subscribe(String email) {
        if (email == null || email.trim().isEmpty()) {
            return false;
        }

        email = email.trim().toLowerCase();

        // Kiểm tra xem email đã đăng ký chưa
        NewsletterDAO existing = newsletterRepository.findByEmail(email);
        if (existing != null) {
            // Nếu đã unsubscribed, cập nhật lại thành active
            if ("unsubscribed".equals(existing.getStatus())) {
                existing.setStatus("active");
                existing.setUnsubscribed_at(null);
                return newsletterRepository.update(existing);
            }
            // Nếu đã active rồi thì không cần làm gì
            return true;
        }

        // Tạo mới subscription
        NewsletterDAO subscription = new NewsletterDAO(email);
        return newsletterRepository.create(subscription);
    }

    @Override
    public boolean unsubscribe(String email) {
        if (email == null || email.trim().isEmpty()) {
            return false;
        }
        return newsletterRepository.unsubscribe(email.trim().toLowerCase());
    }
}


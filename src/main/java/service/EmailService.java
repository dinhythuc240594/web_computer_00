package service;

import jakarta.servlet.ServletContext;
import jakarta.servlet.http.Part;
import model.EmailRequest;

import java.util.List;

public interface EmailService {
    void send(ServletContext ctx, EmailRequest req, List<Part> attachments) throws Exception;
}


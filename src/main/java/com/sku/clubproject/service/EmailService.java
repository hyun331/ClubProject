package com.sku.clubproject.service;
import jakarta.mail.MessagingException;
import jakarta.mail.internet.MimeMessage;

import com.sku.clubproject.model.EmailDTO;
import lombok.RequiredArgsConstructor;
import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.stereotype.Service;

@Service
@RequiredArgsConstructor
public class EmailService {
    private final JavaMailSender javaMailSender;

    private static final String senderEmail = "sus03319@skuniv.ac.kr";

    private static final Logger logger = LogManager.getLogger();

    @Autowired
    private TelegramService telegramService;


    public MimeMessage createEmail(EmailDTO emailDTO){
        MimeMessage message = javaMailSender.createMimeMessage();

        try {
            message.setFrom(senderEmail);
            message.setRecipients(MimeMessage.RecipientType.TO, emailDTO.getReceiverEmail());
            message.setSubject(emailDTO.getEmailTitle());
            String body = emailDTO.getEmailContent();
            message.setText(body,"UTF-8", "html");
        } catch (MessagingException e) {
            e.printStackTrace();
        }
        return message;
    }

    public void sendEmail(EmailDTO emailDTO) {
        MimeMessage message = createEmail(emailDTO);
        try{
            javaMailSender.send(message);
        }catch(Exception e){
            e.printStackTrace();
            logger.error("email sending error");
            telegramService.sendTelegram("email sending error");
        }
    }

}

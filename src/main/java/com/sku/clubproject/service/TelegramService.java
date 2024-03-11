package com.sku.clubproject.service;

import com.pengrad.telegrambot.TelegramBot;
import com.pengrad.telegrambot.model.Message;
import com.pengrad.telegrambot.model.request.ParseMode;
import com.pengrad.telegrambot.request.SendMessage;
import com.pengrad.telegrambot.response.SendResponse;
import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.springframework.stereotype.Service;

import java.time.LocalDateTime;
import java.time.ZoneId;
import java.time.format.DateTimeFormatter;

@Service
public class TelegramService {

    private static final Logger logger = LogManager.getLogger(TelegramService.class);

    TelegramBot bot = new TelegramBot("6703669819:AAFidAMpwUQYH1FH6NCbWD7SUof38I2MBpw");

    public void sendTelegram(String errorMsg){
        try{
            LocalDateTime currentDateTime = LocalDateTime.now(ZoneId.of("Asia/Seoul"));
            String msg = currentDateTime.format(DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss")) + " - " + errorMsg;
            SendMessage request = new SendMessage(6904918770L, msg)
                    .parseMode(ParseMode.HTML)
                    .disableWebPagePreview(true)
                    .disableNotification(false);
            SendResponse sendResponse = bot.execute(request);
            boolean ok = sendResponse.isOk();
            Message message = sendResponse.message();
        }catch (Exception e){
            e.printStackTrace();
            logger.error("telegram send error");
        }
    }
}
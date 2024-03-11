package com.sku.clubproject.controller;
import com.sku.clubproject.service.TelegramService;
import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;
import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.web.servlet.error.ErrorController;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;


@Controller
public class WebErrorController implements ErrorController {

    @Autowired
    private TelegramService telegramService;

    private Logger logger = LogManager.getLogger(WebErrorController.class);


    //에러 발생 시
    @RequestMapping("/error")
    public String handleError(HttpServletRequest request, HttpSession session, Model model) {
        Object status = request.getAttribute(RequestDispatcher.ERROR_STATUS_CODE);


        if(status != null){


            int statusCode = Integer.valueOf(status.toString());
            logger.error("error Page Open: {}\n\n\n\n\n\n\n\n", statusCode);


            model.addAttribute("statusCode", statusCode);


            telegramService.sendTelegram("club error : " + statusCode);
        }

        return "error/errorPage";
    }

}

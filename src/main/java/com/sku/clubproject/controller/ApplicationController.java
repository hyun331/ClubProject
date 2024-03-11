package com.sku.clubproject.controller;

import com.sku.clubproject.model.ApplicationDTO;
import com.sku.clubproject.model.ClubDTO;
import com.sku.clubproject.model.UserDTO;
import com.sku.clubproject.model.entity.User;
import com.sku.clubproject.service.ApplicationService;
import com.sku.clubproject.service.ClubService;
import com.sku.clubproject.service.UserService;
import jakarta.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("/application")
public class ApplicationController {
    @Autowired
    private ClubService clubService;

    @Autowired
    private ApplicationService applicationService;


    //지원서 양식 보여주기
    @GetMapping("/createApplication/{clubId}")
    public String showApplication(@PathVariable Long clubId, Model model, HttpSession session){
        ClubDTO clubDTO = clubService.selectOneClub(clubId);
        UserDTO loginUser = (UserDTO) session.getAttribute("logIn");

        model.addAttribute("club", clubDTO);
        model.addAttribute("user", loginUser);

        return "/application/application";
    }

    //지원서 등록
    @PostMapping("/createApplication")
    public String createApplication(ApplicationDTO applicationDTO){
        applicationDTO.setIsProcess(0); //아직 처리되지 않은 지원서임을 의미

        applicationService.createApplication(applicationDTO);   //db에 저장

        return "redirect:/home";
    }
}

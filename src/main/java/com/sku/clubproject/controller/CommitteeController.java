package com.sku.clubproject.controller;

import com.sku.clubproject.model.ClubDTO;
import com.sku.clubproject.model.EmailDTO;
import com.sku.clubproject.model.UserDTO;
import com.sku.clubproject.model.entity.Club;
import com.sku.clubproject.service.ClubCompositionService;
import com.sku.clubproject.service.ClubService;
import com.sku.clubproject.service.EmailService;
import com.sku.clubproject.service.UserService;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;
import lombok.extern.java.Log;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import java.util.List;


@Controller
@RequestMapping("/committee")
public class CommitteeController {

    @Autowired
    ClubService clubService;

    @Autowired
    ClubCompositionService clubCompositionService;

    @Autowired
    UserService userService;

    @Autowired
    EmailService emailService;

    //위원회 클릭 후 첫 화면
    @GetMapping("/committeePage")
    public String showCommitteePage(Model model) {
        List<ClubDTO> clubAppList = clubService.selectClubByIsRegular(0);
        model.addAttribute("clubAppList", clubAppList);
        return "/committee/committeePage";
    }


    //동아리 개설 신청 리스트 화면
    @GetMapping("/clubAppList")
    public String showClubAppList(Model model){
        List<ClubDTO> clubAppList = clubService.selectClubByIsRegular(0);
        model.addAttribute("clubAppList", clubAppList);
        model.addAttribute("function", "clubAppList");  //이 기능은 동아리 개설 신청 리스트 보여주는 기능이다.
        System.out.println("clubappList");
        return "/committee/committeePage";
    }

    //동아리 관리 화면
    @GetMapping("/clubManagement")
    public String showManagement(Model model){
        List<ClubDTO> clubList = clubService.selectClubByIsRegular(1);   //정규 동아리 리스트
        model.addAttribute("clubList", clubList);
        model.addAttribute("function", "clubManagement");   //이 기능은 동아리 관리를 보여주는 기능이다.
        return "/committee/committeePage";
    }



    //동아리 개설 신청 처리 -  승인 or 거절
    @PostMapping("/clubAppProcess")
    @Transactional  //modifying하려면 해줘야함
    public String processClubApp(EmailDTO emailDTO, @RequestParam(value = "result")String result, @RequestParam(value = "clubId")Long clubId, Model model){
        //ClubDTO clubDTO = clubService.selectOneClub(clubId);

        if(result.equals("approve")){   //동아리 개설 승인
            //clubService.changeIsRegular(clubDTO);   //정규 동아리로 등록
            clubService.changeIsRegular(clubId, 1);   //정규 동아리로 등록
            clubCompositionService.changeAllRole(clubId, "부원"); //동아리 예비 부원 모두 부원으로 등록

            UserDTO manager = userService.selectOneUser(emailDTO.getReceiverEmail());   //manager =  부장
            clubCompositionService.changeOneRole(clubId, manager.getId(), "부장"); //부장 role 등록
        }
        else{  //동아리 개설 거절
            clubService.changeIsRegular(clubId, -1);   //개설 거부된 동아리. isRegular=-1
            clubCompositionService.changeAllRole(clubId, "-1"); //개설 거부된 동아리에 신청한 사람 역할(role) -1 로  설정
        }

        emailService.sendEmail(emailDTO);   //승인 또는 거절 이메일 전송
        

        model.addAttribute("clubAppList", clubService.selectClubByIsRegular(0));    //개설 신청 동아리
        model.addAttribute("function", "clubAppList");     //개설 처리 후 다시 원래 페이지로 돌아가기 위해서 model에 넣기

        return "/committee/committeePage";
    }

//    @PostMapping("/clubWarnEmail")
//    public void sendWarnEmail(EmailDTO emailDTO){
//       emailService.sendEmail((emailDTO));
//    }

    @PostMapping("/clubWarnEmail")
    public String sendWarnEmail(EmailDTO emailDTO) {
        emailService.sendEmail(emailDTO);
        return "redirect:/committee/clubManagement"; // 리다이렉트할 경로 설정
    }



}
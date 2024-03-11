package com.sku.clubproject.controller;

import com.sku.clubproject.model.*;
import com.sku.clubproject.model.entity.ClubComposition;
import com.sku.clubproject.model.entity.User;
import com.sku.clubproject.service.*;
import jakarta.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

//동아리의 전반적인 컨트롤러
@Controller
@RequestMapping("/club")
public class ClubController {
    @Autowired
    ClubService clubService;

    @Autowired
    ClubCompositionService clubCompositionService;

    @Autowired
    private BoardService boardService;

    @Autowired
    UserService userService;

    @Autowired
    ApplicationService applicationService;


    @Autowired
    private EmailService emailService;

    //동아리 개설 화면 보여줌
    @GetMapping("/createClub")
    public String showCreateClub(){
        return "/club/createClub";
    }


    //가입한 동아리 메인 화면
    @GetMapping("/clubMain/{id}")
    public String showClubMain(@PathVariable Long id, Model model, HttpSession session){  //id==clubId
        UserDTO loginUser = (UserDTO)session.getAttribute("logIn"); //로그인 유저
        String userRole = clubCompositionService.getRole(loginUser.getId(), id);    //해당 동아리에서 유저의 역할
        model.addAttribute("role", userRole);

        ClubDTO club = clubService.selectOneClub(id);   //해당 동아리 정보
        model.addAttribute("club", club);

        List<BoardDTO> boardList = boardService.selectAllClubBoard(id, 0);    //활동내역
        model.addAttribute("boardList", boardList);

        List<String> writerName = new ArrayList<>();    //활동내역 게시글 작성자 리스트
        for(BoardDTO board : boardList){
            writerName.add(userService.getUser(board.getWriterId()).getNickname());
        }
        model.addAttribute("writerNameList", writerName);

        return "/club/clubMain";
    }


    //동아리 개설 신청한 예비 동아리 데이터베이스에 저장. club table의 isRegular column을 0으로 설정. 정식 동아리가 아님을 의미
    @PostMapping("/createClub")
    public String createPreClub(ClubDTO clubDTO, @RequestParam List<String>peopleName, @RequestParam List<String>peopleEmail){
        clubDTO.setIsRegular(0);    //isRegular=0이면 예비 동아리.
        clubDTO.setPeopleNum(peopleEmail.size());   //신청 인원 수

        Long clubId = clubService.createPreClub(clubDTO);     //예비 동아리로 등록

        clubCompositionService.createPreComposition(peopleEmail, clubId);   //예비 동아리 멤버로 등록

        return "redirect:/home";
    }


    //동아리 부원 관리 페이지
    @GetMapping("/clubMemberManagement/{id}")
    public String showMemberManagement(@PathVariable Long id, Model model){ //id=clubId
        List<ClubCompositionDTO> compositionList = clubCompositionService.selectUserEachClub(id);   //clubId에 속한 부원
        List<UserDTO> userList = new ArrayList<>();

        for(ClubCompositionDTO composition : compositionList){
            userList.add(userService.getUser(composition.getUserId()));
        }

        model.addAttribute("userList", userList);
        model.addAttribute("compositionList", compositionList);
        model.addAttribute("club", clubService.selectOneClub(id));
        return "/club/clubMemberManagement";
    }
    
    //동아리 부원 삭제 버튼 클릭시
    @GetMapping("/deleteMember")
    @Transactional  //modifying
    public String deleteClubMember(@RequestParam Long clubId, @RequestParam Long userId){
        clubService.changeClubPeopleNum(clubId, -1);   //동아리 부원수 1 감소
        clubCompositionService.deleteClubMember(userId, clubId);    //부원 삭제
        return "redirect:/club/clubMemberManagement/"+clubId;
    }

    //동아리 부원 직책 변경
    @PostMapping("/changeRole")
    @ResponseBody
    @Transactional
    public HashMap<String, String> changeRole(@RequestBody HashMap<String, String>map, HttpSession session){
        HashMap<String, String> response = new HashMap<>();
        Long clubId = Long.parseLong(map.get("clubId"));    //동아리 id
        Long newManagerId = Long.parseLong(map.get("userId"));    //새로운 부장 id

        //부장 변경. 현재 부장인 사람->일반 부원으로 변경
        if(map.get("role").equals("부장")){
            UserDTO oldManager = (UserDTO) session.getAttribute("logIn");  //로그인한 유저. 원래 부장이었음.
            clubCompositionService.changeOneRole(clubId, oldManager.getId(), "부원"); //기존의 부장 role을 부원으로 변경
            String newManagerEmail = userService.getUser(newManagerId).getUsername();     //새 부장 이메일
            clubService.changeManagerEmail(clubId, newManagerEmail);
            response.put("location", "/club/clubMain/"+clubId); //해당 동아리 메인 화면으로 돌아가기
        }

        clubCompositionService.changeOneRole(clubId, newManagerId, map.get("role"));    //직책 변경

        response.put("status", "success");
        return response;
    }


    //동아리 가입 요청 리스트 보기
    @GetMapping("/showApplicationList/{clubId}")
    public String showApplicationList(@PathVariable Long clubId, Model model){
        List<ApplicationDTO> applicationList = applicationService.showApplicationList(clubId, 0);   //미처리된 지원서 리스트
        List<UserDTO> userList = new ArrayList<UserDTO>();
        for(ApplicationDTO applicationDTO : applicationList){
            userList.add(userService.getUser(applicationDTO.getUserId()));
        }
        model.addAttribute("applicationList", applicationList);
        model.addAttribute("club", clubService.selectOneClub(clubId));
        model.addAttribute("userList", userList);
        return "/club/showApplication";

    }

    //동아리 가입 요청 처리
    //result==pass이면 합격, fail이면 불합격
    @PostMapping("/applicationProcess")
    @Transactional
    public String applicationProcess(EmailDTO emailDTO, @RequestParam(value = "applicationId")Long applicationId, @RequestParam(value = "result")String result, @RequestParam(value = "clubId")Long clubId, @RequestParam(value = "userId")Long userId){
        applicationService.changeIsProcess(applicationId);  //처리된 지원서로 변경. isProcess=1

        if(result.equals("pass")){  //합격
            ClubCompositionDTO clubCompositionDTO = new ClubCompositionDTO(userId, clubId, "부원");
            clubService.changeClubPeopleNum(clubId, 1);
            clubCompositionService.createClubComposition(clubCompositionDTO);   //db에 부원으로 저장


        }
            emailService.sendEmail(emailDTO);   //이메일 전송




        return "redirect:/club/showApplicationList/"+clubId;
    }

    //동아리 삭제
    @PostMapping("/deleteClub")
    @Transactional
    @ResponseBody
    public HashMap<String, String> deleteClub(@RequestBody HashMap<String, String>map){

        Long deleteClubId = Long.parseLong(map.get("clubId"));  //삭제될 동아리 id
        System.out.println("club id = "+deleteClubId);
        clubService.deleteClub(deleteClubId);    //동아리 삭제. isRegular=-2로 변경

        HashMap<String, String> response = new HashMap<>();

        response.put("result", "success");
        return response;
    }


}

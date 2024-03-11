package com.sku.clubproject.controller;

import com.sku.clubproject.model.BoardDTO;
import com.sku.clubproject.model.ClubDTO;
import com.sku.clubproject.model.UserDTO;
import com.sku.clubproject.model.entity.Club;
import com.sku.clubproject.service.BoardService;
import com.sku.clubproject.service.ClubService;
import com.sku.clubproject.service.UserService;
import org.eclipse.tags.shaded.org.apache.xpath.operations.Mod;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;

import java.time.LocalDateTime;
import java.time.ZoneId;
import java.time.format.DateTimeFormatter;
import java.time.temporal.ChronoField;
import java.util.ArrayList;
import java.util.List;

@Controller
@RequestMapping("/admin")
public class AdminController {
    @Autowired
    ClubService clubService;

    @Autowired
    UserService userService;

    @Autowired
    BoardService boardService;


    //관라지 페이지 메인 화면
    @GetMapping("/adminMain")
    public String showAdminMain(Model model){
        List<ClubDTO> clubList = clubService.selectClubByIsRegular(1);   //정규 동아리

        model.addAttribute("clubList", clubList);
        return "/admin/adminPage";
    }

    //관리자의 동아리 관리 페이지. 동아리 리스트 반환. 1=정규동아리, 0=개설 신청 동아리, -1=개설 거절 동아리, -2=삭제된 동아리
    @GetMapping("/clubManagement/{type}")
    public String showClubManagementByAdmin(@PathVariable String type, Model model){
        int isRegular = Integer.parseInt(type);
        List<ClubDTO> clubList = clubService.selectClubByIsRegular(isRegular);   //정규 동아리

        model.addAttribute("clubList", clubList);
        if(isRegular == 1){
            model.addAttribute("function", "정규");
        }
        else if(isRegular == 0){
            model.addAttribute("function", "개설 신청");
        }
        else if(isRegular == -1){
            model.addAttribute("function", "개설 거절");
        }
        else if(isRegular == -2){
            model.addAttribute("function", "폐부");
        }

        return "/admin/adminPage";
    }

    //유저관리
    @GetMapping("/userManagement")
    public String showUserManagementByAdmin(Model model){
        List<UserDTO> userList = userService.getAllUser();  //모든 유저
        model.addAttribute("userList", userList);
        model.addAttribute("function", "유저 관리");

        return "/admin/adminPage";
    }

    //게시물 관리
    @GetMapping("/boardManagement/{isJoin}")
    public String showBoardManagementByAdmin(@PathVariable int isJoin, Model model){
        List<BoardDTO> boardList = boardService.selectAllBoardByJoin(isJoin);   //게시물 리스트
        model.addAttribute("boardList", boardList);

        List<String> writerNameList = new ArrayList<>();  //게시물 작성자 이름 리스트
        for(BoardDTO board : boardList){
            writerNameList.add(userService.getUser(board.getWriterId()).getNickname());
        }
        model.addAttribute("writerNameList", writerNameList);

        if(isJoin==1){  //현재 모집글인지 활동내역인지
            model.addAttribute("function", "모집글 관리");
        }
        else if(isJoin==0){
            model.addAttribute("function", "활동내역 관리");
        }
        return "/admin/adminPage";

    }

    //통계- 동아리 통계, 유저 통계, 게시물 통계
    @GetMapping("/showStatistics")
    public String showStatistics(Model model){
        model.addAttribute("function", "통계");
        //동아리 통계
        List<Integer> clubNumList = new ArrayList<>();  //각 타입의 동아리 개수
        int regularClubNum = clubService.selectClubByIsRegular(1).size();
        int preClubNum = clubService.selectClubByIsRegular(0).size();
        int refuseClubNum = clubService.selectClubByIsRegular(-1).size();
        int deleteClubNum = clubService.selectClubByIsRegular(-2).size();

        clubNumList.add(regularClubNum);
        clubNumList.add(preClubNum);
        clubNumList.add(refuseClubNum);
        clubNumList.add(deleteClubNum);
        model.addAttribute("clubNumList", clubNumList);

        //유저 통계
        List<Integer> userNumList = new ArrayList<>();
        int generalUserNum = userService.getUserByIsCommittee(0).size();
        int committeeUserNum = userService.getUserByIsCommittee(1).size();
        userNumList.add(generalUserNum);
        userNumList.add(committeeUserNum);
        model.addAttribute("userNumList", userNumList);

        //게시글 통계
        List<Integer> boardNumList = new ArrayList<>();
        int activityBoardNum = boardService.selectAllBoardByJoin(0).size();
        int joinBoardNum = boardService.selectAllBoardByJoin(1).size();
        boardNumList.add(activityBoardNum);
        boardNumList.add(joinBoardNum);
        model.addAttribute("boardNumList", boardNumList);

        //회원가입 수 통계
        ArrayList<Long> registerNum = new ArrayList<>(); //회원 가입 자 수(매주 월~일)

        LocalDateTime currentTime = LocalDateTime.now(ZoneId.of("Asia/Seoul")); //오늘
        LocalDateTime todayMidnight = currentTime.truncatedTo(java.time.temporal.ChronoUnit.DAYS);   //오늘의 정각

        int toMonday = todayMidnight.get(ChronoField.DAY_OF_WEEK) -1; //월요일 찾이나는 날짜 수
        LocalDateTime monday = todayMidnight.minusDays(toMonday);     //이번주의 월요일
        System.out.println("월요일 정각 : " + monday);


        String start, end;
        for(int i=0; i<7; i++){
            System.out.println("start : "+monday.plusDays(i)+"end : "+monday.plusDays(i+1));
            start = monday.plusDays(i).format(DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss"));
            end = monday.plusDays(i+1).format(DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss"));
            Long num = userService.getRegisterUserNum(start, end);
            System.out.println(num+"\n");
            registerNum.add(num);
        }

        model.addAttribute("registerNum", registerNum);
        System.out.println(registerNum);


        return "/admin/adminPage";
    }
}

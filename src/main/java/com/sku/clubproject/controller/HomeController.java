package com.sku.clubproject.controller;

import com.sku.clubproject.model.BoardDTO;
import com.sku.clubproject.model.ClubDTO;
import com.sku.clubproject.model.UserDTO;
import com.sku.clubproject.service.*;
import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

import java.util.ArrayList;
import java.util.List;

@Controller
public class HomeController {

    @Autowired
    private BoardService boardService;

    @Autowired
    private ClubService clubService;

    @Autowired
    private UserService userService;
    
    @Autowired
    private ClubCompositionService clubCompositionService;

    @Autowired
    private TelegramService telegramService;

    private static final Logger logger = LogManager.getLogger(HomeController.class);

    //home 화면
    @GetMapping("/home")
    public String showHome(Model model, HttpSession session){
        UserDTO loginUser = (UserDTO)session.getAttribute("logIn"); //로그인 유저
//
//        telegramService.sendTelegram("this is test telegram msg"); 계속 메시지 가서 일시적 주석처리
        logger.info("testing");

        List<BoardDTO> boardList = boardService.selectAllBoardByJoin(1);  //isJoin=1 모집글
        model.addAttribute("boardList", boardList); //모집글 모두 가져오기

        List<String> clubNameList = new ArrayList<>();  //각 모집글의 동아리 이름
        List<String> writerNameList = new ArrayList<>();    //모집글 작성자 이름 리스트
        for(BoardDTO board : boardList){
            clubNameList.add(clubService.getClubName(board.getClubId()));
            writerNameList.add(userService.getUser(board.getWriterId()).getNickname());
        }
        model.addAttribute("clubNameList", clubNameList);
        model.addAttribute("writerNameList", writerNameList);


        List<ClubDTO> orderByPeopleNumClubList = clubService.getMostJoinClub();
        List<ClubDTO> topClubList = new ArrayList<>(orderByPeopleNumClubList.subList(0, 5));    //가장 동아리 부원수 많은 5팀
        model.addAttribute("topClubList", topClubList);


        return "home/home";
    }
}

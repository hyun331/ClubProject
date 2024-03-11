package com.sku.clubproject.controller;

import com.sku.clubproject.model.BoardDTO;
import com.sku.clubproject.model.UserDTO;
import com.sku.clubproject.repository.BoardRepository;
import com.sku.clubproject.service.BoardService;
import com.sku.clubproject.service.ClubService;
import com.sku.clubproject.service.S3UploadService;
import com.sku.clubproject.service.TelegramService;
import jakarta.servlet.http.HttpSession;
import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.HashMap;
import java.util.UUID;

@Controller
@RequestMapping("/board")
public class BoardController {

    @Autowired
    private BoardService boardService;

    @Autowired
    private ClubService clubService;

    @Autowired
    private S3UploadService s3UploadService;

    @Autowired
    private TelegramService telegramService;

    private static final Logger logger = LogManager.getLogger(BoardController.class);



    //게시글 하나를 보여줌
    @GetMapping("/showOneBoard/{id}")
    public String showOneBoard(@PathVariable Long id, Model model){  //id=board의 id
        BoardDTO board = boardService.selectOneBoard(id);   //게시글
        model.addAttribute("board", board);

        model.addAttribute("clubName", clubService.getClubName(board.getClubId())); //모집글의 동아리 이름

        model.addAttribute("boardImg", s3UploadService.getUrl(board.getBoardImg()));


        return "board/showOneBoard";
    }

    //게시물 작성 페이지
    @GetMapping("/createBoard/{id}")
    public String createBoard(@PathVariable Long id,Model model){   //동아리 아이디
        model.addAttribute("clubId", id);
        String clubName = clubService.getClubName(id);
        model.addAttribute("clubName", clubName);
        return "board/createBoard";
    }

    //게시물 작성 처리
    @PostMapping("/createBoard")
    public String createBoard(HttpSession session, BoardDTO boardDTO, @RequestParam(value = "clubId")Long clubId, @RequestParam(value = "uploadFile")MultipartFile uploadFile){
        UserDTO loginUser = (UserDTO)session.getAttribute("logIn"); //로그인한 유저

        boardDTO.setWriterId(loginUser.getId());    //작성자 = 로그인한 유저
        boardDTO.setClubId(clubId);                 //해당 동아리 페이지에서 만든 게시물은 그 동아리에 해당됨

        //aws s3에 이미지 파일 업로드
        String originalFileName = uploadFile.getOriginalFilename();
        String newFileName = "images/" + UUID.randomUUID().toString()+"_"+originalFileName;
        boardDTO.setBoardImg(newFileName);
        System.out.println(newFileName+"\n\n\n\n");

        try{    //s3에 파일 업로드
            s3UploadService.saveFile(uploadFile, newFileName);
        }catch (IOException e){
            e.printStackTrace();
            logger.error("s3 file upload error");
            telegramService.sendTelegram("s3 file upload error");

        }
        boardService.createBoard(boardDTO);

        return "redirect:/club/clubMain/"+clubId; //동아리 페이지로 이동

    }

    //게시물 삭제
    @PostMapping("/deleteBoard")
    @Transactional
    @ResponseBody
    public HashMap<String, String> deleteBoard(@RequestBody HashMap<String, Long>map){
        boardService.deleteBoard(map.get("boardId"));

        HashMap<String, String> response = new HashMap<>();
        response.put("result", "success");
        return response;
    }
}

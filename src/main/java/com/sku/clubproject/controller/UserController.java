package com.sku.clubproject.controller;

import com.sku.clubproject.model.ClubDTO;
import com.sku.clubproject.model.EmailDTO;
import com.sku.clubproject.model.UserDTO;
import com.sku.clubproject.model.entity.User;
import com.sku.clubproject.service.ClubService;
import com.sku.clubproject.service.EmailService;
import com.sku.clubproject.service.UserService;
import jakarta.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Controller
public class UserController {

    @Autowired
    UserService userService;

    @Autowired
    EmailService emailService;

    @Autowired
    ClubService clubService;

    //로그인 화면
    @GetMapping("")
    public String showLogin(){
        System.out.println("test");
        return "/user/login";
    }

    //로그인 처리
    @PostMapping("/user/login")
    public String login(HttpSession session, UserDTO userDTO, Model model){
        UserDTO loginUser = userService.logInService(userDTO);
        if(loginUser != null){
            session.setAttribute("logIn", loginUser);   //login 계정 session에 저장
            session.setMaxInactiveInterval(1800);   //세션 유지시간 30분. 1800초

            if(loginUser.getIsAdmin()==0){  //일반 학생 또는 위원회 로그인
                session.setAttribute("stuOrCom", "학생");    //로그인 시 위원회도 일반 학생으로 접근. student or committee

                List<ClubDTO> joinClubList = clubService.getClubListByUserId(loginUser.getId(), 1); //로그인한 유저가 가입한 동아리.
                session.setAttribute("joinClubList", joinClubList);
                return "redirect:/home";
            }
            else{
                return "redirect:/admin/adminMain";
            }

        }else{
            model.addAttribute("errorMsg", "loginFail");
            return "redirect:/";
        }
    }

    //로그아웃
    @GetMapping("/user/logout")
    public String logout(HttpSession session) {
        // 세션 무효화
        session.invalidate();

        // 로그인 화면
        return "/user/login";
    }

    //일반 회원가입 화면
    @GetMapping("/user/registerUser")
    public String showRegisterUser(){
        return "/user/registerUser";
    }

    //회원가입 이메일 중복 처리
    @ResponseBody
    @PostMapping("/user/checkUsername")
    public Map<String, Boolean> checkUsername(@RequestParam String username) {
        Map<String, Boolean> response = new HashMap<>();
        boolean isUnique = userService.isUsernameUnique(username);
        response.put("unique", isUnique);
        return response;
    }

    //일반 회원 가입
    @PostMapping("/user/registerUser")
    public String signUpService(UserDTO userDTO, Model model) {
        userDTO.setIsAdmin(0);
        userDTO.setIsCommittee(0);
        UserDTO result = userService.signUpService(userDTO);

        return "redirect:/";
    }

    //인증 번호 발송 메소드
    @ResponseBody
    @PostMapping("/user/sendCodeEmail")
    public Map<String, String> sendCodeEmail(@RequestBody HashMap<String, String> map) {
        EmailDTO emailDTO = new EmailDTO();
        emailDTO.setReceiverEmail(map.get("mail"));
        emailDTO.setEmailTitle("동아리 관리 시스템 회원가입 인증번호");
        int verificationCode = createNumber();
        emailDTO.setEmailContent("인증번호는 " + verificationCode + "입니다.");
        emailService.sendEmail(emailDTO);

        Map<String, String> response = new HashMap<>();
        response.put("verificationCode", String.valueOf(verificationCode));
        return response;
    }

    //인증 번호 생성
    public int createNumber() {
        return (int) (Math.random() * (90000)) + 100000;
    }




    //위원회 회원가입 화면
    @GetMapping("/user/registerCommittee")
    public String showRegisterCommittee(){
        return "/user/registerCommittee";
    }

    // 위원회 회원가입 처리
    @PostMapping("/user/registerCommittee")
    public String signUpServiceC(UserDTO userDTO, Model model) {
        // 아이디 중복 체크
        userDTO.setIsAdmin(0);
        userDTO.setIsCommittee(1);
        UserDTO result = userService.signUpService(userDTO);

        return "redirect:/";
    }



    //일반 학생 <-> 위원회 변경 처리
    @ResponseBody
    @PostMapping("/user/setStuOrCom")
    public HashMap<String, String> changeRole(HttpSession session, @RequestBody HashMap<String, String> map)throws Exception {
        // 받아온 role에 대한 처리 수행
        session.setAttribute("stuOrCom", map.get("role"));

        HashMap<String, String> response = new HashMap<>();
        response.put("status", "success");
        return response;
    }

    //유저의 isCommittee 변경
    @ResponseBody
    @PostMapping("/user/changeIsCommittee")
    @Transactional
    public HashMap<String, String> changeIsCommittee(@RequestBody HashMap<String, String> map){
        userService.changeIsCommittee(Long.parseLong(map.get("userId")), Integer.parseInt(map.get("isCommittee"))); //userId인 유저의 직책 변경. 0 또는 1
        System.out.println(userService.getUser(Long.parseLong(map.get("userId"))).getIsCommittee());
        HashMap<String, String> response = new HashMap<>();
        response.put("status", "success");
        return response;
    }

    @ResponseBody
    @PostMapping("/user/deleteUser")
    @Transactional
    public HashMap<String, String> deleteUser(@RequestBody HashMap<String, String> map){
        Long userId = Long.parseLong(map.get("userId"));
        userService.deleteUser(userId);

        HashMap<String, String> response = new HashMap<>();
        response.put("status", "success");
        return response;

    }
}

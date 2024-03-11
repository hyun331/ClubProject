package com.sku.clubproject.service;

import com.sku.clubproject.model.UserDTO;
import com.sku.clubproject.model.entity.User;
import com.sku.clubproject.repository.UserRepository;
import jakarta.servlet.http.HttpSession;
import jakarta.validation.Valid;
import org.modelmapper.ModelMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

//import javax.validation.Valid;
import java.time.LocalDateTime;
import java.util.List;
import java.util.Optional;
@Service
public class UserService {

    @Autowired
    UserRepository userRepository;

    @Autowired
    ModelMapper modelMapper;


    //로그인 처리 함수
    public UserDTO logInService(UserDTO userDTO){
        Optional<User> optionUser = userRepository.findByUsernameAndPassword(userDTO.getUsername(), userDTO.getPassword());

        if(optionUser.isPresent()){ //해당 계정 존재하고 로그인 성공
            User user = optionUser.get();
            return modelMapper.map(user, UserDTO.class);
        }

        //로그인 실패
        return null;
    }

    //email 주면 해당 유저 정보 리턴
    public UserDTO selectOneUser(String email){
        Optional<User> optionUser = userRepository.findByUsername(email);
        if(optionUser.isPresent()){
            return modelMapper.map(optionUser.get(), UserDTO.class);
        }
        return null;
    }

    //userID 주면 해당 userDTO 리턴
    public UserDTO getUser(Long userId){
        Optional<User> optionUser = userRepository.findById(userId);
        if(optionUser.isPresent()){
            return modelMapper.map(optionUser.get(), UserDTO.class);
        }
        return null;
    }

    // 회원가입 처리 함수
    @Transactional
    public UserDTO signUpService(@Valid UserDTO userDTO) {
        if (!isUsernameUnique(userDTO.getUsername())) {
            // 중복된 아이디인 경우 예외 처리 또는 특별한 로직 추가
            throw new RuntimeException("중복된 아이디입니다.");
        }
        System.out.println(userDTO);
        User newUser = modelMapper.map(userDTO, User.class); // DTO를 entity로 매핑
        User saveUser = userRepository.save(newUser); // DB에 저장
        return modelMapper.map(saveUser, UserDTO.class);
    }

    // 중복처리 함수 만들기
    public boolean isUsernameUnique(String username) {
        Optional<User> existingUser = userRepository.findByUsername(username);
        return !existingUser.isPresent(); // Optional이 비어있으면 중복이 아님
    }

    //위원회 회원가입 처리 함수
    public UserDTO signUpServiceC(UserDTO userDTO) {
        if (!isUsernameUnique(userDTO.getUsername())) {
            // 중복된 아이디인 경우 예외 처리 또는 특별한 로직 추가
            throw new RuntimeException("중복된 아이디입니다.");
        }
        User newUser = modelMapper.map(userDTO, User.class); // DTO를 entity로 매핑
        User saveUser = userRepository.save(newUser); // DB에 저장
        return modelMapper.map(saveUser, UserDTO.class);
    }

    //모든 user 리턴
    public List<UserDTO> getAllUser(){
        List<User> userList = userRepository.findAll();
        return userList.stream()
                .map(data -> modelMapper.map(data, UserDTO.class))
                .toList();
    }

    //일반 유저(0) 또는 위원회(1) 리스트 리턴
    public List<UserDTO> getUserByIsCommittee(int isCommittee){
        List<User> userList = userRepository.findAllByIsCommittee(isCommittee);
        return userList.stream()
                .map(data -> modelMapper.map(data, UserDTO.class))
                .toList();
    }


    //유저의 isCommittee (위원회=1, 학생=0) 변경
    public void changeIsCommittee(Long userId, int isCommittee){
        userRepository.changeIsCommittee(userId, isCommittee);

    }

    //유저 삭제
    public void deleteUser(Long userId){
        userRepository.deleteById(userId);
    }


    public Long getRegisterUserNum(String start, String end){
        return userRepository.countByEntryDateBetween(start, end);

    }
}

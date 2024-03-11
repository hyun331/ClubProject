package com.sku.clubproject.service;

import com.sku.clubproject.model.ClubCompositionDTO;
import com.sku.clubproject.model.UserDTO;
import com.sku.clubproject.model.entity.ClubComposition;
import com.sku.clubproject.repository.ClubCompositionRepository;
import org.modelmapper.ModelMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class ClubCompositionService {
    @Autowired
    ClubCompositionRepository clubCompositionRepository;

    @Autowired
    UserService userService;

    @Autowired
    ModelMapper modelMapper;

    //동아리 개설 신청시 예비 부원 insert
    public void createPreComposition(List<String> emails, Long clubId){
        ClubComposition clubComposition=null;
        for (String email : emails) {
            UserDTO userDTO = userService.selectOneUser(email);
            clubComposition = new ClubComposition(userDTO.getId(), clubId, "0");    //0을 넣어주는건 예비 동아리의 신청 인원임을 나타냄
            clubCompositionRepository.save(clubComposition);
        }
    }

    //동아리 지원 -> 합격
    public void createClubComposition(ClubCompositionDTO clubCompositionDTO){
        ClubComposition clubComposition = modelMapper.map(clubCompositionDTO, ClubComposition.class);
        System.out.println("\n\n\n"+clubComposition.getUserId());
        clubCompositionRepository.save(clubComposition);
    }

    //동아리 id에 해당하는 학생들 return(부장, 부원, 또는 개설 신청한 동아리 예비 부원) - club composition table에서
    public List<ClubCompositionDTO> selectUserEachClub(Long clubId){
        List<ClubComposition> list = clubCompositionRepository.findAllByClubId(clubId);

        List<ClubCompositionDTO> resultList = list.stream()
                .map(data -> modelMapper.map(data, ClubCompositionDTO.class))
                .toList();

        return resultList;
    }



    //동아리 부원 1명 role 변경
    public void changeOneRole(Long clubId, Long userId, String role){
        clubCompositionRepository.changeRole(clubId, userId, role); //clubId 동아리의 userId 부원의 role 변경
    }


    //한 유저가 가입한 동아리의 id 반환
    public List<Long> selectClubIdByUserId(Long userId, int type){
        if(type==-2){
            System.out.println("삭제된 동아리");
        }
        else if(type==-1){
            System.out.println("동아리 개설 거부");
        }
        else if(type==0){
            System.out.println("동알 개설 신청 진행중");
        }
        else{   //가입한 정식 동아리 id 리턴
            List<Long> clubIdList = clubCompositionRepository.findAllRegularClubIdByUserId(userId);
            return clubIdList;
        }
        return null;
    }


    //동아리 부원 모두 role 변경 - 동아리 개설시 사용
    public void changeAllRole(Long clubId, String role){
        List<ClubCompositionDTO> list = selectUserEachClub(clubId); //모든 구성원 list
        for(ClubCompositionDTO each : list){
            changeOneRole(each.getClubId(), each.getUserId(), role);
        }
    }

    //하나의 동아리에서 한 사람의 역할 리턴
    public String getRole(Long userId, Long clubId){
        return clubCompositionRepository.getRole(userId, clubId);
    }

    //동아리 부원 삭제
    public void deleteClubMember(Long userId, Long clubId){
        ClubComposition composition = clubCompositionRepository.findByUserIdAndClubId(userId, clubId);
        clubCompositionRepository.delete(composition);
    }
}

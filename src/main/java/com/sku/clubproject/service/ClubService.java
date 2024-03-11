package com.sku.clubproject.service;

import com.sku.clubproject.model.ClubDTO;
import com.sku.clubproject.model.UserDTO;
import com.sku.clubproject.model.entity.Club;
import com.sku.clubproject.repository.ClubCompositionRepository;
import com.sku.clubproject.repository.ClubRepository;
import com.sku.clubproject.repository.UserRepository;
import org.modelmapper.ModelMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.List;
import java.util.Optional;
import java.util.stream.Collectors;

@Service
public class ClubService {

    @Autowired
    private ClubRepository clubRepository;

    @Autowired
    ModelMapper modelMapper;

//    @Autowired
//    private UserRepository userRepository;

//    @Autowired
//    private ClubCompositionRepository clubCompositionRepository;

    @Autowired
    private ClubCompositionService clubCompositionService;

    //동아리 개설
    public Long createPreClub(ClubDTO clubDTO){
        Club club = modelMapper.map(clubDTO, Club.class);
        return clubRepository.save(club).getId();
    }

    //로그인한 유저의 동아리 리스트 리턴. 동아리 타입(isRegular마다)
    public List<ClubDTO> getClubListByUserId(Long userId, int isRegular){
        List<ClubDTO> clubList = new ArrayList<>();
        List<Long> clubIdList = clubCompositionService.selectClubIdByUserId(userId, isRegular); //유저와 관련된 동아리 id 리스트
        ClubDTO clubDTO = null;
        for(Long clubId : clubIdList){
            clubDTO = selectOneClub(clubId);
            if(clubDTO.getIsRegular() == isRegular){
                clubList.add(selectOneClub(clubId));    //동아리 타입(isRegular)에 맞으면 리스트에 추가
            }
        }
       return clubList;
    }

    //정규(1), 예비(0), 개설 거부(-1), 삭제된 정규(-2) 동아리 중 하나 리스트 반환
    public List<ClubDTO> selectClubByIsRegular(int type){
        List<Club> list= clubRepository.findAllByIsRegular(type);  //동아리 리스트

        //list 바인딩 코드
        List<ClubDTO> resultList = list.stream()
                        .map(data -> modelMapper.map(data, ClubDTO.class))
                                .toList();
        return resultList;
    }


    //clubId 주면 해당 club return
    public ClubDTO selectOneClub(Long clubId){
        Optional<Club>optionClub = clubRepository.findById(clubId);

        if(optionClub.isPresent()){ //해당 동아리가 존재한다면
            return modelMapper.map(optionClub, ClubDTO.class);
        }
        return null;
    }

    //clubId 주면 club name return
    public String getClubName(Long clubId){
        Optional<Club> optionClub = clubRepository.findById(clubId);

        if(optionClub.isPresent()){
            return optionClub.get().getName();
        }
        return null;
    }

    //개설 신청한 동아리 정식 동아리로 승인
    //isRrgular==1로 변경
    public void changeIsRegular(Long clubId, int isRegular){
        clubRepository.changeIsRegular(clubId, isRegular);
    }


    //동아리 부원 수 조정
    public void changeClubPeopleNum(Long clubId ,int num){
        Optional<Club> club = clubRepository.findById(clubId);
        if(club.isPresent()){
            clubRepository.changePeopleNum(clubId, club.get().getPeopleNum()+num);
        }
    }



    //동아리 삭제. db에는 존재해야함. isRegular=-2 (삭제된 동아리라는 의미)
    public void deleteClub(Long deleteClubId){
        clubRepository.changeIsRegular(deleteClubId, -2);
    }

    //동아리 대표 이메일 변경
    public void changeManagerEmail(Long clubId, String mEmail){
        clubRepository.changeMEmail(clubId, mEmail);
    }


    //부원이 많은 동아리 5개 리턴
    public List<ClubDTO> getMostJoinClub(){
        List<Club> list= clubRepository.findClubListOrderByPeopleNum();

        //list 바인딩 코드
        List<ClubDTO> resultList = list.stream()
                .map(data -> modelMapper.map(data, ClubDTO.class))
                .toList();
        return resultList;
    }


}

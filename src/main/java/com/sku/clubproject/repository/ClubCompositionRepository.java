package com.sku.clubproject.repository;

import com.sku.clubproject.model.ClubCompositionDTO;
import com.sku.clubproject.model.entity.CCID;
import com.sku.clubproject.model.entity.ClubComposition;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;

import java.util.List;

public interface ClubCompositionRepository extends JpaRepository<ClubComposition, CCID> {

    //동아리 부원 역할 변경
    @Modifying(clearAutomatically = true)
    @Query("UPDATE ClubComposition cc SET cc.role = :role WHERE cc.clubId = :clubId AND cc.userId = :userId")
    void changeRole(Long clubId, Long userId, String role);


    //clubcompositon에서 clubId에 해당하는 사람 리턴
    List<ClubComposition> findAllByClubId(Long clubId);


    //userId가 가입한 동아리 리스트
    @Query("SELECT cc.clubId from ClubComposition cc Where cc.userId= :userId AND cc.role !='0' AND cc.role != '-1'")
    List<Long> findAllRegularClubIdByUserId(Long userId);


    //하나의 동아리에서 한 사람의 역할 리턴
    @Query("SELECT cc.role from ClubComposition cc where  cc.userId= :userId AND cc.clubId= :clubId")
    String getRole(Long userId, Long clubId);


    //동아리 멤버 삭제
    ClubComposition findByUserIdAndClubId(Long userId, Long clubId);
}

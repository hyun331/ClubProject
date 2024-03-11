package com.sku.clubproject.repository;

import com.sku.clubproject.model.entity.Club;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;

import java.util.List;

public interface ClubRepository extends JpaRepository<Club, Long> {

    public List<Club> findAllByIsRegular(int isRegular);

    //Modifying - data update, delete 시 영속성 컨텍스트를 초기화. db와 캐시 일치시키기 위해
    @Modifying(clearAutomatically = true)
    @Query("UPDATE Club c set c.isRegular = :isRegular WHERE c.id = :clubId")
    void changeIsRegular(Long clubId, int isRegular);


    //동아리 부원 수 조절
    @Modifying(clearAutomatically = true)
    @Query("UPDATE Club c set c.peopleNum = :peopleNum where c.id = :clubId")
    void changePeopleNum(Long clubId, int peopleNum);

    //동아리 부장 이메일 변경
    @Modifying(clearAutomatically = true)
    @Query("UPDATE Club c set c.mEmail =:mEmail where c.id =:clubId")
    void changeMEmail(Long clubId, String mEmail);


    @Query("SELECT c FROM Club c ORDER BY c.peopleNum DESC")
    List<Club> findClubListOrderByPeopleNum();


}

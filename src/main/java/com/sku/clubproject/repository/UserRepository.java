package com.sku.clubproject.repository;


import com.sku.clubproject.model.entity.User;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;

import javax.swing.text.html.Option;
import java.time.LocalDateTime;
import java.util.List;
import java.util.Optional;

public interface UserRepository extends JpaRepository<User, Long> {
    Optional<User> findByUsernameAndPassword(String username, String password);

    Optional<User> findByUsername(String username);


    @Modifying(clearAutomatically = true)
    @Query("UPDATE User u set u.isCommittee = :isCommittee where u.id = :userId")
    void changeIsCommittee(Long userId, int isCommittee);

    List<User> findAllByIsCommittee(int isCommittee);

    //날짜 간격 사이의 가입자 수
    @Query("select count(*) from User u where u.entryDate between :start and :end")
    Long countByEntryDateBetween(String start, String end);
}




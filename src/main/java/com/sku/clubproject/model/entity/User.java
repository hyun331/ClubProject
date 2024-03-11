package com.sku.clubproject.model.entity;

import jakarta.persistence.*;
import lombok.*;
import org.hibernate.annotations.CreationTimestamp;
import org.springframework.stereotype.Component;

import java.time.LocalDateTime;
import java.time.ZoneId;
import java.time.format.DateTimeFormatter;


@Getter
@Setter
@Entity
@Component
@NoArgsConstructor
@AllArgsConstructor
public class User { //사용자
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(columnDefinition = "integer", nullable = false)
    private Long id;    //사용자 id

    @Column(columnDefinition="text", nullable = false, unique = true)
    private String username;    //사용자 email

    @Column(columnDefinition="text", nullable = false)
    private String password;    //비밀번호

    @Column(columnDefinition="text")
    private String nickname;    //닉네임

    @Column(columnDefinition="text")
    private String majorName;   //전공

    @Column(columnDefinition="text")
    private String phone;   //핸드폰번호

    @Column(columnDefinition="integer")
    private int isAdmin;    //관리자인지 아닌지. 관리자면 1, 아니면 0

    @Column(columnDefinition="integer")
    private int isCommittee;    //동아리 위원회인지 아닌지. 위원회면 1, 아니면 0

    @Column(columnDefinition="text")
    private String entryDate;   //가입 날짜

    @Column(columnDefinition="text")
    private String modifyDate;  //수정날짜

    @PrePersist
    public  void prePersist(){  //entryDate, modifyDate 현재 시각으로 설정
        LocalDateTime currentDateTime = LocalDateTime.now(ZoneId.of("Asia/Seoul"));
        entryDate = currentDateTime.format(DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss"));
        modifyDate = currentDateTime.format(DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss"));
    }
}

package com.sku.clubproject.model.entity;

import jakarta.persistence.*;
import lombok.*;
import org.hibernate.annotations.CreationTimestamp;
import org.hibernate.annotations.UpdateTimestamp;
import org.springframework.data.annotation.CreatedDate;
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
public class Club { //동아리 테이블
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(columnDefinition = "integer", nullable = false)
    private Long id;    //동아리 id

    @Column(columnDefinition="text", nullable = false)
    private String name;    //동아리 이름

    @Column(columnDefinition="text")
    private String explain; //동아리 설명

    @Column(columnDefinition="text")
    private String genre;   //동아리 장르

    @Column(columnDefinition="integer")
    private int peopleNum;  //동아리 부원 수

    @Column(columnDefinition = "integer")
    private int isRegular;  //정식 동아리인지(1), 개설 신청한 예비 동아리인지(0)

    @Column(columnDefinition = "TEXT", updatable = false)
    private String entryDate;   //등록날짜

    @Column(columnDefinition="text")
    private String deleteDate;  //살제 날짜

    @Column(columnDefinition="text")
    private String mEmail;  //동아리 부장 이메일. manager email


    @PrePersist
    public  void prePersist(){
        LocalDateTime currentDateTime = LocalDateTime.now(ZoneId.of("Asia/Seoul"));
        entryDate = currentDateTime.format(DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss"));
    }




}

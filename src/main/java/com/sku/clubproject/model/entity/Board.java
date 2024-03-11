package com.sku.clubproject.model.entity;

import jakarta.persistence.*;
import lombok.*;
import org.springframework.cglib.core.Local;
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
public class Board {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(columnDefinition = "integer", nullable = false)
    private Long id;

    @Column(columnDefinition="text", nullable = false)
    private String title;

    @Column(columnDefinition="text")
    private String content;

    @Column(columnDefinition="text")
    private String boardImg;

    @Column(columnDefinition = "integer",  nullable = false)    //작성자
    private Long writerId;

    @Column(columnDefinition="integer default -1")  //소모임 게시글 = -1, 나머지는 동아리 id
    private Long clubId;

    @Column(columnDefinition="integer")     //모집글이면 1, 그냥 일반 활동 내역 글이면 0
    private int isJoin;

    @Column(columnDefinition="text")
    private String entryDate;

    @Column(columnDefinition="text")
    private String modifyDate;

    @PrePersist
    public  void prePersist(){
        LocalDateTime currentDateTime = LocalDateTime.now(ZoneId.of("Asia/Seoul"));
        entryDate = currentDateTime.format(DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss"));
        modifyDate = currentDateTime.format(DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss"));
    }

}

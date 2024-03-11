package com.sku.clubproject.model.entity;

import jakarta.persistence.*;
import lombok.*;
import org.springframework.stereotype.Component;

//어떤 학생이 어떤 동아리에 가입했는지. role=직책
//학생 번호와 동아리 번호가 pk인 복합키.
//복합키는 CCID.java에 정의함

@Getter
@Setter
@Entity
@Component
@NoArgsConstructor
@AllArgsConstructor
@IdClass(CCID.class)    //repository의 제너릭에 CCID 입력
public class ClubComposition {
    @Id
    @Column(columnDefinition = "integer", nullable = false)
    private Long userId;

    @Id
    @Column(columnDefinition = "integer", nullable = false)
    private Long clubId;

    @Column(columnDefinition = "text")
    private String role;    //동아리 개설 시 신청한 부원들을 저장하기 위해 role에 "0" 이라는 값으로 설정. 만약 개설 허가되면  0->정식 직책으로 변경됨



}

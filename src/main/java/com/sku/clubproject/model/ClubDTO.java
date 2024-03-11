package com.sku.clubproject.model;

import lombok.*;

import java.sql.Timestamp;
import java.time.LocalDateTime;
import java.util.Date;

@Getter
@Setter
@Data
@NoArgsConstructor
@AllArgsConstructor
public class ClubDTO {
    private Long id;
    private String name;
    private String explain;
    private String genre;
    private int peopleNum;
    private int isRegular;  //정식 동아리인지(1), 개설 신청한 예비 동아리인지(0)
    private String entryDate;
    private String deleteDate;
    private String mEmail;  //동아리 부장 이메일. manager email

}

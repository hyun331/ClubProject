package com.sku.clubproject.model;

import lombok.*;

import java.time.LocalDateTime;

@Getter
@Setter
@Data
@NoArgsConstructor
@AllArgsConstructor
public class BoardDTO {
    private Long id;
    private String title;
    private String content;
    private String boardImg;
    private Long writerId;
    private Long clubId;
    private int isJoin;
    private String entryDate;
    private String modifyDate;


}

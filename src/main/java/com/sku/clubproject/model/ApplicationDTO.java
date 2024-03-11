package com.sku.clubproject.model;

import lombok.*;

@Getter
@Setter
@Data
@NoArgsConstructor
@AllArgsConstructor
public class ApplicationDTO {
    private Long id;
    private Long userId;
    private Long clubId;
    private String title;
    private String email;
    private String content;
    private String address;
    private int isProcess;



}

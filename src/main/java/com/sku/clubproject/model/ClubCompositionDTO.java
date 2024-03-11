package com.sku.clubproject.model;

import lombok.*;

@Getter
@Setter
@Data
@NoArgsConstructor
@AllArgsConstructor
public class ClubCompositionDTO {
    private Long userId;
    private Long clubId;
    private String role;
}

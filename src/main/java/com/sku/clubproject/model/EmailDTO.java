package com.sku.clubproject.model;

import lombok.Data;
import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
@Data
public class EmailDTO {
    private String receiverEmail;
    private String emailTitle;
    private String emailContent;

}

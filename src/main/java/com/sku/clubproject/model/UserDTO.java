package com.sku.clubproject.model;

import com.sku.clubproject.model.entity.User;
import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.Pattern;
import lombok.*;

import java.time.LocalDateTime;

@Getter
@Setter
@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class UserDTO {

    private Long id;

    @NotBlank(message = "Email은 필수 입력값입니다.")
    @Pattern(regexp = "^(?:\\w+\\.?)*\\w+@skuniv\\.ac\\.kr$", message = "이메일 형식이 올바르지 않습니다.")
    private String username;

    @NotBlank(message = "비밀번호는 필수 입력값입니다.")
    @Pattern(regexp = "(?=.*[0-9])(?=.*[a-zA-Z])(?=.*\\W)(?=\\S+$).{8,16}", message = "비밀번호는 8~16자 영문 대 소문자, 숫자, 특수문자를 사용하세요.")
    private String password;

    @NotBlank(message = "이름은 필수 입력값입니다.")
    private String nickname;

    private String majorName;
    private String phone;
    private int isAdmin;

    private int isCommittee;

    private String entryDate;
    private String modifyDate;




}

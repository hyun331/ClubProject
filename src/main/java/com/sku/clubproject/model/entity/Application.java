package com.sku.clubproject.model.entity;

import jakarta.persistence.*;
import lombok.*;
import org.springframework.stereotype.Component;

@Getter
@Setter
@Entity
@Component
@NoArgsConstructor
@AllArgsConstructor
public class Application {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(columnDefinition = "integer", nullable = false)
    private Long id;

    @Column(columnDefinition="integer", nullable = false)
    private Long userId;

    @Column(columnDefinition = "integer",  nullable = false)
    private Long clubId;

    @Column(columnDefinition="text")
    private String title;

    @Column(columnDefinition="text")
    private String email;

    @Column(columnDefinition="text")
    private String content;

    @Column(columnDefinition="text")
    private String address;

    @Column(columnDefinition="integer") //현재 이 지원서가 합격, 불합격 처리가 된 지원서인지 여부(0이면 미처리된 지원서, 1 이면 결과가 나온 지원서)
    private int isProcess;


}

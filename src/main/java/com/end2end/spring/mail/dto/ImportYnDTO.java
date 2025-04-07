package com.end2end.spring.mail.dto;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Getter @Setter
@AllArgsConstructor
@NoArgsConstructor
public class ImportYnDTO {
    private int esId;
    private String importantYn;
}

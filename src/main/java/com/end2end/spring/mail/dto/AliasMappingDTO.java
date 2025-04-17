package com.end2end.spring.mail.dto;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Getter @Setter
@NoArgsConstructor
@AllArgsConstructor
public class AliasMappingDTO {
    private String aliasAddress;
    private String aliasName;
    private String recipientList;
}

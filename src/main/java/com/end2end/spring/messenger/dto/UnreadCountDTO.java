package com.end2end.spring.messenger.dto;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import org.springframework.stereotype.Service;

@Getter @Setter
@AllArgsConstructor
@NoArgsConstructor
public class UnreadCountDTO {
    private Integer roomId;
    private Integer count;
}

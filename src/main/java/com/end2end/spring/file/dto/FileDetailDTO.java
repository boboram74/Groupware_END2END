package com.end2end.spring.file.dto;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.time.LocalDate;

@Data
@AllArgsConstructor
@NoArgsConstructor
@Builder
public class FileDetailDTO {
    private int id;
    private int filesId;
    private String originFileName;
    private String systemFileName;
    private String path;
    private long fileSize;
    private LocalDate regDate;
}

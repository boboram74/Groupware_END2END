package com.end2end.spring.works.dto;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.security.Timestamp;
@Data
@AllArgsConstructor
@NoArgsConstructor
public class ProjectWorkReplyDTO {

    private int id;
private int projectWorkId;
private int projectUserId;
private String content;
private Timestamp regDate;

}

package com.end2end.spring.works.dto;

import java.security.Timestamp;

public class ProjectWorkDTO {
    private int id;
    private int projectId;
    private int projectUserId;
    private String title;
    private String state;  // "ONGOING", "FINISH"
    private String priority; // "HIGH", "MIDDLE", "LOW"
    private Timestamp finishDate;
    private Timestamp deadLine;
    private Timestamp regDate;


    public ProjectWorkDTO(){}

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public int getProjectId() {
        return projectId;
    }

    public void setProjectId(int projectId) {
        this.projectId = projectId;
    }

    public int getProjectUserId() {
        return projectUserId;
    }

    public void setProjectUserId(int projectUserId) {
        this.projectUserId = projectUserId;
    }

    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    public String getState() {
        return state;
    }

    public void setState(String state) {
        this.state = state;
    }

    public String getPriority() {
        return priority;
    }

    public void setPriority(String priority) {
        this.priority = priority;
    }

    public Timestamp getFinishDate() {
        return finishDate;
    }

    public void setFinishDate(Timestamp finishDate) {
        this.finishDate = finishDate;
    }

    public Timestamp getDeadLine() {
        return deadLine;
    }

    public void setDeadLine(Timestamp deadLine) {
        this.deadLine = deadLine;
    }

    public Timestamp getRegDate() {
        return regDate;
    }

    public void setRegDate(Timestamp regDate) {
        this.regDate = regDate;
    }

    public ProjectWorkDTO(int id, int projectId, int projectUserId, String title, String state, String priority, Timestamp finishDate, Timestamp deadLine, Timestamp regDate) {
        this.id = id;
        this.projectId = projectId;
        this.projectUserId = projectUserId;
        this.title = title;
        this.state = state;
        this.priority = priority;
        this.finishDate = finishDate;
        this.deadLine = deadLine;
        this.regDate = regDate;
    }
}

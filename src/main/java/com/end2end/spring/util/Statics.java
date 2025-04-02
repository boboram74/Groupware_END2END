package com.end2end.spring.util;

public class Statics {
    // 출퇴근 관리 시간 지정
    public static final String WORK_ON_CHECK_TIME = "0 10 9 * * 1-5";
    public static final String WORK_OFF_CHECK_TIME = "0 10 18 * * 1-5";

    // 파일 입출력 경로
    public static final String FILE_UPLOAD_PATH = "C:/files/";
    public static final String MAPPED_FILE_UPLOAD_PATH = "/files/";
}

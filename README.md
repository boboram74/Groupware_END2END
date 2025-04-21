<!-- logo -->

# GROUPWARE Project

[![readme.md](https://img.shields.io/badge/-readme.md-important?style=flat&logo=google-chrome&logoColor=white)]() [![release](https://img.shields.io/badge/release-v3.5.2-yellow?style=flat&logo=google-chrome&logoColor=white)]()  
[![프로젝트 기간](https://img.shields.io/badge/프로젝트_기간-2025.03.27~2025.04.18-green?style=flat)]()

---

## 📝 소개
END2END 팀이 진행한 [Spring Legacy] + [Spring Boot] 기반의 GROUPWARE Project입니다. 조직 내 커뮤니케이션 및 업무 관리 효율화를 목표로, 전자결재, 메일 관리, 직원 관리, 일정 관리 및 실시간 채팅 기능 등을 구현하여 기업의 업무 효율성과 소통을 강화했습니다. 프로젝트는 다음 내용을 담고 있습니다.

- 프로젝트 소개
- 화면 구성
- 주요 기능
- 사용한 기술 스택
- 프로젝트 아키텍처
- ERD
- 기술적 이슈와 해결 과정
- 프로젝트 팀원

---

## 🎨 화면 구성

| 메인 페이지 | 전자결재 페이지 | 메일함 페이지 | 직원 관리 페이지 | 채팅1| 채팅2 |
| :---: | :---: | :---: | :---: | :---: | :---: |
| ![Main](https://github.com/user-attachments/assets/6cadd527-9803-4c01-9af7-7ab0f95ae3f5) | ![Approval](https://github.com/user-attachments/assets/b9f95421-b178-4c9c-adf4-c56bbbd1a271) | ![Mail](https://github.com/user-attachments/assets/e0d30093-e5cb-48d5-8d27-1c429e7da42c)  | ![Employee](https://github.com/user-attachments/assets/e5847a74-6283-4bcc-b392-e03e847b3746) | ![Chat](https://github.com/user-attachments/assets/dea80300-aab9-42d3-a1bb-f951fda9d3b6) | ![Chat2](https://github.com/user-attachments/assets/300aa550-325d-4dc5-9174-6a922b1af25b) |

| 일정 관리 페이지 | 예약 관리 페이지 | 근태 관리 페이지 | 게시판 페이지 | 주소록 페이지 |
| :---: | :---: | :---: | :---: | :---: |
| ![Schedule](https://github.com/user-attachments/assets/a1fba279-21da-43b0-bad7-4e4ca3774a6a) | ![Notice](https://github.com/user-attachments/assets/d4db2538-46ad-4fb9-b18d-4b1554272ea1) | ![Attendance](https://github.com/user-attachments/assets/64f12a56-9485-4b0a-b725-dded7b704aae) | ![Board](https://github.com/user-attachments/assets/727854b3-07c8-4912-9756-0296e61d74c7) | ![Address](https://github.com/user-attachments/assets/d033a9b3-baa4-407d-91fd-e87bcbeca73d) |

| 관리자 페이지1 | 관리자 페이지2 | 관리자 페이지3 |  관리자 페이지4 |
| :---: | :---: | :---: | :---: |
| ![Contacts](https://github.com/user-attachments/assets/c34b8a80-5b86-4ed5-b055-0cd65f6e8a7d) | ![Contacts](https://github.com/user-attachments/assets/997aea36-953d-4995-ba36-c0daf1b042e0) | ![Admin](https://github.com/user-attachments/assets/bedb3d2f-bc71-4d5d-b3d3-4d44d385a28f) | ![Admin](https://github.com/user-attachments/assets/bd774264-6eec-4538-b94e-46699973eca0) |

---

## 📌 주요 기능
- 전자결재 (결재 작성, 관리 및 승인)
- 메일 서비스 (개인 및 공용 메일함 관리)
- 직원 관리 (신규 직원 등록, 조직도 관리)
- 근태 및 휴가 관리 (출퇴근 기록 및 휴가 신청)
- 업무 일정 및 캘린더 관리 (개인 및 팀 일정 관리)
- Works 설정 (프로젝트 생성 및 프로젝트 대시보드 현황)
- 실시간 채팅 (1:1 및 그룹 채팅, 파일 전송)
- 보안 및 모니터링 (서버 상태 모니터링, 권한설정 및 메일 서명 설정)
---

## ⚙ 기술 스택

### Infra
- **OS : Rocky Linux 8**
- **DB : Oracle 11g Xe**
- **Google Cloud Platform (GCP)** – 웹 애플리케이션 및 메일 서버 배포
- **Nginx** – Reverse Proxy HTTPS 트래픽 분기 및 Tomcat 연결
- **Tomcat 9** – Spring 기반 WAS로 구동
- **Postfix** – 메일 송수신용 SMTP 서버
- **도메인 연동 및 SSL 인증서 적용**

### Back-end
- **Spring Legacy (JSP + Servlet + MyBatis) – 메인 웹 애플리케이션 구축**
- **Spring Boot (Mail API 서버) – RESTFul 메일API 서버**
- **Java 11**
- **Tomcat9**
- **MyBatis – SQL 매핑 처리**
- **WebSocket - 실시간 채팅**

### Front-end
- **JSP / JSTL**
- **HTML / CSS / JavaScript / jQuery**
- **Ajax 기반 비동기 처리**
- **Daum 주소 API** – 주소 검색 기능
- **Chart.js** – 근태현황 및 Works 통계 시각화
- **FullCalendar.js** – 일정 관리 및 프로젝트 캘린더 구현
- **공공데이터포털 API** – 공휴일 캘린더 연동

### Tools
- **IntelliJ IDEA** – 메인 개발 IDE
- **Git / GitHub** – 형상 관리 및 협업
- **Notion** – 일정 관리 및 문서화
- **ERDCloud** – DB 설계 및 구조 시각화

---

## 🏢 프로젝트 아키텍처
![프로젝트 아키텍처](https://github.com/user-attachments/assets/720468fb-3de7-4243-b616-fc55229958b7)

---

## 🛠️ ERD

![ERD](https://github.com/user-attachments/assets/ea32ae49-2aa5-4a7f-8a2e-817cec7832cd)

[ERDCloud 링크](https://www.erdcloud.com/d/T4ZMac44Pooucd7WL)

---

## 🤔 기술적 이슈와 해결 과정
- **채팅방 중복 생성 문제**
  - A와 B의 채팅방에서 B가 C와 채팅 중일 때, A가 B와 채팅을 시도하면 C와의 대화창에 A의 메시지가 노출되는 문제 발생
  - **해결** : 
프론트엔드에서 현재 열려 있는 채팅방과 무관하게 메시지를 단순 출력하던 로직 수정.
각 메시지의 roomId를 기준으로 DOM에 동적으로 렌더링되도록 개선하였으며, roomId 불일치 시 메시지 미출력 로직을 적용하여 해결.
- **include된 JSP에서 employeeList 중복 변수 에러**
  - 직원 목록을 출력하는 JSP에 상단 메뉴(JSP include)에서 동일한 변수명이 중복되어 incomplete_chunked_encoding 200 (ok) 에러 발생
  - **해결** : 
상단 메뉴 include 시 사용되던 employee라는 변수명이 내부 employeeList와 충돌
→ include에 사용하는 변수명을 employeeMenuList로 변경하여 해결
- **HTTPS 적용 후 메일서버와 통신 실패 (Mixed Content)**
  - 도메인에 SSL을 적용하고 HTTPS로 전환한 후, 브라우저의 보안정책으로 인해 Spring Boot Mail API와의 HTTP 통신이 차단됨
  - **해결** : 
Spring Boot는 내장 Tomcat으로만 구성되어 있었으나,
Nginx 웹서버를 도입하여 외부 HTTPS 요청을 내부 HTTP로 포워딩하는 reverse proxy 구조로 재설계
→ Mixed Content 이슈 해결 및 안정적인 메일 송수신 구현
- **날짜 전송 시 Timestamp → LocalDate 변환 오류**
  - form에서 input type="date" 사용 시 브라우저에서는 "yyyy-MM-dd" 형식으로 전송되지만,
서버에서는 Timestamp 타입으로 받으며 시간까지 포함되지 않아 400 에러 발생
  - **해결** : 
DTO 및 DB 필드를 Timestamp → Date 타입으로 변경
또는 DTO에서 직접 @DateTimeFormat을 지정하여 에러 회피

---

## 📚 문서화 및 일정 관리
- 프로젝트 관리는 Notion을 통해 일정 및 업무를 관리하였습니다.
- 프로젝트의 원활한 진행을 위해 다음과 같은 문서들을 작성 및 관리하였습니다.
  - **계획 보고서** : 프로젝트 초기 단계에서의 목표, 일정, 리스크 관리 등을 구체화하여 명확한 진행 방향 제시
  - **요구사항 정의서** : 프로젝트의 기능적, 비기능적 요구사항을 명확히 정의하여 개발 방향성을 설정
  - **요구사항 명세서** : 요구사항 정의서를 바탕으로 시스템의 상세 설계 사항을 기술하여 개발자들이 구현할 수 있도록 구체화
  - **WBS** : 프로젝트의 세부 작업을 구체적으로 나누고 일정 계획을 세부적으로 관리
  - **완료 보고서** : 프로젝트 종료 시점의 결과물, 달성한 목표, 개선점 등을 정리하여 향후 프로젝트 진행 시 참고자료 제공
  - **회의록** : 주기적인 회의를 통해 논의된 내용을 정리하여 팀원 간의 명확한 의사소통과 이슈 추적 관리
모든 문서는 Notion에서 관리되어 프로젝트의 효율적인 진행과 명확한 이슈 대응이 가능하도록 하였습니다.

---

## 💁‍♂️ 프로젝트 팀원
![팀원 이미지](https://github.com/user-attachments/assets/c7ecdbb5-1d9e-4a56-b4ed-3ef84271ad57)
![팀원 이미지](https://github.com/user-attachments/assets/6181a8db-76b5-4682-bbc5-16041f32993f)



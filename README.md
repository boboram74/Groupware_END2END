<!-- logo -->

# [Spring Boot] GROUPWARE Project

[![readme.md](https://img.shields.io/badge/-readme.md-important?style=flat&logo=google-chrome&logoColor=white)]() [![release](https://img.shields.io/badge/release-v2.0.0-yellow?style=flat&logo=google-chrome&logoColor=white)]()  
[![프로젝트 기간](https://img.shields.io/badge/프로젝트_기간-2025.03.01~2025.04.17-green?style=flat)]()

---

## 📝 소개
END2END 팀이 진행한 [Spring Boot] 기반의 GROUPWARE Project입니다. 조직 내 커뮤니케이션 및 업무 관리 효율화를 목표로, 전자결재, 메일 관리, 직원 관리, 일정 관리 및 실시간 채팅 기능 등을 구현하여 기업의 업무 효율성과 소통을 강화했습니다. 프로젝트는 다음 내용을 담고 있습니다.

- 프로젝트 소개
- 화면 구성
- 사용한 기술 스택
- 프로젝트 아키텍처
- ERD
- 기술적 이슈와 해결 과정
- 프로젝트 팀원

---

## 🎨 화면 구성

| 메인 페이지 | 전자결재 페이지 | 메일함 페이지 | 직원 관리 페이지 | 채팅 페이지 |
| :---: | :---: | :---: | :---: | :---: |
| ![Main](your-image-url) | ![Approval](your-image-url) | ![Mail](your-image-url) | ![Employee](your-image-url) | ![Chat](your-image-url) |

---

## 📌 주요 기능
- 전자결재 (결재 작성, 관리 및 승인)
- 메일 서비스 (개인 및 공용 메일함 관리)
- 직원 관리 (신규 직원 등록, 조직도 관리)
- 근태 및 휴가 관리 (출퇴근 기록 및 휴가 신청)
- 업무 일정 및 캘린더 관리 (개인 및 팀 일정 관리)
- 실시간 채팅 (1:1 및 그룹 채팅, 파일 전송)
- 보안 및 모니터링 (로그인 기록, 서버 상태 모니터링)

---

## ⚙ 기술 스택

### Back-end
![SpringBoot](https://github.com/yewon-Noh/readme-template/blob/main/skills/SpringBoot.png?raw=true)
![Java](https://github.com/yewon-Noh/readme-template/blob/main/skills/Java.png?raw=true)
![MyBatis](https://github.com/yewon-Noh/readme-template/blob/main/skills/MyBatis.png?raw=true)
![Oracle](https://github.com/yewon-Noh/readme-template/blob/main/skills/Oracle.png?raw=true)

### Front-end
![HTML/CSS](https://github.com/yewon-Noh/readme-template/blob/main/skills/HTMLCSS.png?raw=true)
![JavaScript](https://github.com/yewon-Noh/readme-template/blob/main/skills/JavaScript.png?raw=true)
![jQuery](https://github.com/yewon-Noh/readme-template/blob/main/skills/jQuery.png?raw=true)
![JSP](https://github.com/yewon-Noh/readme-template/blob/main/skills/JSP.png?raw=true)

### Infra
![GoogleCloud](https://github.com/yewon-Noh/readme-template/blob/main/skills/GoogleCloud.png?raw=true)
![Postfix](https://github.com/yewon-Noh/readme-template/blob/main/skills/Postfix.png?raw=true)

### Tools
![IntelliJ](https://github.com/yewon-Noh/readme-template/blob/main/skills/IntelliJ.png?raw=true)
![Github](https://github.com/yewon-Noh/readme-template/blob/main/skills/Github.png?raw=true)
![Git](https://github.com/yewon-Noh/readme-template/blob/main/skills/Git.png?raw=true)
![Notion](https://github.com/yewon-Noh/readme-template/blob/main/skills/Notion.png?raw=true)

---

## 🏢 프로젝트 아키텍처
![프로젝트 아키텍처](your-image-url)

---

## 🛠️ ERD
![ERD](your-image-url)

[ERDCloud 링크](https://www.erdcloud.com/d/your-link-here)

---

## 🤔 기술적 이슈와 해결 과정
- **웹소켓을 통한 채팅방 중복 생성 문제**
  - 채팅 메시지 전송 시 기존 채팅방이 아닌 신규 채팅방이 생성되는 이슈 해결을 위해 사용자 ID 기반의 채팅방 식별자 논리 개선
- **메일 수신 API를 통한 DB 저장 이슈**
  - 메일 수신 시 Spring Boot API를 통해 메일 데이터를 파싱하고 정확히 DB에 저장하는 로직 추가
- **톰캣 서버 성능 최적화**
  - JVM 메모리 옵션을 조정하여 배포 서버의 성능 및 안정성을 향상

---

## 📚 문서화 및 일정 관리
- 프로젝트 관리는 Notion을 통해 일정 및 업무를 관리하였습니다.

---

## 💁‍♂️ 프로젝트 팀원
![팀원 이미지](your-team-image-url)

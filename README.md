<!-- logo -->

# [Spring Boot] GROUPWARE Project

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
![SpringBoot](your-image-url)
![Java](your-image-url)
![MyBatis](your-image-url)
![Oracle](your-image-url)

### Front-end
![HTML/CSS](your-image-url)
![JavaScript](your-image-url)
![jQuery](your-image-url)
![JSP](your-image-url)

### Infra
![GoogleCloud](your-image-url)
![Postfix](your-image-url)

### Tools
![IntelliJ](your-image-url)
![Github](your-image-url)
![Git](your-image-url)
![Notion](your-image-url)

---

## 🏢 프로젝트 아키텍처
![프로젝트 아키텍처](https://github.com/user-attachments/assets/720468fb-3de7-4243-b616-fc55229958b7)

---

## 🛠️ ERD

![ERD](https://github.com/user-attachments/assets/ea32ae49-2aa5-4a7f-8a2e-817cec7832cd)

[ERDCloud 링크](https://www.erdcloud.com/d/T4ZMac44Pooucd7WL)

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
- 프로젝트의 원활한 진행을 위해 다음과 같은 문서들을 작성 및 관리하였습니다.
  - 📌 **계획 보고서** : 프로젝트 초기 단계에서의 목표, 일정, 리스크 관리 등을 구체화하여 명확한 진행 방향 제시
  - 📌 **요구사항 정의서** : 프로젝트의 기능적, 비기능적 요구사항을 명확히 정의하여 개발 방향성을 설정
  - 📌 **요구사항 명세서** : 요구사항 정의서를 바탕으로 시스템의 상세 설계 사항을 기술하여 개발자들이 구현할 수 있도록 구체화
  - 📌 **WBS(작업 분해 구조)** : 프로젝트의 세부 작업을 구체적으로 나누고 일정 계획을 세부적으로 관리
  - 📌 **완료 보고서** : 프로젝트 종료 시점의 결과물, 달성한 목표, 개선점 등을 정리하여 향후 프로젝트 진행 시 참고자료 제공
  - 📌 **회의록** : 주기적인 회의를 통해 논의된 내용을 정리하여 팀원 간의 명확한 의사소통과 이슈 추적 관리
모든 문서는 Notion에서 관리되어 프로젝트의 효율적인 진행과 명확한 이슈 대응이 가능하도록 하였습니다.

---

## 💁‍♂️ 프로젝트 팀원
![팀원 이미지](your-team-image-url)

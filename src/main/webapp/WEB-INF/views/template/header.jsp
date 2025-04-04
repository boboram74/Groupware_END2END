<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="ko">
<head>
  <meta charset="UTF-8" />
  <meta name="viewport" content="width=device-width, initial-scale=1.0" />
  <title>SIXMAN</title>
  <link
          rel="stylesheet"
          href="https://fonts.googleapis.com/icon?family=Material+Icons"
  />
  <link
          rel="stylesheet"
          href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined:opsz,wght,FILL,GRAD@24,400,0,0&icon_names=work"
  />
  <link
          href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css"
          rel="stylesheet"
          integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH"
          crossorigin="anonymous"
  />
  <script src="https://cdn.jsdelivr.net/npm/fullcalendar@6.1.15/index.global.min.js"></script>
  <script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
  <style>
    * {
      margin: 0;
      padding: 0;
      box-sizing: border-box;
      transition: all 0.3s ease;
    }

    body {
      font-family: "Arial", sans-serif;
      background-color: #f5f5f5;
      overflow-x: hidden;
    }

    .container-fluid {
      display: flex;
      min-height: 100vh;
      padding: 0;
    }

    /* PC 사이드바 스타일 */
    .sidebar {
      width: 60px;
      background-color: #2c3e50;
      height: 100vh;
      position: fixed;
      left: 0;
      top: 0;
      z-index: 1000;
      color: white;
      overflow: hidden;
      transition: width 0.3s ease;
    }

    .sidebar:hover {
      width: 240px;
    }

    .logo {
      padding: 20px;
      text-align: center;
      border-bottom: 1px solid #34495e;
      white-space: nowrap;
    }

    .logo h3 {
      display: none;
    }

    .sidebar:hover .logo h3 {
      display: block;
    }

    .menu-items {
      padding: 20px 0;
    }

    .menu-item {
      padding: 15px 20px;
      display: flex;
      align-items: center;
      cursor: pointer;
      white-space: nowrap;
      transition: background-color 0.3s;
    }

    .menu-item:hover {
      background-color: #34495e;
    }

    .menu-item i {
      min-width: 24px;
      margin-right: 10px;
      font-size: 20px;
      text-align: center;
    }

    .menu-item span {
      opacity: 0;
      transition: opacity 0.2s ease;
    }

    .sidebar:hover .menu-item span {
      opacity: 1;
    }

    /* 메인 콘텐츠 영역 */
    .boxContents {
      margin-left: 60px;
      flex: 1;
      padding: 20px;
      background-color: #f8f9fa;
      transition: margin-left 0.3s ease;
    }

    .sidebar:hover + .boxContents {
      margin-left: 240px;
    }

    /* 모바일 하단 네비게이션 바 */
    .mobile-nav {
      display: none;
      position: fixed;
      bottom: 0;
      left: 0;
      width: 100%;
      background-color: #2c3e50;
      padding: 10px 0;
      z-index: 1000;
    }

    /* 모바일 하단 네비게이션 스크롤 컨테이너 */
    .mobile-nav-scroll-container {
      width: 100%;
      overflow-x: auto;
      -webkit-overflow-scrolling: touch;
      scrollbar-width: none;
      -ms-overflow-style: none;
    }

    .mobile-nav-scroll-container::-webkit-scrollbar {
      display: none;
    }

    .mobile-menu {
      display: flex;
      min-width: max-content;
      padding: 0 10px;
      list-style: none;
      margin: 0;
    }

    .mobile-menu-item {
      flex: 0 0 auto;
      padding: 0 15px;
      white-space: nowrap;
      color: white;
      text-align: center;
      font-size: 12px;
      cursor: pointer;
    }

    .mobile-menu-item i {
      font-size: 24px;
      display: block;
      margin-bottom: 4px;
    }

    /* 스크롤 인디케이터 스타일 */
    .scroll-indicator {
      position: absolute;
      bottom: 0;
      left: 0;
      height: 2px;
      width: 100%;
      background: rgba(255, 255, 255, 0.1);
    }

    .scroll-indicator-bar {
      height: 100%;
      width: 33.33%;
      background: #ffffff;
      transition: transform 0.3s ease;
    }

    /* 전체 메뉴 모달 스타일 수정 */
    .full-menu-modal {
      display: none;
      position: fixed;
      top: 0;
      left: -100%; /* 초기 위치를 왼쪽 바깥으로 설정 */
      width: 100%;
      height: 100%;
      background-color: #2c3e50;
      z-index: 2000;
      overflow-y: auto;
      transition: left 0.3s ease-in-out; /* 왼쪽에서 오른쪽으로 이동하는 트랜지션 */
    }

    /* 모달이 보여질 때의 스타일 */
    .full-menu-modal.show {
      left: 0; /* 화면 안으로 이동 */
      display: block;
    }

    .full-menu-header {
      display: flex;
      justify-content: space-between;
      align-items: center;
      padding: 20px;
      border-bottom: 1px solid #34495e;
      color: white;
    }

    .full-menu-close {
      color: white;
      background: none;
      border: none;
      font-size: 24px;
      cursor: pointer;
    }

    .full-menu-list {
      padding: 20px;
    }

    .full-menu-item {
      display: flex;
      align-items: center;
      padding: 15px;
      color: white;
      border-bottom: 1px solid #34495e;
      cursor: pointer;
    }

    .full-menu-item i {
      margin-right: 15px;
      font-size: 24px;
    }

    .full-menu-item span {
      font-size: 16px;
    }

    /* 반응형 스타일 */
    @media (max-width: 768px) {
      .sidebar {
        display: none;
      }

      .mobile-nav {
        display: block;
      }

      .boxContents {
        margin-left: 0;
        margin-bottom: 70px;
      }

      .sidebar:hover + .boxContents {
        margin-left: 0;
      }
    }

    /* 툴팁 스타일 */
    .menu-item::after {
      content: attr(data-tooltip);
      position: absolute;
      left: 70px;
      top: 50%;
      transform: translateY(-50%);
      background-color: rgba(0, 0, 0, 0.8);
      color: white;
      padding: 5px 10px;
      border-radius: 4px;
      font-size: 12px;
      opacity: 0;
      pointer-events: none;
      transition: opacity 0.3s ease;
      white-space: nowrap;
    }

    .sidebar:not(:hover) .menu-item:hover::after {
      opacity: 1;
    }
  </style>
</head>
<body>
<div class="container-fluid">
  <!-- PC 사이드바 -->
  <div class="sidebar">
    <div class="logo">
      <h3>SIXMAN</h3>
    </div>
    <div class="menu-items">
      <div class="menu-item" data-tooltip="홈">
        <i class="material-icons">home</i>
        <span>홈</span>
      </div>
      <div class="menu-item" data-tooltip="인사관리">
        <i class="material-icons">person</i>
        <span>인사관리</span>
      </div>
      <div class="menu-item" data-tooltip="일정관리">
        <i class="material-icons">event</i>
        <span>일정관리</span>
      </div>
      <div class="menu-item" data-tooltip="메일">
        <i class="material-icons">mail</i>
        <span>메일</span>
      </div>
      <div class="menu-item" data-tooltip="전자결재">
        <i class="material-icons">description</i>
        <span>전자결재</span>
      </div>
      <div class="menu-item" data-tooltip="게시판">
        <i class="material-icons">forum</i>
        <span>게시판</span>
      </div>
      <div class="menu-item" data-tooltip="업무관리">
        <i class="material-symbols-outlined">work</i>
        <span>업무관리</span>
      </div>
      <div class="menu-item" data-tooltip="조직도">
        <i class="material-icons">groups</i>
        <span>조직도</span>
      </div>
      <div class="menu-item" data-tooltip="주소록">
        <i class="material-icons">contact_phone</i>
        <span>주소록</span>
      </div>
      <div class="menu-item" data-tooltip="예약">
        <i class="material-icons">calendar_today</i>
        <span>예약</span>
      </div>
    </div>
  </div>

  <!-- 모바일 하단 네비게이션 -->
  <nav class="mobile-nav">
    <div class="mobile-nav-scroll-container">
      <ul class="mobile-menu">
        <li class="mobile-menu-item">
          <i class="material-icons">home</i>
          <span>홈</span>
        </li>
        <li class="mobile-menu-item">
          <i class="material-icons">person</i>
          <span>인사관리</span>
        </li>
        <li class="mobile-menu-item">
          <i class="material-icons">event</i>
          <span>일정</span>
        </li>
        <li class="mobile-menu-item">
          <i class="material-icons">mail</i>
          <span>메일</span>
        </li>
        <li class="mobile-menu-item">
          <i class="material-icons">description</i>
          <span>전자결재</span>
        </li>
        <li class="mobile-menu-item">
          <i class="material-icons">forum</i>
          <span>게시판</span>
        </li>
        <li class="mobile-menu-item">
          <i class="material-symbols-outlined">work</i>
          <span>업무관리</span>
        </li>
        <li class="mobile-menu-item more-btn">
          <i class="material-icons">menu</i>
          <span>더보기</span>
        </li>
      </ul>
    </div>
    <div class="scroll-indicator">
      <div class="scroll-indicator-bar"></div>
    </div>
  </nav>

  <!-- 전체 메뉴 모달 -->
  <div class="full-menu-modal">
    <div class="full-menu-header">
      <h3>전체 메뉴</h3>
      <button class="full-menu-close">&times;</button>
    </div>
    <div class="full-menu-list">
      <div class="full-menu-item">
        <i class="material-icons">home</i>
        <span>홈</span>
      </div>
      <div class="full-menu-item">
        <i class="material-icons">person</i>
        <span>인사관리</span>
      </div>
      <div class="full-menu-item">
        <i class="material-icons">event</i>
        <span>일정관리</span>
      </div>
      <div class="full-menu-item">
        <i class="material-icons">mail</i>
        <span>메일</span>
      </div>
      <div class="full-menu-item">
        <i class="material-icons">description</i>
        <span>전자결재</span>
      </div>
      <div class="full-menu-item">
        <i class="material-icons">forum</i>
        <span>게시판</span>
      </div>
      <div class="full-menu-item">
        <i class="material-symbols-outlined">work</i>
        <span>업무관리</span>
      </div>
      <div class="full-menu-item">
        <i class="material-icons">groups</i>
        <span>조직도</span>
      </div>
      <div class="full-menu-item">
        <i class="material-icons">contact_phone</i>
        <span>주소록</span>
      </div>
      <div class="full-menu-item">
        <i class="material-icons">calendar_today</i>
        <span>예약</span>
      </div>
    </div>
  </div>

  <div class="boxContents">

<script>
  // PC 메뉴 아이템 클릭 이벤트
  document.querySelectorAll(".menu-item").forEach((item) => {
    item.addEventListener("click", function () {
      const currentActive = document.querySelector(".menu-item.active");
      if (currentActive && currentActive !== this) {
        currentActive.classList.remove("active");
      }
      this.classList.toggle("active");
    });
  });

  // 스크롤 인디케이터 관련 코드
  const scrollContainer = document.querySelector(
          ".mobile-nav-scroll-container"
  );
  const scrollIndicatorBar = document.querySelector(
          ".scroll-indicator-bar"
  );

  scrollContainer.addEventListener("scroll", () => {
    const scrollPercentage =
            (scrollContainer.scrollLeft /
                    (scrollContainer.scrollWidth - scrollContainer.clientWidth)) *
            100;
    const translateX =
            scrollPercentage * ((100 - scrollIndicatorBar.clientWidth) / 100);
    scrollIndicatorBar.style.transform = `translateX(${translateX}%)`;
  });

  // 터치 스와이프 관련 변수
  let touchStartX = 0;
  let touchEndX = 0;

  // 터치 이벤트 리스너
  scrollContainer.addEventListener("touchstart", (e) => {
    touchStartX = e.touches[0].clientX;
  });

  scrollContainer.addEventListener("touchmove", (e) => {
    touchEndX = e.touches[0].clientX;
    const diffX = touchStartX - touchEndX;
    scrollContainer.scrollLeft += diffX;
    touchStartX = touchEndX;
  });

  // 스크롤 인디케이터 너비 계산
  function updateScrollIndicatorWidth() {
    const containerWidth = scrollContainer.clientWidth;
    const contentWidth = scrollContainer.scrollWidth;
    const percentage = (containerWidth / contentWidth) * 100;
    scrollIndicatorBar.style.width = `${percentage}%`;
  }

  // 초기 로드 및 리사이즈 시 인디케이터 너비 업데이트
  window.addEventListener("load", updateScrollIndicatorWidth);
  window.addEventListener("resize", updateScrollIndicatorWidth);

  // 모바일 메뉴 아이템 활성화 효과
  const menuItems = document.querySelectorAll(
          ".mobile-menu-item:not(.more-btn)"
  );
  menuItems.forEach((item) => {
    item.addEventListener("click", function () {
      menuItems.forEach((i) => i.classList.remove("active"));
      this.classList.add("active");
    });
  });

  // 더보기 버튼 클릭 이벤트
  document
          .querySelector(".mobile-menu-item.more-btn")
          .addEventListener("click", function () {
            const modal = document.querySelector(".full-menu-modal");
            modal.style.display = "block";
            // 약간의 지연 후 show 클래스 추가 (트랜지션 효과를 위해)
            setTimeout(() => {
              modal.classList.add("show");
            }, 10);
          });

  // 닫기 버튼 클릭 이벤트
  document
          .querySelector(".full-menu-close")
          .addEventListener("click", function () {
            const modal = document.querySelector(".full-menu-modal");
            modal.classList.remove("show");
            // 트랜지션이 완료된 후 display none 처리
            setTimeout(() => {
              modal.style.display = "none";
            }, 300); // 트랜지션 시간(0.3s)과 동일하게 설정
          });

  // 전체 메뉴 아이템 클릭 이벤트
  document.querySelectorAll(".full-menu-item").forEach((item) => {
    item.addEventListener("click", function () {
      const modal = document.querySelector(".full-menu-modal");
      modal.classList.remove("show");
      setTimeout(() => {
        modal.style.display = "none";
      }, 300);
    });
  });
</script>

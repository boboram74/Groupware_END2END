<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="ko" class="light">
<head>
  <meta charset="UTF-8" />
  <meta name="viewport" content="width=device-width, initial-scale=1.0" />
  <title>END2END</title>
  <link rel="stylesheet" href="https://fonts.googleapis.com/icon?family=Material+Icons" />
  <link rel="stylesheet" href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined:opsz,wght,FILL,GRAD@24,400,0,0&icon_names=work" />
  <link rel="stylesheet" href="/css/color/newColor.css" />
  <script src="https://cdn.jsdelivr.net/npm/fullcalendar@6.1.15/index.global.min.js"></script>
  <script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
  <style>
    * {
      margin: 0;
      padding: 0;
      box-sizing: border-box;
    }

    body {
      font-family: "Arial", sans-serif;
      overflow-x: hidden;
    }

    ul {
      list-style-type: none;
    }

    .container-fluid {
      display: flex;
      min-height: 100vh;
      padding: 0;
    }

    /* 사이드바 스타일 */
    .sidebar {
      width: 60px;
      height: 100vh;
      position: fixed;
      left: 0;
      top: 0;
      z-index: 1000;
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
      height: 60px;
      display: flex;
      align-items: center;
      justify-content: center;
    }

    .logo h3 {
      display: none;
      margin: 0;
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
      position: relative;
    }

    .menu-item:hover {
      background-color: #34495e;
    }

    .menu-item i {
      width: 24px;
      margin-right: 10px;
      font-size: 20px;
      text-align: center;
      position: absolute;
      left: 20px;
    }

    .menu-item span {
      opacity: 0;
      transition: opacity 0.3s ease;
      margin-left: 34px;
    }

    .sidebar:hover .menu-item span {
      opacity: 1;
    }

    /* main-wrapper 스타일 */
    .main-wrapper {
      flex: 1;
      margin-left: 60px;
      display: flex;
      flex-direction: column;
      min-height: 100vh;
      transition: margin-left 0.3s ease;
      width: calc(100% - 60px);
    }

    /* 헤더 스타일 */
    .header {
      height: 70px;
      background-color: #fff;
      border-bottom: 1px solid #e0e0e0;
      display: flex;
      justify-content: space-between;
      align-items: center;
      padding: 0 30px;  /* 좌우 패딩 증가 */
      z-index: 999;
      position: fixed;
      top: 0;
      right: 0;
      width: calc(100% - 60px);
      transition: width 0.3s ease, left 0.3s ease;
    }

    /* 기존 header 구조는 유지하고 로고와 프로필 이미지만 수정 */
    header .logo img {
      display: none; /* 기존 img 태그 숨김 */
    }

    header .logo {
      width: 150px;
      height: 40px;
      background-image: url('/image/로그인로고.PNG');
      background-size: contain;
      background-position: center;
      background-repeat: no-repeat;
    }

    header .profile img {
      display: none; /* 기존 img 태그 숨김 */
    }

    /* CSS 코드 */
    .profile-container {
      position: relative;
    }

    .profile-menu {
      display: none;
      position: absolute;
      top: 45px;  /* header height(50px) + 약간의 여백 */
      right: 0;
      width: 160px;
      border: 1px solid var(--md-sys-color-outline);
      border-radius: 4px;
      box-shadow: 0 2px 8px rgba(0,0,0,0.1);
      z-index: 1000;
    }

    .menu-item {
      height: 40px;
      display: flex;
      align-items: center;
      padding: 0 16px;
      cursor: pointer;
      transition: background-color 0.2s;
    }

    .menu-item:hover {
      background-color: var(--md-sys-color-surface-container);
      color: var(--md-sys-color-primary);
    }

    .profile {
      width: 40px;
      height: 40px;
      background-size: cover;
      background-position: center;
      background-repeat: no-repeat;
      border-radius: 50%;
      cursor: pointer;
    }

    /* 헤더 아이콘 관련 스타일 추가 */
    .header-icons {
      display: flex;
      align-items: center;
      gap: 15px;  /* 아이콘 간격 */
    }

    .icon-button {
      background: none;
      border: none;
      padding: 10px;
      cursor: pointer;
      position: relative;
      border-radius: 50%;
      display: flex;
      align-items: center;
      justify-content: center;
      transition: background-color 0.2s;
    }

    .icon-button:hover {
      background-color: rgba(0, 0, 0, 0.05);
    }

    .icon-button .material-symbols-outlined {
      font-size: 28px;  /* 아이콘 크기 증가 */
      color: var(--md-sys-color-secondary);
    }
    /* 알림 배지 스타일 */
    .notification-badge {
      position: absolute;
      top: 0;
      right: 0;
      background-color: #e74c3c;
      color: white;
      font-size: 12px;
      padding: 2px 6px;
      border-radius: 10px;
      min-width: 18px;
      text-align: center;
    }

    /* 다크모드일 때의 스타일 */
    html.dark .icon-button i {
      color: #eee;
    }

    html.dark .icon-button:hover {
      background-color: rgba(255, 255, 255, 0.1);
    }

    /* boxContents 스타일 */
    .boxContents {
      flex: 1;
      padding: 20px;
      margin-top: 60px;
    }

    /* 모바일 메뉴 모달 스타일 */
    .full-menu-modal {
      position: fixed;
      top: 0;
      left: -100%;
      width: 100%;
      height: 100vh;
      background-color: rgba(0, 0, 0, 0.7);
      z-index: 1100;
      backdrop-filter: blur(5px);
      transition: all 0.3s ease-in-out;
      opacity: 0;
    }


    .full-menu-modal.show {
      left: 0;
      opacity: 1;
    }

    .full-menu-content {
      position: fixed;
      top: 0;
      left: -100%; /* 300px에서 100%로 변경 */
      width: 100%; /* 300px에서 100%로 변경 */
      height: 100vh;
      transition: all 0.3s ease-in-out;
    }

    .full-menu-modal.show .full-menu-content {
      left: 0;
    }

    .full-menu-header {
      padding: 30px;
      border-bottom: 1px solid rgba(255, 255, 255, 0.1);
    }

    .full-menu-list {
      height: calc(100% - 60px);
      overflow-y: auto;
      padding: 20px;
      display: flex; /* 추가 */
      flex-direction: column; /* 추가 */
      gap: 10px; /* 추가 - 메뉴 항목 간 간격 */

    }

    .full-menu-list li {
      padding: 20px;
      border-bottom: 1px solid rgba(255, 255, 255, 0.1);
    }

    .full-menu-list li a {
      color: white;
      text-decoration: none;
      display: flex;
      align-items: center;
      font-size: 18px;
    }

    .full-menu-list li i {
      width: 24px;
      text-align: center;
      margin-right: 20px; /* 여백 증가 */
      font-size: 32px;
    }

    .close-menu-btn {
      position: absolute;
      top: 20px;
      right: 20px;
      font-size: 32px;
      cursor: pointer;
      color: white;
      background: none;
      border: none;
      z-index: 1200;
    }

    .close-menu-btn:hover {
      color: #e74c3c;
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
      padding: 0 15px;
      color: white;
      text-align: center;
      text-decoration: none;
    }

    .mobile-menu-item i {
      font-size: 24px;
      display: block;
      margin-bottom: 5px;
    }

    /* menu-item 관련 스타일 - !important 제거하고 선택자 구체성 높임 */
    .menu-items .menu-item a,
    .menu-items .menu-item a:link,
    .menu-items .menu-item a:visited,
    .menu-items .menu-item a:hover,
    .menu-items .menu-item a:active {
      color: white;
      text-decoration: none;
    }


    /* 모바일 반응형 */
    @media (max-width: 768px) {
      .sidebar {
        width: 0;
        display: none;
      }

      .main-wrapper {
        margin-left: 0;
        width: 100%;
      }

      .header {
        width: 100%;
        left: 0;
      }

      .mobile-nav {
        display: block;
      }

      .boxContents {
        padding-bottom: 70px;
      }

      .full-menu-modal.show {
        display: block;
      }
    }
  </style>
</head>
<body>
<div class="container-fluid bg-color">
  <!-- 사이드바 -->
  <div class="sidebar sidebar-color">
    <div class="logo">
      <h3>END2END</h3>
    </div>
    <div class="menu-items">
      <div class="menu-item">
        <a href="/">
          <i class="material-icons">home</i>
          <span>홈</span>
        </a>
      </div>
      <div class="menu-item">
        <a href="/board/list/1">
          <i class="material-icons">dashboard</i>
          <span>게시판</span>
        </a>
      </div>
      <div class="menu-item">
        <a href="/approval/list/1">
          <i class="material-icons">description</i>
          <span>전자결재</span>
        </a>
      </div>
      <div class="menu-item">
        <a href="/mail/list">
          <i class="material-icons">mail</i>
          <span>메일</span>
        </a>
      </div>
      <div class="menu-item">
        <a href="/commute/detail/1">
          <i class="material-icons">schedule</i>
          <span>근태관리</span>
        </a>
      </div>
      <div class="menu-item">
        <a href="/schedule/list">
          <i class="material-icons">event_available</i>
          <span>예약</span>
        </a>
      </div>
    </div>
  </div>
  <div class="main-wrapper">
    <header class="header">
      <div class="logo"></div>
      <div class="header-icons">
        <!-- 알람 아이콘 -->
        <button class="icon-button" id="notificationBtn">
          <span class="material-icons">notifications</span>
          <span class="notification-badge">0</span>
        </button>

        <!-- 조직도 아이콘 -->
        <button class="icon-button" id="orgChartBtn">
          <span class="material-icons">account_tree</span>
        </button>

        <!-- 다크모드 토글 아이콘 -->
        <button class="icon-button" id="darkModeBtn">
          <span class="material-icons">dark_mode</span>
        </button>

        <div class="profile-container">
          <div class="profile"
               style="background-image: url('${(employee.profileImg == null) ? '/images/defaultImg.jpg' : employee.profileImg}')">
          </div>
          <div class="profile-menu surface-bright" id="profileMenu">
            <div class="menu-item" id="mypage">마이페이지</div>
            <div class="menu-item" id="login-history">로그인 기록</div>
            <c:if test='${employee.role.equals("ADMIN")}'>
              <div class="menu-item" id="admin">관리자 페이지로 이동</div>
            </c:if>
            <div class="menu-item" id="logout">로그아웃</div>
          </div>
        </div>
      </div>
    </header>
    <!-- 전체 메뉴 모달 -->
    <div class="full-menu-modal sidebar-color">
      <div class="full-menu-content">
        <div class="full-menu-header">
          <button class="close-menu-btn">
            <i class="material-icons">close</i>
          </button>
        </div>
        <ul class="full-menu-list">
          <li>
            <a href="/">
              <i class="material-icons">home</i>
              <span>홈</span>
            </a>
          </li>
          <li>
            <a href="/board/list/1">
              <i class="material-icons">dashboard</i>
              <span>게시판</span>
            </a>
          </li>
          <li>
            <a href="/approval/list">
              <i class="material-icons">description</i>
              <span>전자결재</span>
            </a>
          </li>
          <li>
            <a href="/mail/list">
              <i class="material-icons">mail</i>
              <span>메일</span>
            </a>
          </li>
          <li>
            <a href="/commute/detail/1">
              <i class="material-icons">schedule</i>
              <span>근태관리</span>
            </a>
          </li>
          <li>
            <a href="/schedule/list/1">
              <i class="material-icons">event_available</i>
              <span>예약</span>
            </a>
          </li>
        </ul>
      </div>
    </div>

    <!-- 모바일 네비게이션 -->
    <div class="mobile-nav">
      <div class="mobile-nav-scroll-container">
        <div class="mobile-menu">
          <a href="#" class="mobile-menu-item">
            <i class="material-icons">home</i>
            <span>홈</span>
          </a>
          <a href="#" class="mobile-menu-item">
            <i class="material-icons">dashboard</i>
            <span>게시판</span>
          </a>
          <a href="#" class="mobile-menu-item">
            <i class="material-icons">description</i>
            <span>전자결재</span>
          </a>
          <a href="#" class="mobile-menu-item">
            <i class="material-icons">mail</i>
            <span>메일</span>
          </a>
          <a href="#" class="mobile-menu-item">
            <i class="material-icons">schedule</i>
            <span>근태관리</span>
          </a>
          <a href="#" class="mobile-menu-item">
            <i class="material-icons">event_available</i>
            <span>예약</span>
          </a>
        </div>
      </div>
    </div>

    <!-- 콘텐츠 영역 -->
    <div class="boxContents">
      <!-- 메인 콘텐츠가 들어갈 자리 -->

<script>
  $(document).ready(function() {
    // 모바일 메뉴 열기
    $('.mobile-menu-item').click(function(e) {
      e.preventDefault();
      $('.full-menu-modal').addClass('show');
      $('body').css('overflow', 'hidden');
    });

    // 모바일 메뉴 닫기 (수정된 부분)
    $('.close-menu-btn').click(function(e) {
      e.preventDefault();
      e.stopPropagation();
      $('.full-menu-modal').removeClass('show');
      $('body').css('overflow', '');
    });

    // 모달 배경 클릭 시 닫기
    $('.full-menu-modal').click(function(e) {
      if ($(e.target).hasClass('full-menu-modal')) {
        $('.full-menu-modal').removeClass('show');
        $('body').css('overflow', '');
      }
    });

    // 메뉴 컨텐츠 클릭 시 이벤트 전파 중지
    $('.full-menu-content').click(function(e) {
      e.stopPropagation();
    });

    // 프로필 이미지 클릭 이벤트
    $('.profile').on('click', function(e) {
      e.stopPropagation(); // 이벤트 버블링 방지
      $('#profileMenu').toggle();
    });

    // 문서 전체 클릭 이벤트 (메뉴 외부 클릭시 닫기)
    $(document).on('click', function(e) {
      if (!$(e.target).closest('.profile-container').length) {
        $('#profileMenu').hide();
      }
    });

    // 선택적: 메뉴 아이템 클릭 이벤트 예시
    $('.menu-item').on('click', function() {
      const id = $(this).attr('id');

      if (id === 'mypage') {
        window.location.href = '/mypage/${employee.id}';
      } else if (id === 'logout') {
        window.location.href = '/employee/logout';
      }
    });
  });
</script>
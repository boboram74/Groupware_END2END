<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="ko">
<head>
  <meta charset="UTF-8" />
  <meta name="viewport" content="width=device-width, initial-scale=1.0" />
<<<<<<< HEAD
  <title>Document</title>
  <link rel="stylesheet" href="https://fonts.googleapis.com/icon?family=Material+Icons"/>
  <link rel="stylesheet" href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined:opsz,wght,FILL,GRAD@24,400,0,0&icon_names=work" />
  <link
          href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css"
          rel="stylesheet"
          integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH"
          crossorigin="anonymous"
  />
=======
  <title>SIXMAN</title>
  <link rel="stylesheet" href="https://fonts.googleapis.com/icon?family=Material+Icons" />
  <link rel="stylesheet" href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined:opsz,wght,FILL,GRAD@24,400,0,0&icon_names=work" />
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" />
>>>>>>> 0962482cb2f25879617868f2e965199bc29b624d
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
      background-color: #f5f5f5;
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
      height: 50px;
      background-color: #fff;
      border-bottom: 1px solid #e0e0e0;
      display: flex;
      justify-content: space-between;
      align-items: center;
      padding: 0 20px;
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
      background-color: #fff;
      border: 1px solid #e0e0e0;
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
      background-color: #f5f5f5;
      color: #2c3e50;
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

    /* boxContents 스타일 */
    .boxContents {
      flex: 1;
      padding: 20px;
      background-color: #f8f9fa;
      margin-top: 50px;
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
      background-color: #2c3e50;
      transition: all 0.3s ease-in-out;
    }

    .full-menu-modal.show .full-menu-content {
      left: 0;
    }

    .full-menu-header {
      padding: 30px;
      background-color: #2c3e50;
      border-bottom: 1px solid rgba(255, 255, 255, 0.1);
    }

    .full-menu-list {
      background-color: #2c3e50;
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
<div class="container-fluid">
<<<<<<< HEAD
  <div class="sidebar d-xs-none .d-md-block">
    <div class="icon">
      <ul>
        <li><svg xmlns="http://www.w3.org/2000/svg" width="25" height="25" fill="currentColor" class="bi bi-list" viewBox="0 0 16 16">
          <path fill-rule="evenodd" d="M2.5 12a.5.5 0 0 1 .5-.5h10a.5.5 0 0 1 0 1H3a.5.5 0 0 1-.5-.5m0-4a.5.5 0 0 1 .5-.5h10a.5.5 0 0 1 0 1H3a.5.5 0 0 1-.5-.5m0-4a.5.5 0 0 1 .5-.5h10a.5.5 0 0 1 0 1H3a.5.5 0 0 1-.5-.5"/>
        </svg>
        </li>
      </ul>
      <ul>
        <li>홈
        </li>
      </ul>
    </div>

    <div class="icon">


      <ul>
        <li><svg xmlns="http://www.w3.org/2000/svg"  width="25" height="25" fill="currentColor" class="bi bi-clipboard2" viewBox="0 0 16 16">
          <path d="M3.5 2a.5.5 0 0 0-.5.5v12a.5.5 0 0 0 .5.5h9a.5.5 0 0 0 .5-.5v-12a.5.5 0 0 0-.5-.5H12a.5.5 0 0 1 0-1h.5A1.5 1.5 0 0 1 14 2.5v12a1.5 1.5 0 0 1-1.5 1.5h-9A1.5 1.5 0 0 1 2 14.5v-12A1.5 1.5 0 0 1 3.5 1H4a.5.5 0 0 1 0 1z"/>
          <path d="M10 .5a.5.5 0 0 0-.5-.5h-3a.5.5 0 0 0-.5.5.5.5 0 0 1-.5.5.5.5 0 0 0-.5.5V2a.5.5 0 0 0 .5.5h5A.5.5 0 0 0 11 2v-.5a.5.5 0 0 0-.5-.5.5.5 0 0 1-.5-.5"/>
        </svg>
        </li>
      </ul>
      <ul>
        <li>게시판
        </li>
      </ul>

    </div>

    <div class="icon">
      <ul>
        <li><svg xmlns="http://www.w3.org/2000/svg"  width="25" height="25" fill="currentColor" class="bi bi-envelope" viewBox="0 0 16 16">
          <path d="M0 4a2 2 0 0 1 2-2h12a2 2 0 0 1 2 2v8a2 2 0 0 1-2 2H2a2 2 0 0 1-2-2zm2-1a1 1 0 0 0-1 1v.217l7 4.2 7-4.2V4a1 1 0 0 0-1-1zm13 2.383-4.708 2.825L15 11.105zm-.034 6.876-5.64-3.471L8 9.583l-1.326-.795-5.64 3.47A1 1 0 0 0 2 13h12a1 1 0 0 0 .966-.741M1 11.105l4.708-2.897L1 5.383z"/>
        </svg>
        </li>
      </ul>
      <ul>
        <li>메일
        </li>
      </ul>
    </div>

    <div class="icon">
      <ul>
        <li><svg xmlns="http://www.w3.org/2000/svg"  width="25" height="25"  fill="currentColor" class="bi bi-archive" viewBox="0 0 16 16">
          <path d="M0 2a1 1 0 0 1 1-1h14a1 1 0 0 1 1 1v2a1 1 0 0 1-1 1v7.5a2.5 2.5 0 0 1-2.5 2.5h-9A2.5 2.5 0 0 1 1 12.5V5a1 1 0 0 1-1-1zm2 3v7.5A1.5 1.5 0 0 0 3.5 14h9a1.5 1.5 0 0 0 1.5-1.5V5zm13-3H1v2h14zM5 7.5a.5.5 0 0 1 .5-.5h5a.5.5 0 0 1 0 1h-5a.5.5 0 0 1-.5-.5"/>
        </svg>
        </li>
      </ul>
      <ul>
        <li>전자결재
        </li>
      </ul>
    </div>


    <div class="icon">
      <ul>
        <li><svg xmlns="http://www.w3.org/2000/svg"  width="25" height="25"  fill="currentColor" class="bi bi-briefcase-fill" viewBox="0 0 16 16">
          <path d="M6.5 1A1.5 1.5 0 0 0 5 2.5V3H1.5A1.5 1.5 0 0 0 0 4.5v1.384l7.614 2.03a1.5 1.5 0 0 0 .772 0L16 5.884V4.5A1.5 1.5 0 0 0 14.5 3H11v-.5A1.5 1.5 0 0 0 9.5 1zm0 1h3a.5.5 0 0 1 .5.5V3H6v-.5a.5.5 0 0 1 .5-.5"/>
          <path d="M0 12.5A1.5 1.5 0 0 0 1.5 14h13a1.5 1.5 0 0 0 1.5-1.5V6.85L8.129 8.947a.5.5 0 0 1-.258 0L0 6.85z"/>
        </svg>
        </li>
      </ul>
      <ul>
        <li>업무보고
        </li>
      </ul>
    </div>

    <div class="icon">
      <ul>
        <li><svg xmlns="http://www.w3.org/2000/svg"  width="25" height="25" fill="currentColor" class="bi bi-clock" viewBox="0 0 16 16">
          <path d="M8 3.5a.5.5 0 0 0-1 0V9a.5.5 0 0 0 .252.434l3.5 2a.5.5 0 0 0 .496-.868L8 8.71z"/>
          <path d="M8 16A8 8 0 1 0 8 0a8 8 0 0 0 0 16m7-8A7 7 0 1 1 1 8a7 7 0 0 1 14 0"/>
        </svg>
        </li>
      </ul>
      <ul>
        <li>일정/예약
        </li>
      </ul>
    </div>


    <div class="icon">
      <ul>
        <li><span class="material-icons">person</span>
        </li>
      </ul>
      <ul>
        <li>인사관리
        </li>
      </ul>
    </div>


  </div>

  <div class="main">
    <div class="header">
     <div class="logo">
      <img src="/image/로그인로고.PNG" class="fit"> </div>


      <div class="profile">
            <span class="photo">
              <a href="/mypage/${employee.id}">
                <c:choose>
                  <c:when test="${employee == null}">
                    <img class="profileIcon" src="/image/defaultImg.jpg" />
                  </c:when>
                  <c:otherwise>
                    <img class="profileIcon" src="${employee.profileImg}" />
                  </c:otherwise>
                </c:choose>
                <!-- 세션에서 이미지 불러오기 -->
              </a>
            </span>
=======
  <!-- 사이드바 -->
  <div class="sidebar">
    <div class="logo">
      <h3>SIXMAN</h3>
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
      <div class="profile-container">
        <div class="profile"
             style="background-image: url('${(employee.profileImg == null) ? '/images/defaultImg.jpg' : employee.profileImg}')">
        </div>
        <div class="profile-menu" id="profileMenu">
          <div class="menu-item" id="mypage">마이페이지</div>
          <div class="menu-item" id="login-history">로그인 기록</div>
          <c:if test='${employee.role.equals("ADMIN")}'>
            <div class="menu-item" id="admin">관리자 페이지로 이동</div>
          </c:if>
          <div class="menu-item" id="logout">로그아웃</div>
        </div>
      </div>
    </header>
    <!-- 전체 메뉴 모달 -->
    <div class="full-menu-modal">
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
>>>>>>> 0962482cb2f25879617868f2e965199bc29b624d
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
  });

  $(document).ready(function() {
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

      if (id == 'mypage') {
        window.location.href = '/mypage/${employee.id}';
      } else if (id == 'logout') {
        window.location.href = '/employee/logout';
      }
    });
  });
</script>
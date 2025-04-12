<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
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
  <link rel="stylesheet" href="/css/color/calenderColor.css" />
  <link rel="stylesheet" href="/css/template/header.css" />
  <script src="https://cdn.jsdelivr.net/npm/fullcalendar@6.1.15/index.global.min.js"></script>
  <script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
</head>
<body>
<div id="loading" style="display: none">
  <div class="loading-overlay"></div>
  <div class="loading-img"></div>
</div>
<div class="container-fluid bg-color">
  <!-- 사이드바 -->
  <div class="sidebar sidebar-color">
    <div class="logo" onClick="location.href='/'">
      <h3>END2END</h3>
    </div>
    <div class="menu-items">
      <div class="menu-item" onClick="location.href='/board/list/1'">
        <i class="material-icons">dashboard</i>
        <span>게시판</span>
      </div>
      <div class="menu-item" onClick="location.href='/approval/list'">
        <i class="material-icons">description</i>
        <span>전자결재</span>
      </div>
      <div class="menu-item" onClick="location.href='/mail/list'">
        <i class="material-icons">mail</i>
        <span>메일</span>
      </div>
      <div class="menu-item" onClick="location.href='/commute/detail'">
        <i class="material-icons">work_history</i>
        <span>근태관리</span>
      </div>
      <div class="menu-item" onClick="location.href='/schedule/list'">
        <i class="material-icons">event_available</i>
        <span>예약</span>
      </div>
      <div class="menu-item" onClick="location.href='/hr/list'">
        <i class="material-icons">people</i>
        <span>인사관리</span>
    </div>
      <div class="menu-item" onClick="location.href='/project/main'">
        <i class="material-icons">description</i>
        <span>Works</span>
      </div>

      <div class="menu-item" onClick="location.href='/contact'">
        <i class="material-icons">contacts</i>
        <span>주소록</span>
      </div>
    </div>
  </div>
  <div class="main-wrapper">
    <header class="header">
      <div class="logo" onClick="location.href='/'"></div>
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
               style="background-image: url('${(employee.profileImg == null) ? '/image/defaultImg.jpg' : employee.profileImg}')">
          </div>
          <div class="profile-menu surface-bright" id="profileMenu">
            <div class="menu-item" id="mypage">마이페이지</div>
            <div class="menu-item" id="login-history">로그인 기록</div>
            <c:if test='${employee.role.equals("ADMIN")}'>
              <div class="menu-item" id="admin">관리자 페이지</div>
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
            <a href="/commute/detail">
              <i class="material-icons">work</i>
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
    <div class="mobile-nav sidebar-color">
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

  $(document).ready(function() {
    // 페이지 로드 시작할 때 로딩 표시
    showLoading();

    // 모든 Ajax 요청 시작 시 로딩 표시
    $(document).ajaxStart(function() {
      showLoading();
    });

    // 모든 Ajax 요청 완료 시 로딩 숨김
    $(document).ajaxStop(function() {
      hideLoading();
    });

    function showLoading() {
      $('#loading').show();
    }

    function hideLoading() {
      $('#loading').hide();
    }

    // 모든 초기 데이터 로딩이 완료되면
    Promise.all([
      // 필요한 다른 초기 데이터 로딩
      // 예: 사용자 정보, 설정 등
    ]).finally(() => {
      hideLoading();
    });
  })
</script>
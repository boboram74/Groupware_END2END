<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="ko">
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
  <script>
    let mode = (sessionStorage.getItem('mode') == null) ? 'light' : sessionStorage.getItem('mode');
    $('html').addClass(mode);
  </script>
  <style>
    /* 모바일 반응형 */
    @media (max-width: 768px) {
      /* 기존 채팅 버튼 숨기기 */
      #chatButton {
        display: none;
      }
    }

    .notification-container {
      position: relative;
      display: inline-block;
    }

    .notification-menu {
      display: none;
      position: absolute;
      top: 100%;
      right: 0;
      width: 300px;
      border-radius: 8px;
      box-shadow: 0 2px 10px rgba(0,0,0,0.1);
      z-index: 1000;
      margin-top: 8px;
    }

    .notification-header {
      display: flex;
      justify-content: space-between;
      align-items: center;
      padding: 12px 16px;
      border-bottom: 1px solid var(--md-sys-color-outline);
    }

    .notification-header h5 {
      margin: 0;
      font-size: 16px;
    }

    .close-notification {
      cursor: pointer;
    }

    .notification-list {
      max-height: 400px;
      overflow-y: auto;
    }

    .notification-item {
      display: flex;
      align-items: center;
      padding: 12px 16px;
      border-bottom: 1px solid var(--md-sys-color-outline);
      cursor: pointer;
    }

    .notification-item:hover {
      background-color: var(--md-sys-color-surface-container);
      color: var(--md-sys-color-primary);
    }

    .notification-item .material-icons {
      margin-right: 12px;
      font-size: 20px;
    }

    .notification-content {
      flex: 1;
    }

    .notification-text {
      font-size: 14px;
      margin-bottom: 4px;
    }

    .notification-date {
      font-size: 12px;
      color: var(--md-sys-color-secondary);
    }

    .notification-content.read .notification-text,
    .notification-content.read .notification-date {
      opacity: 0.4; /* 투명도를 40% 낮춤 */
    }


    .color-primary { color: #1976d2; }
    .color-success { color: #4caf50; }
    .color-warning { color: #ff9800; }
    .color-info { color: #2196f3; }
    .color-danger { color: #f44336; }

    .notification-list::-webkit-scrollbar {
      width: 6px;
    }

    .notification-list::-webkit-scrollbar-track {
      background: rgba(0, 0, 0, 0.1);
      margin: 0;
    }

    .notification-list::-webkit-scrollbar-thumb {
      background: var(--md-sys-color-surface-variant);
      border-radius: 4px;
      box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
    }

    .notification-list::-webkit-scrollbar-thumb:hover {
      background: var(--md-sys-color-outline);
    }

    @keyframes notificationAnimation {
      0% {
        transform: scale(1) rotate(0deg);
      }
      25% {
        transform: scale(1.2) rotate(20deg);
      }
      50% {
        transform: scale(1.2) rotate(-15deg);
      }
      75% {
        transform: scale(1.1) rotate(10deg);
      }
      100% {
        transform: scale(1) rotate(0deg);
      }
    }

    .notification-animate {
      animation: notificationAnimation 0.8s ease-in-out;
      transform-origin: center;
    }
  </style>
  <style>
    /* 조직도 버튼 및 컨테이너 스타일 */
    .orgchart-container {
      position: relative;
    }

    /* 조직도 메뉴 스타일 */
    .orgchart-menu {
      display : none;
      position: absolute;
      top: 100%;
      right: 0;
      width: 500px;
      background: #fff;
      border-radius: 16px;
      box-shadow: 0 4px 20px rgba(0, 0, 0, 0.08);
      z-index: 1000;
    }

    .orgchart-header {
      display: flex;
      align-items: center;
      justify-content: space-between;
      padding: 16px 20px;
      border-bottom: 1px solid #f0f0f0;
    }

    .orgchart-header h5 {
      font-size: 16px;
      font-weight: 600;
      color: var(--md-sys-color-on-surface);
      margin: 0;
    }

    .close-orgchart {
      cursor: pointer;
      padding: 4px;
      color: #666;
    }

    .close-orgchart:hover {
      background: rgba(0, 0, 0, 0.04);
      border-radius: 50%;
    }

    .orgchart-content {
      padding: 20px;
      max-height: 600px;
      overflow-y: auto;
    }

    /* 조직도 본문 스타일 */
    .org-chart {
      padding: 20px;
    }

    .org-box {
      background: #fff;
      border: 1px solid #e0e0e0;
      border-radius: 12px;
      padding: 24px;
      margin-bottom: 24px;
      box-shadow: 0 2px 8px rgba(0, 0, 0, 0.04);
    }

    .department-title {
      background: var(--md-sys-color-primary);
      color: #fff;
      font-size: 18px;
      font-weight: 600;
      padding: 12px 24px;
      margin: -24px -24px 24px -24px;
      border-radius: 12px 12px 0 0;
      text-align: center;
      letter-spacing: -0.5px;
    }

    .members-tree {
      display: flex;
      flex-wrap: wrap;
      justify-content: center;
      gap: 60px;
      position: relative;
      padding-top: 24px;
    }

    /* 상단 중앙 세로선 */
    .members-tree::before {
      content: '';
      position: absolute;
      top: 0;
      left: 50%;
      width: 2px;
      height: 24px;
      background: #e0e0e0;
    }

    /* 가로선 */
    .members-tree::after {
      content: '';
      position: absolute;
      top: 24px;
      left: 50%;
      transform: translateX(-50%);
      width: 80%;
      height: 1px;
      background: #e0e0e0;
    }

    .member {
      display: flex;
      flex-direction: column;
      align-items: center;
      gap: 4px;
      position: relative;
      padding-top: 24px;
      min-width: 80px;
    }

    /* 가로선과 사원명 사이의 세로선 */
    .member::before {
      content: '';
      position: absolute;
      top: 0;
      left: 50%;
      width: 1px;
      height: 24px;
      background: #e0e0e0;
    }

    .member .name {
      font-size: 15px;
      font-weight: 500;
      color: var(--md-sys-color-on-surface);
    }

    .member .position {
      font-size: 13px;
      color: #666;
    }

    /* 스크롤바 스타일링 */
    .orgchart-content::-webkit-scrollbar {
      width: 6px;
    }

    .orgchart-content::-webkit-scrollbar-track {
      background: #f1f1f1;
    }

    .orgchart-content::-webkit-scrollbar-thumb {
      background: #ddd;
      border-radius: 3px;
    }

    /* 조직도 열고 닫기 애니메이션 */
    .orgchart-menu {
      transition: transform 0.3s ease, opacity 0.3s ease;
      transform-origin: top right;
    }

    .orgchart-menu.hidden {
      transform: scale(0.95);
      opacity: 0;
      pointer-events: none;
    }
  </style>
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
        <div class="notification-container">
          <button class="icon-button" id="notificationBtn">
            <span class="material-icons">notifications</span>
            <span class="notification-badge" style="display: none;">0</span>
          </button>
          <div class="notification-menu surface-bright" id="notificationMenu">
            <div class="notification-header">
              <h5>알림</h5>
              <span class="material-icons close-notification">close</span>
            </div>
            <div class="notification-list">
              <div class="notification-item">
                <span class="material-icons color-primary">notifications_paused</span>
                <div class="notification-content">
                  <div class="notification-text">현재 알람이 없습니다.</div>
                  <div class="notification-date"></div>
                </div>
              </div>
            </div>
          </div>
        </div>

        <div class="orgchart-container">
          <button class="icon-button" id="orgChartBtn">
            <span class="material-icons">account_tree</span>
          </button>
          <div class="orgchart-menu">
            <div class="orgchart-header">
              <h5>조직도</h5>
              <span class="material-icons close-orgchart">close</span>
            </div>
            <div class="orgchart-content">
              <div class="org-chart">
                <div class="org-box">
                  <div class="department-title">경영지원본부</div>
                  <div class="members-tree">
                    <div class="member">
                      <span class="name">홍길동</span>
                      <span class="position">팀장</span>
                    </div>
                    <div class="member">
                      <span class="name">김철수</span>
                      <span class="position">대리</span>
                    </div>
                    <div class="member">
                      <span class="name">이영희</span>
                      <span class="position">과장</span>
                    </div>
                  </div>
                </div>

                <div class="org-box">
                  <div class="department-title">개발팀</div>
                  <div class="members-tree">
                    <div class="member">
                      <span class="name">박지성</span>
                      <span class="position">팀장</span>
                    </div>
                    <div class="member">
                      <span class="name">손흥민</span>
                      <span class="position">대리</span>
                    </div>
                    <div class="member">
                      <span class="name">김민재</span>
                      <span class="position">사원</span>
                    </div>
                  </div>
                </div>
              </div>
            </div>
          </div>
        </div>



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
              <i class="material-icons">list</i>
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
            <a href="/schedule/list">
              <i class="material-icons">event_available</i>
              <span>예약</span>
            </a>
          </li>
          <li>
            <a href="/hr/list">
              <i class="material-icons">people</i>
              <span>인사관리</span>
            </a>
          </li>
          <li>
            <a href="/project/main">
              <i class="material-icons">description</i>
              <span>works</span>
            </a>
          </li>
          <li>
            <a href="/contact">
              <i class="material-icons">contacts</i>
              <span>주소록</span>
            </a>
          </li>
        </ul>
      </div>
    </div>

    <!-- 모바일 네비게이션 -->
    <div class="mobile-nav sidebar-color">
      <div class="mobile-nav-scroll-container">
        <div class="mobile-menu">
          <a href="#" class="mobile-menu-item open-mobile-menu">
            <i class="material-icons">list</i>
            <span>메뉴</span>
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
          <a href="#" class="mobile-menu-item mobile-chat-btn">
            <i class="material-icons">chat</i>
            <span>채팅</span>
          </a>
        </div>
      </div>
    </div>

    <!-- 콘텐츠 영역 -->
    <div class="boxContents">
      <!-- 메인 콘텐츠가 들어갈 자리 -->

      <script>
        $(document).ready(function() {
          const alarm = new WebSocket('ws://localhost/alarm');

          alarm.onopen = function() {
            console.log('알람 웹소켓 연결됨');
          };

          alarm.onerror = function(error) {
            console.log('알람 웹소켓 에러:', error);
          };

          alarm.onclose = function(event) {
            console.log('알람 웹소켓 닫힘:', event.code, event.reason);
          };

          alarm.onmessage = function(e) {
            const data = JSON.parse(e.data);
            console.log(data);

            let notReadCount = 0;

            if (data.length > 0) {
              $('#notificationMenu .notification-list').empty();
            }

            for (let i = 0; i < data.length; i++) {
              const item = data[i];

              const readYn = (item.isRead) ? 'read' : '';
              if (!item.isRead) {
                notReadCount++;
              }

              const div = $('<div class="notification-item">');
              div.append($('<span class="material-icons">').addClass('color-' + item.type).text(item.icons))
                      .append($('<div class="notification-content">').addClass(readYn)
                              .append($('<div class="notification-text">').text(item.message))
                              .append($('<div class="notification-date">').text(parseTime(item.sendTime))))

              if (item.url !== '') {
                div.on('click', function() {
                  alarm.send(JSON.stringify({
                    'id': Number(item.id),
                    'employeeId': String(${employee.id})
                  }));

                  location.href = item.url;
                })
                $('#notificationMenu .notification-list').append(div);
              }

              if (notReadCount > 0) {
                $('#notificationBtn .notification-badge').show().text(notReadCount);

                $('#notificationBtn .material-icons').removeClass('notification-animate');
                $('#notificationBtn .material-icons')[0].offsetWidth;
                $('#notificationBtn .material-icons').addClass('notification-animate')
                        .one('animationend', function() {
                          $(this).removeClass('notification-animate');
                        });
              }
            }

            function parseTime(time) {
              const date = new Date(time);
              return date.toLocaleDateString() + ' ' + date.toLocaleTimeString();
            }
          }
        });

      function orgChartModal() {
        $.ajax({
          url: '/employee/orgChart',
          method: 'GET'
        }).done(function (data) {
          $('#orgChartContainer').empty();
          const employeeList = [
            {name: '대표', id: 6, employee: []},
            {name: '경영팀', id: 1, employee: []},
            {name: '인사팀', id: 2, employee: []},
            {name: '총무팀', id: 3, employee: []},
            {name: '운영지원팀', id: 4, employee: []},
            {name: '연구팀', id: 5, employee: []}];

          for (let i = 0; i < data.length; i++) {
            const employee = data[i];

            for (let j = 0; j < employeeList.length; j++) {
              const departments = employeeList[j];
              if (departments.id == employee.departmentId) {
                departments.employee.push(employee);
              }
            }
          }
          for (let i = 0; i < employeeList.length; i++) {
            const departmentList = employeeList[i];
            const title = $('<div>').html(departmentList.name).css({
              'background-color': '#2c3e50',
              'color': 'white',
              'text-align': 'center'
            });
            const departmentDiv = $('<ul>').css({
              'border': '3px solid black'
            });

            for (let j = 0; j < departmentList.employee.length; j++) {
              const employee = departmentList.employee[j];

              const div = $('<li>').html(employee.name + "<br>" + employee.jobName);
              departmentDiv.append(div);
            }
            $('#orgChartContainer').append(title, departmentDiv);
          }
        });
      }
</script>
      <script>
        $(document).ready(function() {
          const $orgchartBtn = $('#orgChartBtn');
          const $orgchartMenu = $('.orgchart-menu');
          const $closeOrgchart = $('.close-orgchart');

          // 조직도 버튼 클릭 시 메뉴 토글
          $orgchartBtn.on('click', function(e) {
            e.stopPropagation();
            $orgchartMenu.toggle();

            console.log("1");

            if($orgchartMenu.is(':visible')) {
              //orgChartModal();
            }
          });

          // 닫기 버튼 클릭 시 메뉴 닫기
          $closeOrgchart.on('click', function() {
            $orgchartMenu.hide();
          });

          // 메뉴 영역 외 클릭 시 메뉴 닫기
          $(document).on('click', function(e) {
            if (!$(e.target).closest('.orgchart-container').length) {
              $orgchartMenu.hide();
            }
          });
        });
      </script>
      <script>
        $(document).ready(function () {
          $('#darkModeBtn .material-icons').html(mode == 'light' ? 'dark_mode' : 'light_mode');

          $('#darkModeBtn').on('click', function () {
            if (mode === 'light') {
              mode = 'dark';
              sessionStorage.setItem('mode', 'dark');
              $('html').removeClass('light').addClass('dark');
            } else {
              mode = 'light';
              sessionStorage.setItem('mode', 'light');
              $('html').removeClass('dark').addClass('light');
            }

            $('#darkModeBtn .material-icons').html(mode == 'light' ? 'dark_mode' : 'light_mode');
          })

          // 모바일 메뉴 열기
          $('.open-mobile-menu').click(function(e) {
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
            } else if (id === 'login-history') {
              window.location.href = '/login/history/1';
            }
          });

          $('#notificationBtn').on('click', function(e) {
            e.stopPropagation();
            $('#notificationMenu').toggle(0, function() {
              if($(this).is(':visible')) {
                const notificationList = $('.notification-list');
                notificationList.scrollTop(notificationList[0].scrollHeight);
              }
            });
          });

          $('.close-notification').on('click', function(e) {
            e.stopPropagation();
            $('#notificationMenu').hide();
          });

    $(document).on('click', function(e) {
      if (!$(e.target).closest('.notification-container').length) {
        $('#notificationMenu').hide();
      }
    });
  });
</script>
<script>
          $(document).on('click', function(e) {
            if (!$(e.target).closest('.notification-container').length) {
              $('#notificationMenu').hide();
            }
          });

        $(document).ready(function() {
          $('form').off('submit').on('submit', function(e) {
            console.log('폼 제출 시도');
            // 이벤트 전파 강제
            e.stopPropagation();
            e.preventDefault();

            // 직접 submit 호출
            this.submit();
            // 또는
            // $(this)[0].submit();
          });
        });
</script>

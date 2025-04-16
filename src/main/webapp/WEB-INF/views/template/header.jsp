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
      <div class="menu-item" onClick="location.href='/calendar/list'">
        <i class="material-icons">event_available</i>
        <span>일정/예약</span>
      </div>
      <c:if test="${employee.role eq 'ADMIN' || employee.departmentName eq '인사팀'}">
        <div class="menu-item" onclick="location.href='/hr/list'">
          <i class="material-icons">people</i>
          <span>인사관리</span>
        </div>
      </c:if>
      <div class="menu-item" onClick="location.href='/project/main'">
        <i class="material-icons">description</i>
        <span>Works</span>
      </div>

      <div class="menu-item" onClick="location.href='/contact?page=1'">
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
          <div class="orgchart-menu surface-bright">
            <div class="orgchart-header">
              <h5>조직도</h5>
              <span class="material-icons close-orgchart">close</span>
            </div>
            <div class="orgchart-content"></div>
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
            <a href="/calendar/list">
              <i class="material-icons">event_available</i>
              <span>일정/예약</span>
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
            <a href="/contact?page=1">
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
          $('.orgchart-content').empty();

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
              const orgBox = $('<div>').addClass('org-box');

              const title = $('<div>').addClass('department-title').text(departmentList.name);
              const departmentDiv = $('<div>').addClass('members-tree');

              for (let j = 0; j < departmentList.employee.length; j++) {
                const employee = departmentList.employee[j];

                const div = $('<div>').addClass('member');
                div.append($('<span>').addClass('name').text(employee.name))
                        .append($('<span>').addClass('position').text(employee.jobName));
                departmentDiv.append(div);
              }

              $('.orgchart-content').append(orgBox.append(title, departmentDiv));
            }
          });
        }
      </script>
      <script>
        $(document).ready(function () {
          const $orgchartBtn = $('#orgChartBtn');
          const $orgchartMenu = $('.orgchart-menu');
          const $closeOrgchart = $('.close-orgchart');

          // 조직도 버튼 클릭 시 메뉴 토글
          $orgchartBtn.on('click', function (e) {
            e.stopPropagation();
            $orgchartMenu.toggle();

            if ($orgchartMenu.is(':visible')) {
              orgChartModal();
            }
          });

          // 닫기 버튼 클릭 시 메뉴 닫기
          $closeOrgchart.on('click', function () {
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
              window.location.href = '/login/history?page=1';
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

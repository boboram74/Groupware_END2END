<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="ko">
<head>
  <meta charset="UTF-8" />
  <meta name="viewport" content="width=device-width, initial-scale=1.0" />
  <title>Document</title>
  <link rel="stylesheet" href="https://fonts.googleapis.com/icon?family=Material+Icons"/>
  <link rel="stylesheet" href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined:opsz,wght,FILL,GRAD@24,400,0,0&icon_names=work" />
  <link
          href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css"
          rel="stylesheet"
          integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH"
          crossorigin="anonymous"
  />
  <script src="https://cdn.jsdelivr.net/npm/fullcalendar@6.1.15/index.global.min.js"></script>
  <link rel="stylesheet" href="/css/template/template.css" />
  <script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
  <style>
    * {
      margin: 0;
      padding: 0;
      box-sizing: border-box;
    }

    body {
      padding-bottom: 60px;
    }

    .nav-container {
      display: flex;
      height: 100vh;
    }

    .sidebar {
      width: 60px;
      height: 100%;
      background-color: #1a237e;
      color: white;
      display: flex;
      flex-direction: column;
      align-items: center;
      padding-top: 20px;
      position: fixed;
      z-index: 100;
    }

    .menu-item {
      width: 100%;
      padding: 15px 0;
      display: flex;
      justify-content: center;
      cursor: pointer;
      position: relative;
    }

    .menu-icon {
      font-size: 24px;
      display: block !important;
    }

    .detail-menu {
      position: fixed;
      left: 60px;
      top: 0;
      width: 240px;
      height: 100vh;
      background-color: #283593;
      display: none;
      padding: 20px 0;
      box-shadow: 2px 0 5px rgba(0, 0, 0, 0.2);
      z-index: 200;
    }

    .menu-item:hover {
      background-color: #283593;
    }

    .menu-item:hover .detail-menu {
      display: block;
    }

    .detail-menu-title {
      color: white;
      font-size: 18px;
      padding: 10px 20px;
      border-bottom: 1px solid rgba(255, 255, 255, 0.1);
      margin-bottom: 10px;
    }

    .detail-menu-item {
      padding: 12px 20px;
      color: white;
      text-decoration: none;
      display: block;
      transition: background-color 0.2s;
    }

    .detail-menu-item:hover {
      background-color: #3949ab;
    }

    .mobile-bottom-nav {
      display: none;
      position: fixed;
      bottom: 0;
      left: 0;
      width: 100%;
      height: 60px;
      background-color: #1a237e;
      box-shadow: 0 -2px 10px rgba(0, 0, 0, 0.1);
      z-index: 300;
    }

    .mobile-nav-items {
      display: flex;
      justify-content: space-around;
      align-items: center;
      height: 100%;
    }

    .mobile-nav-item {
      display: flex;
      flex-direction: column;
      align-items: center;
      color: white;
      text-decoration: none;
      font-size: 12px;
      padding: 8px;
      width: 20%;
      text-align: center;
    }

    .mobile-nav-item .material-icons {
      font-size: 24px;
      margin-bottom: 4px;
    }

    .mobile-full-menu {
      display: none;
      position: fixed;
      top: 0;
      left: 0;
      width: 100%;
      height: 100vh;
      background-color: #1a237e;
      z-index: 9999;
    }

    .mobile-menu-header {
      position: fixed;
      top: 0;
      left: 0;
      width: 100%;
      height: 60px;
      background-color: #1a237e;
      padding: 0 20px;
      display: flex;
      justify-content: space-between;
      align-items: center;
      z-index: 10000;
      box-shadow: 0 2px 5px rgba(0, 0, 0, 0.1);
    }

    .mobile-menu-content {
      position: fixed;
      top: 60px;
      left: 0;
      right: 0;
      bottom: 60px;
      overflow-y: auto;
      padding: 20px;
      -webkit-overflow-scrolling: touch;
    }

    .mobile-menu-section {
      margin-bottom: 30px;
      background-color: rgba(255, 255, 255, 0.05);
      border-radius: 8px;
      padding: 15px;
    }

    .mobile-menu-section-title {
      color: white;
      font-size: 18px;
      margin-bottom: 15px;
      padding-bottom: 5px;
      border-bottom: 1px solid rgba(255, 255, 255, 0.1);
    }

    .mobile-menu-item {
      color: white;
      text-decoration: none;
      display: block;
      padding: 12px 0;
      border-bottom: 1px solid rgba(255, 255, 255, 0.05);
    }

    .close-button {
      color: white;
      background: none;
      border: none;
      font-size: 30px;
      cursor: pointer;
      padding: 5px;
    }

    @media (max-width: 576px) {
      .sidebar {
        display: none;
      }

      .mobile-bottom-nav {
        display: block;
      }

      .mobile-full-menu.active {
        display: block;
      }

      body {
        padding-bottom: 60px;
      }
    }
  </style>
</head>
<body>
<div class="nav-container">
  <nav class="sidebar">
    <div class="menu-item">
      <span class="material-icons menu-icon">home</span>
      <div class="detail-menu">
        <h3 class="detail-menu-title">홈</h3>
        <a href="/dashboard" class="detail-menu-item">대시보드</a>
        <a href="/notice" class="detail-menu-item">공지사항</a>
      </div>
    </div>

    <div class="menu-item">
      <span class="material-icons menu-icon">description</span>
      <div class="detail-menu">
        <h3 class="detail-menu-title">게시판</h3>
        <a href="/board/list" class="detail-menu-item">전체 게시판</a>
        <a href="/board/write" class="detail-menu-item">글쓰기</a>
      </div>
    </div>

    <div class="menu-item">
      <span class="material-icons menu-icon">email</span>
      <div class="detail-menu">
        <h3 class="detail-menu-title">메일</h3>
        <a href="/mail/inbox" class="detail-menu-item">받은 메일함</a>
        <a href="/mail/sent" class="detail-menu-item">보낸 메일함</a>
        <a href="/mail/compose" class="detail-menu-item">메일 쓰기</a>
      </div>
    </div>

    <div class="menu-item">
      <span class="material-icons menu-icon">approval</span>
      <div class="detail-menu">
        <h3 class="detail-menu-title">전자결재</h3>
        <a href="/approval/list" class="detail-menu-item">결재 문서함</a>
        <a href="/approval/write" class="detail-menu-item">결재 작성</a>
        <a href="/approval/pending" class="detail-menu-item">결재 대기</a>
      </div>
    </div>

    <div class="menu-item">
      <span class="material-icons menu-icon">work</span>
      <div class="detail-menu">
        <h3 class="detail-menu-title">업무보고</h3>
        <a href="/work/daily" class="detail-menu-item">일일 보고</a>
        <a href="/work/weekly" class="detail-menu-item">주간 보고</a>
        <a href="/work/monthly" class="detail-menu-item">월간 보고</a>
      </div>
    </div>
  </nav>
</div>

<!-- 모바일 메뉴 -->
<div class="mobile-full-menu">
  <div class="mobile-menu-header">
    <h2 style="color: white;">전체 메뉴</h2>
    <button class="close-button">
      <span class="material-icons">close</span>
    </button>
  </div>

  <div class="mobile-menu-content">
    <div class="mobile-menu-section">
      <h3 class="mobile-menu-section-title">홈</h3>
      <a href="/dashboard" class="mobile-menu-item">대시보드</a>
      <a href="/notice" class="mobile-menu-item">공지사항</a>
    </div>

    <div class="mobile-menu-section">
      <h3 class="mobile-menu-section-title">게시판</h3>
      <a href="/board/list" class="mobile-menu-item">전체 게시판</a>
      <a href="/board/write" class="mobile-menu-item">글쓰기</a>
    </div>

    <div class="mobile-menu-section">
      <h3 class="mobile-menu-section-title">메일</h3>
      <a href="/mail/inbox" class="mobile-menu-item">받은 메일함</a>
      <a href="/mail/sent" class="mobile-menu-item">보낸 메일함</a>
      <a href="/mail/compose" class="mobile-menu-item">메일 쓰기</a>
    </div>

    <div class="mobile-menu-section">
      <h3 class="mobile-menu-section-title">전자결재</h3>
      <a href="/approval/list" class="mobile-menu-item">결재 문서함</a>
      <a href="/approval/write" class="mobile-menu-item">결재 작성</a>
      <a href="/approval/pending" class="mobile-menu-item">결재 대기</a>
    </div>

    <div class="mobile-menu-section">
      <h3 class="mobile-menu-section-title">업무보고</h3>
      <a href="/work/daily" class="mobile-menu-item">일일 보고</a>
      <a href="/work/weekly" class="mobile-menu-item">주간 보고</a>
      <a href="/work/monthly" class="mobile-menu-item">월간 보고</a>
    </div>
  </div>
</div>

<nav class="mobile-bottom-nav">
  <div class="mobile-nav-items">
    <a href="/dashboard" class="mobile-nav-item">
      <span class="material-icons">home</span>
      <span>홈</span>
    </a>
    <a href="/board/list" class="mobile-nav-item">
      <span class="material-icons">description</span>
      <span>게시판</span>
    </a>
    <a href="#" class="mobile-nav-item" id="menuButton">
      <span class="material-icons">menu</span>
      <span>메뉴</span>
    </a>
    <a href="/mail/inbox" class="mobile-nav-item">
      <span class="material-icons">email</span>
      <span>메일</span>
    </a>
    <a href="/approval/list" class="mobile-nav-item">
      <span class="material-icons">approval</span>
      <span>결재</span>
    </a>
  </div>
</nav>

<script>
  const menuButton = document.getElementById('menuButton');
  const mobileFullMenu = document.querySelector('.mobile-full-menu');
  const closeButton = document.querySelector('.close-button');

  menuButton.addEventListener('click', (e) => {
    e.preventDefault();
    mobileFullMenu.classList.add('active');
    document.body.style.overflow = 'hidden';
  });

  closeButton.addEventListener('click', () => {
    mobileFullMenu.classList.remove('active');
    document.body.style.overflow = '';
  });

  document.querySelectorAll('.mobile-menu-item').forEach(item => {
    item.addEventListener('click', () => {
      mobileFullMenu.classList.remove('active');
      document.body.style.overflow = '';
    });
  });
</script>
</body>
</html>
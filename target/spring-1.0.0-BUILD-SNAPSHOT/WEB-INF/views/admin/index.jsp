<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<jsp:include page="/WEB-INF/views/template/header.jsp"/>
<link rel="stylesheet" href="https://fonts.googleapis.com/icon?family=Material+Icons"/>
<link rel="stylesheet" href="/css/admin/index.css"/>
<div class="mainHeader surface-bright">
    <div class="detail-menu-header">
      <a href="/admin">
        <div class="detail-menu-title">
        <span class="material-icons">mail</span>
        <span>관리자 페이지</span>
      </div>
      </a>
      <button class="detail-menu-toggle-btn" type="button">
        <span class="material-icons">menu</span>
      </button>
    </div>
  <div class="detail-menu-modal">
    <ul class="detail-menu-list">
      <a href="/admin/department-setting">
        <li class="detail-menu-item">
          <span class="material-icons">star</span>
          <span>부서 관리</span>
        </li>
      </a>
      <a href="/admin/mail-setting">
        <li class="detail-menu-item">
            <span class="material-icons">mail</span>
            <span>공용 메일 설정</span>
        </li>
      </a>
      <a href="/admin/setting">
        <li class="detail-menu-item">
          <span class="material-icons">manage_accounts</span>
          <span>관리자 설정</span>
        </li>
      </a>
    </ul>
    <button class="detail-modal-close">
      <span class="material-icons">close</span>
    </button>
  </div>
</div>

<div class="mainContainer">
  <div class="mainBody">
    <h1>웹서버 모니터링</h1>
    <div class="iframe-grid">
      <div class="iframe-card">
        <iframe src="https://end2end.site:3000/d-solo/eej8u5ls61728a/boram-first?orgId=1&panelId=2&from=now-30m&to=now&theme=light"></iframe>
      </div>
      <div class="iframe-card">
        <iframe src="https://end2end.site:3000/d-solo/eej8u5ls61728a/boram-first?orgId=1&panelId=1&from=now-30m&to=now&theme=light"></iframe>
      </div>
      <div class="iframe-card">
        <iframe src="https://end2end.site:3000/d-solo/eej8u5ls61728a/boram-first?orgId=1&panelId=3&from=now-30m&to=now&theme=light"></iframe>
      </div>
      <div class="iframe-card">
        <iframe src="https://end2end.site:3000/d-solo/eej8u5ls61728a/boram-first?orgId=1&panelId=4&from=now-30m&to=now&theme=light"></iframe>
      </div>
      <div class="iframe-card">
        <iframe src="https://end2end.site:3000/d-solo/eej8u5ls61728a/ec9bb9-ec849c-ebb284?from=1744950629114&to=1744954229115&orgId=1&panelId=5"></iframe>
      </div>
      <div class="iframe-card">
        <iframe src="https://end2end.site:3000/d-solo/eej8u5ls61728a/ec9bb9-ec849c-ebb284?from=1744950681989&to=1744954281989&orgId=1&panelId=6"></iframe>
      </div>
    </div>

    <h1>메일서버 모니터링</h1>
    <div class="iframe-grid">
      <div class="iframe-card">
        <iframe src="https://end2end.site:3000/d-solo/aej92n102uz9ca/eba994-ec9dbc-ec849c-ebb284?orgId=1&from=1744966496210&to=1744988096210&panelId=1"></iframe>
      </div>
      <div class="iframe-card">
        <iframe src="https://end2end.site:3000/d-solo/aej92n102uz9ca/eba994-ec9dbc-ec849c-ebb284?orgId=1&from=1744966529821&to=1744988129821&panelId=2"></iframe>
      </div>
      <div class="iframe-card">
        <iframe src="https://end2end.site:3000/d-solo/aej92n102uz9ca/eba994-ec9dbc-ec849c-ebb284?orgId=1&from=1744930958420&to=1744952558420&panelId=3"></iframe>
      </div>
      <div class="iframe-card">
        <iframe src="https://end2end.site:3000/d-solo/aej92n102uz9ca/eba994-ec9dbc-ec849c-ebb284?orgId=1&from=1744930973543&to=1744952573543&panelId=4"></iframe>
      </div>
      <div class="iframe-card">
        <iframe src="https://end2end.site:3000/d-solo/aej92n102uz9ca/eba994-ec9dbc-ec849c-ebb284?orgId=1&from=1744932910271&to=1744954510271&panelId=5"></iframe>
      </div>
      <div class="iframe-card">
        <iframe src="https://end2end.site:3000/d-solo/aej92n102uz9ca/eba994-ec9dbc-ec849c-ebb284?orgId=1&from=1744932951351&to=1744954551351&panelId=6"></iframe>
      </div>
    </div>
  </div>

  <script>
    $(document).ready(function() {
      $('.detail-menu-item').on('click', function() {
        $('.detail-menu-item').removeClass('active');
        $(this).addClass('active');
        var index = $('.detail-menu-item').index(this);
        localStorage.setItem("activeMenuIndex", index);
      });

      const $menuBtn = $('.detail-menu-toggle-btn');
      const $detailMenuModal = $('.detail-menu-modal');
      const $closeBtn = $('.detail-modal-close');

      $menuBtn.on('click', function() {
        $detailMenuModal.addClass('active');
        $('body').css('overflow', 'hidden');
      });

      $closeBtn.on('click', function() {
        $detailMenuModal.removeClass('active');
        $('body').css('overflow', '');
      });

      $(window).on('click', function(e) {
        if ($(e.target).is($detailMenuModal)) {
          $detailMenuModal.removeClass('active');
          $('body').css('overflow', '');
        }
      });

    });
  </script>
<jsp:include page="/WEB-INF/views/template/footer.jsp"/>
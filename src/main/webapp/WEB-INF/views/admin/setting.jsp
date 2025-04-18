<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<jsp:include page="/WEB-INF/views/template/header.jsp"/>
<link rel="stylesheet" href="https://fonts.googleapis.com/icon?family=Material+Icons"/>
<link rel="stylesheet" href="/css/admin/setting.css"/>
<div class="mainHeader surface-bright">
  <a href="/admin">
    <div class="detail-menu-header">
      <div class="detail-menu-title">
        <span class="material-icons">mail</span>
        <span>관리자 페이지</span>
      </div>
      <button class="detail-menu-toggle-btn">
        <span class="material-icons">menu</span>
      </button>
    </div>
  </a>
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
    <div class="search">
      <div>
        <select id="searchOption">
          <option>선택</option>
          <option>선택</option>
          <option>선택</option>
        </select>
      </div>
      <div class="searchInput">
        <input id="input" type="text" name="keyword" placeholder="검색어 입력">
      </div>
      <div>
        <button id="searchBtn"><span class="material-icons">search</span> 검색</button>
      </div>
    </div>
    <div class="content">
      출력 공간(높이 주지말고 컨텐츠 내용에 따라 유동적으로 증가하게 두세요)
    </div>
    <!-- 배경색 hover 효과 -->
    <button class="primary primary-hover">호버 효과가 있는 기본 버튼</button>
    <div class="primary-container primary-container-hover">호버 효과가 있는 컨테이너</div>

    <!-- 텍스트 hover 효과 -->
    <a class="primary-text primary-text-hover">호버 효과가 있는 링크</a>

    <!-- 여러 효과 조합 -->
    <button class="secondary secondary-hover">
      <span class="primary-text primary-text-hover">혼합된 호버 효과</span>
    </button>
  </div>
  <script>
    $(document).ready(function() {
      $('.detail-menu-item').on('click', function() {
        $('.detail-menu-item').removeClass('active');
        $(this).addClass('active');
        // 클릭 이벤트 처리 로직
      });

      const $menuBtn = $('.detail-menu-toggle-btn');
      const $detailMenuModal = $('.detail-menu-modal');
      const $closeBtn = $('.detail-modal-close');

      // 메뉴 버튼 클릭 시 모달 열기
      $menuBtn.on('click', function() {
        $detailMenuModal.addClass('active');
        $('body').css('overflow', 'hidden');
      });

      // 닫기 버튼 클릭 시 모달 닫기
      $closeBtn.on('click', function() {
        $detailMenuModal.removeClass('active');
        $('body').css('overflow', '');
      });

      // 모달 외부 클릭 시 닫기
      $(window).on('click', function(e) {
        if ($(e.target).is($detailMenuModal)) {
          $detailMenuModal.removeClass('active');
          $('body').css('overflow', '');
        }
      });
    });
  </script>
<jsp:include page="/WEB-INF/views/template/footer.jsp"/>
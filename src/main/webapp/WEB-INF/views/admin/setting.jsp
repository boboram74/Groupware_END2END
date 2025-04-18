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
    <div class="box">
      <div class="box-title">관리자 설정</div>
      <div class="box-content">
        <form id="updateDepartment" action="/admin/updateDepartment" method="post">
          <table class="custom-mail-table department-table">
            <thead>
            <tr>
              <th>ID</th>
              <th>직급</th>
              <th>부서명</th>
              <th>이름</th>
              <th class="col-actions">
                <button type="button" id="addRow" class="btn-icon"><span class="material-icons">add</span>
                </button>
              </th>
            </tr>
            </thead>
            <tbody>
            <tr>
              <td><input type="text" name="deptId" readonly placeholder="자동생성"/></td>
              <td><input type="text" name="deptName" placeholder="부서명 입력" required/></td>
              <td><input type="email" name="deptEmail" placeholder="email@domain.com" required/></td>
              <td class="col-actions">
                <button type="button" class="btn-icon removeRow"><span class="material-icons">remove</span>
                </button>
              </td>
            </tr>
            </tbody>
          </table>
          <div class="button-container">
            <button type="submit" id="saveDepartments" class="primary">저장</button>
          </div>
        </form>
      </div>
    </div>
  </div>
</div>

<%--select--%>
<%--e.role, j.name as jobName, d.name teamName, e.name--%>
<%--from employee e--%>
<%--join department d--%>
<%--on e.departmentid = d.id--%>
<%--join job j--%>
<%--on e.jobid = j.id--%>
<%--order by e.role asc, j.id asc, d.id, e.name asc;--%>

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
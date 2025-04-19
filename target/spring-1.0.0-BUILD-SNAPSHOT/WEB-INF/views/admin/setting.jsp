<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<jsp:include page="/WEB-INF/views/template/header.jsp"/>
<link rel="stylesheet" href="https://fonts.googleapis.com/icon?family=Material+Icons"/>
<link rel="stylesheet" href="/css/admin/setting.css"/>
<div class="mainHeader surface-bright">
  <div class="detail-menu-header">
    <a href="/admin">
      <div class="detail-menu-title">
        <span class="material-icons">mail</span>
        <span>관리자 페이지</span>
      </div>
    </a>
    <button class="detail-menu-toggle-btn">
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
    <div class="box">
      <div class="box-title">사원 권한 관리</div>
      <div class="box-content">
        <form id="updateDepartment" action="/admin/updateDepartment" method="post">
          <table class="custom-mail-table department-table">
            <thead>
            <tr>
              <th>권한</th>
              <th>부서명</th>
              <th>직위</th>
              <th>이름</th>
            </tr>
            </thead>
            <tbody>
            </tbody>
          </table>
        </form>
      </div>
    </div>
  </div>
</div>
  <script>
    $(document).ready(function() {
      $('.detail-menu-item').on('click', function() {
        $('.detail-menu-item').removeClass('active');
        $(this).addClass('active');
      });
      loadSettingList();

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

      $('.custom-mail-table tbody').on('click', '.saveRole', function() {
        const $tr = $(this).closest('tr');
        const employeeId = $tr.data('employeeId');
        const selectedRole = $tr.find('select[name="role"]').val();
        const selectedName = $tr.find('input[name="name"]').val();

        if (confirm(selectedName + "님의 권한을 " + selectedRole + "로 변경하시겠습니까?")) {
          $.ajax({
            url: '/admin/api/updateRole',
            method: 'POST',
            data: {
              employeeId: employeeId,
              role:       selectedRole
            }
          }).done(function (resp) {
            location.reload();
          })
        }
      });
    });

    function loadSettingList() {
      $.ajax({
        url: "/admin/api/loadSettingList"
      }).done(function (resp) {
        var $tbody = $('.custom-mail-table tbody').empty();
        resp.forEach(function (item) {
          var $tr = $('<tr>').attr('data-employee-id', item.employeeId).append(
                  '<td>' +
                    '<select name="role">'+
                      '<option value="ADMIN">ADMIN</option>'+
                      '<option value="NO_AUTH">NO_AUTH</option>'+
                      '<option value="TEAM_LEADER">TEAM_LEADER</option>'+
                      '<option value="USER">USER</option>'+
                    '</select>'+
                  '<button type="button" class="btn-icon saveRole">' +
                  '<span class="material-icons">how_to_reg</span>' +
                  '</button>' +
                  '</td>' +
                  '<td><input type="text" name="teamName" readonly></td>' +
                  '<td><input type="text" name="jobName" readonly></td>' +
                  '<td><input type="text" name="name" readonly></td>' +
                  '</tr>'
          );
          $tr.find('select[name="role"]').val(item.role);
          $tr.find('input[name="teamName"]').val(item.teamName);
          $tr.find('input[name="jobName"]').val(item.jobName);
          $tr.find('input[name="name"]').val(item.name);
          $tbody.append($tr);
        });
      });
    }

  </script>
<jsp:include page="/WEB-INF/views/template/footer.jsp"/>
<%--select--%>
<%--e.role, j.name as jobName, d.name teamName, e.name--%>
<%--from employee e--%>
<%--join department d--%>
<%--on e.departmentid = d.id--%>
<%--join job j--%>
<%--on e.jobid = j.id--%>
<%--order by e.role asc, j.id asc, d.id, e.name asc;--%>
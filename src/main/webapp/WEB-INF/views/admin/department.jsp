<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<jsp:include page="/WEB-INF/views/template/header.jsp"/>
<link rel="stylesheet" href="https://fonts.googleapis.com/icon?family=Material+Icons"/>
<link rel="stylesheet" href="/css/admin/mail.css"/>
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
            <div class="box-title">부서 관리</div>
            <div class="box-content">
                <form id="updateDepartment" action="/admin/updateDepartment" method="post">
                <table class="custom-mail-table department-table">
                    <thead>
                    <tr>
                        <th>ID</th>
                        <th>부서명</th>
                        <th>부서 Email</th>
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
<script>
    $(document).ready(function () {
        loadDepartmentList();

        $('#addRow').on('click', function () {
            var $template = $('.custom-mail-table tbody tr:first');
            var $newRow = $template.clone();
            $newRow.find('input').val('');
            $('.custom-mail-table tbody').append($newRow);
        });

        $(document).on('click', '.removeRow', function () {
            const $row = $(this).closest('tr');
            const id   = $row.find('input[name="deptId"]').val();
            if (!id) {
                return $row.remove();
            }
            if (!confirm("해당 부서를 정말 삭제하시겠습니까?\n(부서 소속 모든 직원 정보도 함께 삭제됩니다.)")) {
                return;
            }
            $.ajax({
                url: '/admin/api/department-delete',
                method: 'POST',
                data: {
                    id: id
                }
            }).done(function () {
                $row.remove();
            });
        });



        $("#updateDepartment").on("submit",function () {

        });

    });

    function loadDepartmentList() {
        $.ajax({
            url: '/admin/api/departmentList',
        }).done(function (resp) {
            console.log(resp);
            var $tbody = $('.custom-mail-table tbody').empty();
            resp.forEach(function (item) {
                var $tr = $(
                    '<tr>' +
                    '<td><input type="text" name="deptId" required></td>' +
                    '<td><input type="text" name="deptName" required></td>' +
                    '<td><input type="email" name="deptEmail" required></td>' +
                    '<td class="col-actions">' +
                    '<button type="button" class="btn-icon removeRow">' +
                    '<span class="material-icons">remove</span>' +
                    '</button>' +
                    '</td>' +
                    '</tr>'
                );
                $tr.find('input[name="deptId"]').val(item.id);
                $tr.find('input[name="deptName"]').val(item.name);
                $tr.find('input[name="deptEmail"]').val(item.email);
                $tbody.append($tr);
            });
        });
    }

</script>
<jsp:include page="/WEB-INF/views/template/footer.jsp"/>
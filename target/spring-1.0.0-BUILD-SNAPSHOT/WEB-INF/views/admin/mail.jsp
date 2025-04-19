<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<jsp:include page="/WEB-INF/views/template/header.jsp"/>
<link rel="stylesheet" href="https://fonts.googleapis.com/icon?family=Material+Icons"/>
<link rel="stylesheet" href="/css/admin/mail.css"/>
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
            <iframe src="https://end2end.site:3000/d-solo/aej92n102uz9ca/eba994-ec9dbc-ec849c-ebb284?orgId=1&from=1744934825076&to=1744956425076&panelId=7"width="100%" height="100%" frameborder="0"></iframe>
        </div>
        <div class="box">
            <div class="box-title">메일 주소 설정</div>
            <div class="box-content">
                <form id="customMailForm" action="/admin/mailAliesUpdate" method="post">
                    <table class="custom-mail-table">
                        <thead>
                        <tr>
                            <th>이메일 주소</th>
                            <th>메일 이름</th>
                            <th>수신자(콤마 구분)</th>
                            <th class="col-actions">
                                <button type="button" id="addRow" class="btn-icon">
                                    <span class="material-icons">add</span>
                                </button>
                            </th>
                        </tr>
                        </thead>
                        <tbody>
                        <tr>
                            <td><input type="email" name="aliases" placeholder="alias@end2end.site" required></td>
                            <td><input type="text" name="aliasNames" placeholder="경영팀" required></td>
                            <td><input type="text" name="recipients" placeholder="user1@,user2@" required></td>
                            <td class="col-actions">
                                <button type="button" class="btn-icon removeRow">
                                    <span class="material-icons">remove</span>
                                </button>
                            </td>
                        </tr>
                        </tbody>
                    </table>
                    <div class="button-container">
                        <button type="submit" class="primary">저장</button>
                    </div>
                </form>
            </div>
        </div>
        <div class="box">
            <div class="box-title">발신 서명</div>
            <div class="box-content">
                <div class="form-row signature-row">
                    <label for="defaultSignature">발신 서명</label>
                    <textarea id="defaultSignature"
                              name="defaultSignature"
                              rows="4"></textarea>
                </div>
                <div class="button-container">
                    <button type="button" class="secondary" id="saveSignature">저장</button>
                </div>
            </div>
        </div>
    </div>
</div>


<script>
    $(document).ready(function () {
        loadServerCapacity();
        loadEmailAliseList();
        loadEmailSignature();

        $('.detail-menu-item').on('click', function () {
            $('.detail-menu-item').removeClass('active');
            $(this).addClass('active');
        });
        const $menuBtn = $('.detail-menu-toggle-btn');
        const $detailMenuModal = $('.detail-menu-modal');
        const $closeBtn = $('.detail-modal-close');

        $menuBtn.on('click', function () {
            $detailMenuModal.addClass('active');
            $('body').css('overflow', 'hidden');
        });

        $closeBtn.on('click', function () {
            $detailMenuModal.removeClass('active');
            $('body').css('overflow', '');
        });

        $(window).on('click', function (e) {
            if ($(e.target).is($detailMenuModal)) {
                $detailMenuModal.removeClass('active');
                $('body').css('overflow', '');
            }
        });
        $('#addRow').on('click', function () {
            var $template = $('.custom-mail-table tbody tr:first');
            var $newRow = $template.clone();
            $newRow.find('input').val('');
            $('.custom-mail-table tbody').append($newRow);
        });
        $(document).on('click', '.removeRow', function () {
            const $row = $(this).closest('tr');
            const alias = $row.find('input[name="aliases"]').val().trim();
            const recipients = $row.find('input[name="recipients"]').val().trim();
            if (!alias) return;
            if (!confirm(alias + ' 주의 : 별칭을 정말 삭제하시겠습니까? 해당 이메일을 사용하는 유저에게는 더이상 수신이 되지 않습니다.')) return;
            $.ajax({
                url: '/admin/api/alies-delete',
                method: 'POST',
                data: {
                    alias: alias,
                    recipients: recipients
                }
            }).done(function () {
                $row.remove();
            });
        });
    });
    function loadServerCapacity() {
        $.ajax({
            url: 'http://34.70.179.192/mail/storage',
            method: 'GET',
            dataType: 'json'
        }).done(function (resp) {
            console.log(resp);
            const totalGb = parseInt(resp.size, 10);
            const pct = parseInt(resp.usePercent, 10);
            const usedGb = Math.round(totalGb * pct / 100);
            $('.usage-bar .used').css('width', '0%');
            setTimeout(function () {
                $('.usage-bar .used').css('width', pct + '%');
            }, 100);
            $('.server-capacity p').text(
                usedGb + 'GB / ' + totalGb + 'GB (' + pct + '% 사용 중)'
            );
        })
    }

    function loadEmailAliseList() {
        $.ajax({
            url: '/admin/api/alies-mapping',
        }).done(function (resp) {
            var $tbody = $('.custom-mail-table tbody').empty();
            resp.forEach(function (item) {
                var $tr = $(
                    '<tr>' +
                    '<td><input type="email" name="aliases" required></td>' +
                    '<td><input type="text" name="aliasNames" required></td>' +
                    '<td><input type="text" name="recipients" required></td>' +
                    '<td class="col-actions">' +
                    '<button type="button" class="btn-icon removeRow">' +
                    '<span class="material-icons">remove</span>' +
                    '</button>' +
                    '</td>' +
                    '</tr>'
                );
                $tr.find('input[name="aliases"]').val(item.aliasAddress);
                $tr.find('input[name="aliasNames"]').val(item.aliasName);
                $tr.find('input[name="recipients"]').val(item.recipientList);
                $tbody.append($tr);
            });
        });
    }

    function loadEmailSignature() {
        $.ajax({
            url: '/admin/api/loadEmailSignature',
        }).done(function (resp) {
            $("#defaultSignature").val(resp);
        });
    }

    $('#customMailForm').on('submit', function (e) {
        let valid = true;
        const aliasInputs = $('input[name="aliases"]');
        const recipientInputs = $('input[name="recipients"]');
        const aliases = $('input[name="aliases"]')
            .map((i, el) => $(el).val().trim())
            .get()
            .filter(v => v !== '');
        const uniq = new Set(aliases);
        if (uniq.size < aliases.length) {
            alert('중복된 별칭 이메일이 있습니다. 동일한 주소는 한 번만 입력하세요.');
            e.preventDefault();
            return;
        }
        aliasInputs.each(function () {
            const email = $(this).val().trim();
            const parts = email.split('@');
            if (parts.length !== 2) {
                alert('별칭 이메일 형식이 올바르지 않습니다: ' + email);
                valid = false;
                return false;
            }
            const domain = parts[1];
            if (/[A-Z]/.test(domain)) {
                alert('도메인 부분에 대문자를 사용할 수 없습니다: ' + domain);
                valid = false;
                return false;
            }
            if (domain !== 'end2end.site') {
                alert('도메인은 반드시 end2end.site 이어야 합니다: ' + email);
                valid = false;
                return false;
            }
        });
        if (!valid) {
            e.preventDefault();
            return;
        }
        const recPattern = /^[^,\s]+@[^,\s]+\.[^,\s]+(,[^,\s]+@[^,\s]+\.[^,\s]+)*$/;
        recipientInputs.each(function () {
            const list = $(this).val().trim();
            if (!recPattern.test(list)) {
                alert('수신자 목록이 올바르지 않습니다. 공백 없이, 쉼표로만 구분해주세요:\n' + list);
                valid = false;
                return false;
            }
        });
        if (!valid) e.preventDefault();
    });

    $('#saveSignature').on('click', function () {
        const newSignature = $('#defaultSignature').val();
        $.ajax({
            url: '/admin/api/saveEmailSignature',
            method: 'POST',
            contentType: 'application/json; charset=UTF-8',
            data: JSON.stringify({ signature: newSignature }),
            dataType: 'json'
        }).done(function () {
            alert('서명이 저장되었습니다.');
            location.reload();
        });
    });
</script>
<jsp:include page="/WEB-INF/views/template/footer.jsp"/>
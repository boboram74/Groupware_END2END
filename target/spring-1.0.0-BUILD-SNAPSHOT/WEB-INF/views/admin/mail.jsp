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
            <a href="/admin/approval-templates">
                <li class="detail-menu-item">
                    <span class="material-icons">all_inbox</span>
                    <span>결재 문서 양식 설정</span>
                </li>
            </a>
            <a href="/admin/mail-setting">
                <li class="detail-menu-item">
                    <span class="material-icons">send</span>
                    <span>공용 메일 설정</span>
                </li>
            </a>
            <a href="/admin/setting">
                <li class="detail-menu-item">
                    <span class="material-icons">send</span>
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
            <div class="box-title">메일서버 용량</div>
            <div class="box-content">
                <div class="server-capacity">
          <span class="usage-bar">
            <span class="used"></span>
          </span>
                    <p></p>
                </div>
            </div>
        </div>
        <div class="box">
            <div class="box-title">커스텀 메일 주소 매핑</div>
            <div class="box-content">
                <form id="customMailForm">
                    <table class="custom-mail-table">
                        <thead>
                        <tr>
                            <th>별칭(From)</th>
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
                            <td><input type="email" name="alias[]" placeholder="alias@end2end.site" required></td>
                            <td><input type="text" name="recipients[]" placeholder="user1@,user2@" required></td>
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
                              rows="4">
─────────────────
END2END | www.end2end.site | 010-8000-2192
Copyright © END2END All rights reserved.</textarea>
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

            setTimeout(function(){
                $('.usage-bar .used').css('width', pct + '%');
            }, 100);

            $('.server-capacity p').text(
                usedGb + 'GB / ' + totalGb + 'GB (' + pct + '% 사용 중)'
            );
        })
    }
</script>
<jsp:include page="/WEB-INF/views/template/footer.jsp"/>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<div id="vacationModal" class="modal">
    <div class="modal-content surface-bright">
        <div class="modal-header">
            <h2>휴가 사용 현황</h2>
            <span class="material-icons" id="vacationModalClose">close</span>
        </div>
        <div class="modal-body">
            <div class="vacation-history">
                <table class="board-table">
                    <thead>
                    <tr>
                        <th>일자</th>
                        <th>구분</th>
                        <th>사용일수</th>
                        <th>사유</th>
                        <th>상태</th>
                        <th>문서</th>
                    </tr>
                    </thead>
                    <tbody class="vacation-history-table-body"></tbody>
                </table>
            </div>
        </div>
    </div>
</div>
<script>
    $('.vacation-list-button').on('click', function() {
        $('#vacationModal').show();

        $({
            url: '/commute/vacation/list/' + ${employee.id},
            type: 'GET'
        }).done(function (data) {
            console.log(data);
            const tbody = $('.vacation-history-table-body');

            data.forEach((item) => {
                const tr = $('<tr>');
                tr.append($('<td>').html());

                tbody.append(tr);
            })
        });
    })

    // X 버튼으로 모달 닫기
    $('#vacationModalClose').on('click', function() {
        $('#vacationModal').hide();
    })
</script>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<style>
    /* 모달 기본 스타일 */
    .modal {
        display: none;
        position: fixed;
        top: 0;
        left: 0;
        width: 100%;
        height: 100%;
        background-color: rgba(0, 0, 0, 0.5);
        z-index: 1000;
    }

    .modal-content {
        position: relative;
        margin: 5% auto;
        width: 80%;
        max-width: 800px;
        border-radius: 12px;
        box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
    }

    .modal-header {
        padding: 20px;
        border-bottom: 1px solid var(--md-sys-color-outline);
        display: flex;
        justify-content: space-between;
        align-items: center;
    }

    .modal-header h2 {
        margin: 0;
        font-size: 1.5rem;
        color: var(--md-sys-color-on-surface);
    }

    #vacationModalClose {
        font-size: 28px;
        font-weight: bold;
        color: var(--md-sys-color-on-surface-variant);
        cursor: pointer;
    }

    #vacationModalClose:hover {
        color: var(--md-sys-color-on-surface);
    }

    .vacation-stat-box h3 {
        margin: 0 0 10px 0;
        font-size: 1rem;
        color: var(--md-sys-color-on-surface-variant);
    }

    /* 휴가 내역 테이블 스타일 */
    .vacation-history {
        padding: 20px;
        border-radius: 8px;
    }

    .vacation-history h3 {
        margin: 0 0 20px 0;
        font-size: 1.2rem;
    }

    .vacation-table {
        width: 100%;
        border-collapse: collapse;
    }

    .vacation-table th,
    .vacation-table td {
        padding: 12px;
        text-align: left;
        border-bottom: 1px solid var(--md-sys-color-outline-variant);
    }

    .vacation-table th {
        background-color: var(--md-sys-color-surface-container-high);
        color: var(--md-sys-color-on-surface);
        font-weight: 600;
    }

    .vacation-table tr:last-child td {
        border-bottom: none;
    }

    .vacation-history-empty {
        height: 100px;
        display: flex;
        justify-content: center;
        align-items: center;
    }

    /* 반응형 스타일 */
    @media (max-width: 768px) {
        .vacation-stats {
            grid-template-columns: 1fr;
            gap: 10px;
        }

        .modal-content {
            width: 95%;
            margin: 10% auto;
        }

        .vacation-table {
            display: block;
            overflow-x: auto;
        }
    }
</style>
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

        $.ajax({
            url: '/commute/vacation/list/' + ${employee.id},
            type: 'GET'
        }).done(function (data) {
            console.log(data);
            const tbody = $('.vacation-history-table-body');

            if (data.length === 0) {
                const tr = $('<tr>').append($('<td colspan="6">')
                    .addClass('vacation-history-empty')
                    .html('휴가 내용이 없습니다.'));

                tbody.append(tr);
                return;
            }

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
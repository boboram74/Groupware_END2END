<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<link rel="stylesheet" href="/css/color/newColor.css" />
<input type="hidden" name="approvalFormId" value="2" />
<div class="approval-document surface-bright">
    <div class="document-header">
        <h1 class="document-title">휴 가 계</h1>
        <div class="approval-section">
            <!-- 결재란 테이블 -->
            <table class="approval-table">
                <tr id="approval-table-header">
                    <th>기안</th>

                </tr>
                <tr class="sign-rows" id="lineBox">
                    <td class="sign-cell">
                        <div class="position">${employee.jobName}</div>
                        <div class="name">${employee.name}</div>
                        <div class="date"></div>
                        <input type="hidden" name="employeeId" value="${employee.id}" />
                    </td>
                </tr>
            </table>
            <button type="button" id="add" class="add-approval primary">결재선 추가</button>
        </div>
    </div>

    <div class="document-info">
        <table class="info-table">
            <tr>
                <th>제목</th>
                <td colspan="3">
                    <input type="text" id="title" name="title" class="doc-title">
                </td>
            </tr>
            <tr>
                <th>기안부서</th>
                <td>${employee.departmentName}</td>
                <th>기안자</th>
                <td>${employee.name}</td>
            </tr>
            <tr>
                <th>기안일자</th>
                <td colspan="3"><span class="date"></span></td>
            </tr>
            <tr>
                <th>종류</th>
                <td colspan="3" class="vacation-select">
                    <div class="vacation-row">
                        <div class="select-item">
                            <input type="radio" name="vacationType" value="ANNUAL" />
                            <label>연차</label>
                            <input type="radio" name="vacationType" value="SICK" />
                            <label>병가</label>
                            <input type="radio" name="vacationType" value="HALF" />
                            <label>반차</label>
                            <input type="radio" name="vacationType" value="LEAVE_EARLY" />
                            <label>조퇴</label>
                        </div>
                        <div class="select-item">
                            <input type="date" name="startDate" class="form-control">
                        </div>
                        <div class="select-item">
                            <select id="annual" class="time" style="display: none;" required>
                                <option value="">선택하십시오</option>
                                <c:forEach begin="1" end="${totalVacationDate}" var="i">
                                    <option value="${i}">${i}일</option>
                                </c:forEach>
                            </select>
                            <select id="half" class="time" style="display: none;" required>
                                <option value="">선택하십시오</option>
                                <c:forEach begin="9" end="18" var="i">
                                    <option value="${i}:00:00">${i}:00</option>
                                </c:forEach>
                            </select>
                        </div>
                    </div>
                </td>
            </tr>
            <tr>
                <td colspan="4" style="padding: 0;">
                    <textarea id="contents"></textarea>
                </td>
            </tr>
        </table>
    </div>

    <div class="document-footer">
        <div class="attachment-section file-input-section">
            <h3>첨부파일</h3>
            <jsp:include page="/WEB-INF/views/template/fileInput.jsp" />
        </div>

        <div class="button-group">
            <button type="submit" id="signOk" class="submit-btn primary">상신하기</button>
            <button type="button" onclick="window.close();" class="cancel-btn secondary">취소</button>
        </div>
    </div>
</div>
<script>
    $('input[name="vacationType"]').on('change', function(e) {
        const type = e.target.value;
        if(type === 'ANNUAL') {
            $('#annual').addClass('active').show().attr('required', true);
            $('#half').removeClass('active').hide().removeAttr('required');
        } else {
            $('#annual').removeClass('active').hide().removeAttr('required');
            $('#half').addClass('active').show().attr('required', true);
        }
    })

    $('.time').on('change', function() {
        console.log("1");
        const type = $('input[name="vacationType"]:checked').val();
        $('input[name="vacationDate"]').val((type === 'ANNUAL') ? $(this).val() : 0.5);
    })
</script>
<style>
    .vacation-select {
        padding: 10px;
        height: 100%;  /* 높이 지정 */
    }

    .vacation-row {
        display: flex;
        align-items: center;
        gap: 10px;  /* 요소들 사이 간격 */
    }

    .select-item {
        display: flex;
        align-items: center;
    }

    .select-item select {
        margin: 0;
    }

    .form-select, .form-control {
        height: 36px;  /* 입력 요소들의 높이 통일 */
        padding: 5px;
        border: 1px solid #ddd;
        border-radius: 4px;
    }
</style>

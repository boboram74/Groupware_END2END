<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<jsp:include page="/WEB-INF/views/template/header.jsp"/>
<link rel="stylesheet" href="/css/template/exam.css" />
<style>
  .approval-list-wrapper {
    display: flex;
    flex-direction: column;
    gap: 20px;
  }

  .writer-info {
    display: flex;
    align-items: center;
    justify-content: center;
    gap: 10px;
  }

  .profile-img {
    width: 30px;
    height: 30px;
    border-radius: 50%;
    background-size: cover;
    background-position: center;
    background-repeat: no-repeat;
    border: 1px solid #eee;
  }

  select {
    padding: 0 8px;  /* 좌우 여백 추가 */
    background-color: var(--md-sys-color-surface-bright);
    color: var(--md-sys-color-surface);
  }

  .modal-overlay {
    position: fixed;
    top: 0;
    left: 0;
    width: 100%;
    height: 100%;
    background-color: rgba(0, 0, 0, 0.5);
    display: none;
    justify-content: center;
    align-items: center;
    z-index: 1000;
  }

  .modal-container {
    background-color: white;
    padding: 20px;
    border-radius: 4px;
    width: 100%;
    max-width: 500px;
    box-shadow: 0 2px 10px rgba(0, 0, 0, 0.2);
    position: relative;
  }

  .form-group {
    display: flex;
    margin-bottom: 15px;
    align-items: center;
  }

  .form-group label {
    width: 80px;
    flex-shrink: 0;
  }

  .form-group select,
  .form-group input[type="text"],
  .form-group input[type="date"] {
    flex-grow: 1;
    padding: 6px 10px;
    border: 1px solid #ccc;
    border-radius: 4px;
  }

  .date-range {
    display: flex;
    align-items: center;
    gap: 5px;
  }

  .radio-group {
    margin-bottom: 15px;
  }

  .radio-group label {
    margin-right: 15px;
  }

</style>
<div class="mainHeader surface-bright">
  <div class="detail-menu-header">
    <div class="detail-menu-title">
      <span class="material-icons">description</span>
      <span>전자 결재</span>
    </div>
    <button class="detail-menu-toggle-btn">
      <span class="material-icons">menu</span>
    </button>
  </div>
  <div class="detail-menu-modal">
    <ul class="detail-menu-list">
      <li class="detail-menu-item" onclick="location.href='/approval/list'">
        <span class="material-icons">person</span>
        <span>나의 전자결재</span>
      </li>
      <li class="detail-menu-item" onclick="location.href='/approval/important'">
        <span class="material-icons">star</span>
        <span>중요 문서함</span>
        <span class="detail-badge"><span>1</span></span>
      </li>
      <c:if test="${team}">
        <li class="detail-menu-item" onclick="location.href='/approval/all'">
          <span class="material-icons">description</span>
          <span class="detail-menu-disc">모든 전자 결재함</span>
          <span class="detail-badge"><span>1</span></span>
        </li>
      </c:if>
    </ul>
    <button class="detail-modal-close">
      <span class="material-icons">close</span>
    </button>
  </div>
</div>
<div class="mainContainer">
  <div class="mainBody">
    <div class="button-container">
      <select class="apBtnNewDoc">
        <option>새 기안 쓰기</option>
        <c:forEach var="form" items="${formList}">
          <option value="${form.id}">${form.name}</option>
        </c:forEach>
      </select>
    </div>
    <div class="approval-list-wrapper">
      <div class="box surface-bright">
        <div class="box-title">
          결재 대기 중
        </div>
        <div class="box-content">
          <table class="board-table">
            <thead>
            <tr>
              <th class="apColStar"></th>
              <th class="apColTitle">제목</th>
              <th class="apColStatus">결재 상태</th>
              <th class="apColWriter">기안자</th>
              <th class="apColDate">기안일</th>
              <th class="apColType">문서 종류</th>
            </tr>
            </thead>
            <tbody>
            <c:choose>
              <c:when test="${empty waitingList}">
                <tr>
                  <td colspan="6" class="emptyMessage">대기 중인 문서가 없습니다.</td>
                </tr>
              </c:when>
              <c:otherwise>
                <c:forEach var="i" items="${waitingList}">
                  <tr>
                    <td class="apColStar" onclick="remove('${i.ID}')" style="cursor:pointer;">★</td>
                    <td class="apColTitle title" onClick="location.href='/approval/detail/${i.ID}'">${i.TITLE}</td>
                    <td class="apColStatus">결재 대기중</td>
                    <td class="apColWriter writer-info">
                      <div class="profile-img" style="background-image: url('${i.PROFILEIMG}')"></div>
                      <span>${i.DRAFTERNAME}</span>
                    </td>
                    <td class="apColDate">${i.REGDATE}</td>
                    <td class="apColType">${i.FORMNAME}</td>
                  </tr>
                </c:forEach>
              </c:otherwise>
            </c:choose>
            </tbody>
          </table>
        </div>
      </div>
      <div class="box surface-bright">
        <div class="box-title">
          결재 진행 중
        </div>
        <div class="box-content">
          <table class="board-table">
            <thead>
            <tr>
              <th class="apColStar"></th>
              <th class="apColTitle">제목</th>
              <th class="apColStatus">결재 상태</th>
              <th class="apColWriter">기안자</th>
              <th class="apColDate">기안일</th>
              <th class="apColType">문서 종류</th>
            </tr>
            </thead>
            <tbody>
            <c:choose>
              <c:when test="${empty goingList}">
                <tr>
                  <td colspan="6" class="emptyMessage">진행 중인 문서가 없습니다.</td>
                </tr>
              </c:when>
              <c:otherwise>
                <c:forEach var="i" items="${goingList}">
                  <tr>
                    <td class="apColStar" onclick="remove('${i.ID}')" style="cursor:pointer;">★</td>
                    <td class="apColTitle title" onClick="location.href='/approval/detail/${i.ID}'">${i.TITLE}</td>
                    <td class="apColStatus">결재 진행중</td>
                    <td class="apColWriter writer-info">
                      <div class="profile-img" style="background-image: url('${i.PROFILEIMG}')"></div>
                      <span>${i.DRAFTERNAME}</span>
                    </td>
                    <td class="apColDate">${i.REGDATE}</td>
                    <td class="apColType">${i.FORMNAME}</td>
                  </tr>
                </c:forEach>
              </c:otherwise>
            </c:choose>
            </tbody>
          </table>
        </div>
      </div>
      <div class="box surface-bright">
        <div class="box-title">
          결재 완료
        </div>
        <div class="box-content">
          <table class="board-table">
            <thead>
            <tr>
              <th class="apColStar"></th>
              <th class="apColTitle">제목</th>
              <th class="apColStatus">결재 상태</th>
              <th class="apColWriter">기안자</th>
              <th class="apColDate">기안일</th>
              <th class="apColType">문서 종류</th>
            </tr>
            </thead>
            <tbody>
            <c:choose>
              <c:when test="${empty completedList}">
                <tr>
                  <td colspan="6" class="emptyMessage">완료된 문서가 없습니다.</td>
                </tr>
              </c:when>
              <c:otherwise>
                <c:forEach var="i" items="${completedList}">
                  <tr>
                    <td class="apColStar" onclick="remove('${i.ID}')" style="cursor:pointer;">★</td>
                    <td class="apColTitle" onClick="location.href='/approval/detail/${i.ID}'">${i.TITLE}</td>
                    <td class="apColStatus">결재 완료</td>
                    <td class="apColWriter writer-info">
                      <div class="profile-img" style="background-image: url('${i.PROFILEIMG}')"></div>
                      <span>${i.DRAFTERNAME}</span>
                    </td>
                    <td class="apColDate">${i.REGDATE}</td>
                    <td class="apColType">${i.FORMNAME}</td>
                  </tr>
                </c:forEach>
              </c:otherwise>
            </c:choose>
            </tbody>
          </table>
        </div>
      </div>
      <div class="box surface-bright">
        <div class="box-title">
          반려 문서
        </div>
        <div class="box-content">
          <table class="board-table">
            <thead>
            <tr>
              <th class="apColStar"></th>
              <th class="apColTitle">제목</th>
              <th class="apColStatus">결재 상태</th>
              <th class="apColWriter">기안자</th>
              <th class="apColDate">기안일</th>
              <th class="apColType">문서 종류</th>
            </tr>
            </thead>
            <tbody>
            <c:choose>
              <c:when test="${empty rejectList}">
                <tr>
                  <td colspan="6" class="emptyMessage">반려된 문서가 없습니다.</td>
                </tr>
              </c:when>
              <c:otherwise>
                <c:forEach var="i" items="${rejectList}">
                  <tr>
                    <td class="apColStar" onclick="remove('${i.ID}')" style="cursor:pointer;">★</td>
                    <td class="apColTitle title" onClick="location.href='/approval/detail/${i.ID}'">${i.TITLE}</td>
                    <td class="apColStatus">반려</td>
                    <td class="apColWriter writer-info">
                      <div class="profile-img" style="background-image: url('${i.PROFILEIMG}')"></div>
                      <span>${i.DRAFTERNAME}</span>
                    </td>
                    <td class="apColDate">${i.REGDATE}</td>
                    <td class="apColType">${i.FORMNAME}</td>
                  </tr>
                </c:forEach>
              </c:otherwise>
            </c:choose>
            </tbody>
          </table>
        </div>
      </div>
    </div>
  </div>
</div>
<script>

  $(".apBtnNewDoc").on("change", function () {
    let selectDoc = $(this).val();
    if (selectDoc) {
      let url = "/approval/write/" + selectDoc;
      window.open(url, "new", "width=1000,height=1000");
    }
  });

  function remove(approvalId) {// approvalId가 제대로 전달되는지 확인

    const employeeId = '${employeeId}';

    $.ajax({
      url: '/approval/removeImportant',
      method: 'POST',
      contentType: 'application/json',
      data: JSON.stringify({
        approvalId: approvalId,
        employeeId: employeeId,
        leaderCheckYn: 'N'
      }),
      success: function(response) {
        alert("중요 문서에서 취소되었습니다!");
        location.reload();
      },
      error: function(xhr, status, error) {
        console.error('Error:', error);
        alert("취소 중 오류가 발생했습니다.");
      }
    });
  }
</script>
<jsp:include page="/WEB-INF/views/template/footer.jsp"/>

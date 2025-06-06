<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<jsp:include page="/WEB-INF/views/template/header.jsp"/>
<link rel="stylesheet" href="/css/main/mypage.css">
<link rel="stylesheet" href="https://fonts.googleapis.com/icon?family=Material+Icons"/>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>

<script>
    let isHR = ("<c:out value='${sessionScope.employee.departmentName}'/>" === "인사팀") ||
        ("<c:out value='${sessionScope.employee.role}'/>" === "ADMIN");
</script>

<div class="mainContainer">
    <div class="mainHeader">
        <div class="title">
            <h2><span class="material-icons">supervisor_account</span>${employeeDetail.name} ${employeeDetail.jobName}님의 마이페이지</h2>
        </div>
    </div>
    <div class="mainBody">
        <form action="/hr/update" method="post" id="frm">
            <input type="hidden" name="id" value="${employeeDetail.id}" />
            <div class="content">
                <div class="leftPage">
                    <div class="hrProfile">
                        <label for="profileInput" style="cursor: pointer;">
                            <img id="profilePreview" src="${empty employeeDetail.profileImg ? '/image/defaultImg.jpg' : employeeDetail.profileImg}" alt="프로필 이미지">
                            <span class="material-icons">add_a_photo</span>
                        </label>
                        <input type="file" id="profileInput" name="file" accept="image/*" style="display: none;">
                        <input type="hidden" name="profileImg" value="${empty employeeDetail.profileImg ? '/image/defaultImg.jpg' : employeeDetail.profileImg}"/>
                    </div>
                <div class="name">
                    <label>이름</label>
                    <span id="nameText">${employeeDetail.name}</span>
                    <c:if test="${sessionScope.employee.departmentName eq '인사팀' or sessionScope.employee.role eq 'ADMIN'}">
                        <input type="text" id="nameInput" name="name" value="${employeeDetail.name}" style="display:none;" />
                    </c:if>
                    <c:if test="${!(sessionScope.employee.departmentName eq '인사팀' or sessionScope.employee.role eq 'ADMIN')}">
                        <input type="hidden" name="name" value="${employeeDetail.name}" />
                    </c:if>
                </div>
                <div class="contact">
                    <label>연락처</label>
                    <span id="contactText">${employeeDetail.contact}</span>
                    <c:if test="${sessionScope.employee.departmentName eq '인사팀' or sessionScope.employee.role eq 'ADMIN'}">
                        <input type="text" id="contactInput" name="contact" value="${employeeDetail.contact}" style="display:none;" />
                    </c:if>
                    <c:if test="${!(sessionScope.employee.departmentName eq '인사팀' or sessionScope.employee.role eq 'ADMIN')}">
                        <input type="hidden" name="contact" value="${employeeDetail.contact}" />
                    </c:if>
                </div>
                <div class="birthday">
                    <label>생년월일</label>
                    <span id="birthdayText">${employeeDetail.birthday}</span>
                </div>
            </div>
            <div class="rightPage">
                <div class="position">
                    <label>직급</label>
                    <span id="positionText">${employeeDetail.jobName}</span>
                    <c:if test="${sessionScope.employee.departmentName eq '인사팀' or sessionScope.employee.role eq 'ADMIN'}">
                        <select name="jobId" id="positionInput" style="display:none;">
                            <c:forEach var="job" items="${jobList}">
                                <option value="${job.id}"
                                        <c:if test="${job.id == employeeDetail.jobId}">selected</c:if>>
                                        ${job.name}
                                </option>
                            </c:forEach>
                        </select>
                    </c:if>
                    <c:if test="${!(sessionScope.employee.departmentName eq '인사팀' or sessionScope.employee.role eq 'ADMIN')}">
                        <input type="hidden" name="jobId" value="${employeeDetail.jobId}" />
                    </c:if>
                </div>
                <div class="department">
                    <label>부서</label>
                    <span id="departmentText">${employeeDetail.departmentName}</span>
                    <c:if test="${sessionScope.employee.departmentName eq '인사팀' or sessionScope.employee.role eq 'ADMIN'}">
                        <select name="departmentId" id="departmentInput" style="display:none;">
                            <c:forEach var="dept" items="${departmentList}">
                                <option value="${dept.id}" <c:if test="${dept.id == employeeDetail.departmentId}">selected</c:if>>
                                        ${dept.name}
                                </option>
                            </c:forEach>
                        </select>
                    </c:if>
                    <c:if test="${!(sessionScope.employee.departmentName eq '인사팀' or sessionScope.employee.role eq 'ADMIN')}">
                        <input type="hidden" name="departmentId" value="${employeeDetail.departmentId}" />
                    </c:if>
                </div>
                <div class="email">
                    <label>이메일</label>
                    <span id="emailText">${employeeDetail.email}</span>
                </div>

                <div class="postCode">
                    <label>우편 번호</label>
                    <span id="zipCodeText">${employeeDetail.postCode}</span>
                    <input type="text" id="zipCodeInput" name="postCode" value="${employeeDetail.postCode}" style="display:none;" />
                    <button type="button" id="searchAddressBtn" style="display:none;">주소검색</button>
                </div>
                <div class="address">
                    <label>주소</label>
                    <span id="addressText">${employeeDetail.address}</span>
                    <input type="text" id="addressInput" name="address" value="${employeeDetail.address}" style="display:none;" readonly />
                </div>
                <div class="detailAddress">
                    <label>상세 주소</label>
                    <span id="detailAddressText">${employeeDetail.detailAddress}</span>
                    <input type="text" id="detailAddressInput" name="detailAddress" value="${employeeDetail.detailAddress}" style="display:none;" />
                </div>
                <div class="btn">
                    <button type="button" id="changePwBtn">패스워드 변경</button>
                    <button type="button" id="editBtn">수정하기</button>
                    <button type="submit" id="saveBtn" style="display:none;">수정완료</button>
                    <button type="button" id="backBtn">메인으로</button>
                    <button type="button" id="cancelBtn" style="display:none;">수정취소</button>
                </div>
            </div>
        </form>
    </div>
</div>

<script src="/js/main/mypage.js" type="text/javascript"></script>
<jsp:include page="/WEB-INF/views/template/footer.jsp"/>

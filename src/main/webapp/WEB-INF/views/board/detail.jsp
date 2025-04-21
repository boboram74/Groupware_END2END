<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<jsp:include page="/WEB-INF/views/board/board-header.jsp"/>
<script src="https://cdn.jsdelivr.net/npm/@joeattardi/emoji-button@3.0.3/dist/index.min.js"></script>
<style>
    /* 게시글 테이블 스타일 */
    table {
        width: 100%;
        border-collapse: collapse;
        border-top: 1px solid var(--md-sys-color-primary);
        border-bottom: 1px solid var(--md-sys-color-primary);
        color: var(--md-sys-color-surface);
        margin-bottom: 30px;
    }

    th, td {
        padding: 15px;
        text-align: left;
        border-bottom: 1px solid #eee;
    }

    .addReply {
        display: flex;
        gap: 10px;
    }

    .addInput {
        flex: 1;
    }

    .addInput input {
        width: 100%;
        padding: 12px;
        border: 1px solid var(--md-sys-color-outline);
        background-color:  rgba(255, 255, 255, 0.1);
        color: var(--md-sys-color-surface);
        height: 100%;
        border-radius: 4px;
        font-size: 14px;
    }

    .addBtn {
        display: flex;
        flex-direction: column;
        gap: 5px;
    }

    /* 댓글 목록 스타일 */
    .replyList {
        display: flex;
        align-items: flex-start;
        padding: 15px;
        margin-bottom: 15px;
        border-top: 1px solid var(--md-sys-color-outline);
        border-radius: 4px;
        gap: 20px;
    }

    .profile {
        width: 50px;
        height: 50px;
        border-radius: 50%;
        background-size: cover;
        background-position: center;
    }

    .replyWrite {
        flex: 1;
    }

    .writerSysdate {
        margin-bottom: 10px;
    }

    .realContents {
        display: flex;
        flex-direction: column;
        gap: 5px;
    }

    .realContents input[readonly] {
        border: none;
        background: transparent;
        padding: 0;
    }

    .realContents input[readonly]:first-child {
        font-weight: bold;
    }

    .realContents input[readonly]:last-child {
        font-size: 0.9em;
    }


    .realContents input {
        border: none;
        background: transparent;
        font-weight: 600;
        color: var(--md-sys-color-surface);
    }

    .inputReply {
        margin-top: 8px;
    }

    .inputReply input {
        width: 100%;
        border: none;
        background: transparent;
        color: var(--md-sys-color-surface);
    }

    .replyReport button {
        padding: 6px 12px;
        border: 1px solid #ddd;
        border-radius: 4px;
        cursor: pointer;
    }

    .replyReport button:hover {
        opacity: 0.9;
    }

    /* 댓글 입력 폼 스타일 */
    .replyContainer {
        border: 1px solid var(--md-sys-color-outline);
        background-color: var(--md-sys-color-surface-bright);
        padding: 20px;
        margin-bottom: 30px;
    }

    .addReply {
        display: flex;
        gap: 10px;
    }

    .addInput {
        flex: 1;
    }

    .addInput input {
        width: 100%;
        padding: 12px;
        border: 1px solid var(--md-sys-color-outline-variant);
        border-radius: 4px;
        font-size: 14px;
    }

    .addBtn {
        display: flex;
        flex-direction: column;
        gap: 5px;
    }

    .addBtn button {
        padding: 10px 20px;
        border: 1px solid var(--md-sys-color-outline);
        border-radius: 4px;
        cursor: pointer;
        transition: background-color 0.2s;
    }

    /* 상단 메타 정보 스타일 */
    .meta-info {
        font-size: 1em;  /* 폰트 사이즈 증가 */
        color: #666;     /* 색상을 좀 더 진하게 */
        text-align: right;
        padding: 8px 10px;
        width: 30%;      /* 전체 너비 30%로 설정 */
        float: right;    /* 우측 정렬 */
        margin-top: 5px; /* 상단 여백 추가 */
    }

    .meta-info span {
        margin-left: 20px;  /* 간격 증가 */
        display: inline-block;
    }

    /* 제목 컨테이너 스타일 추가 */
    .title-container {
        display: flex;
        justify-content: space-between;
        align-items: center;
        width: 100%;
    }

    .title-text {
        flex: 1;       /* 나머지 공간 차지 */
        padding-right: 20px;  /* 메타 정보와의 간격 */
    }

    /* 테이블 스타일 수정 */
    .label {
        background-color: var(--md-sys-color-surface-container);
        width: 15%;
        font-weight: 600;
    }

    .contents {
        width: 85%;  /* 너비 수정 */
    }

    .btnGroup {
        margin-top: 10px;
        text-align: center;
        display: flex;
    }

    .editBtn, .deleteBtn, .replyBtn, .backBtn {
        padding: 6px 12px;
        margin: 0 2px;
        border: 1px solid var(--md-sys-color-outline);
        cursor: pointer;
    }

    /* 내용란 스타일 */
    .board-detail-content {  /* 클래스 이름 변경 */
        min-height: 500px;
        padding: 20px;
        line-height: 1.6;
    }

    .replyListContainer {
        border-top: 1px solid var(--md-sys-color-primary);
    }
</style>
<table>
    <tr>
        <c:choose>
            <c:when test="${empty active}">
                <td class="label">제목</td>
                <td class="contents" colspan="3">
                    <div class="title-container">
                        <div class="title-text">${board.title}</div>
                        <div class="meta-info">
                            <span>조회 ${board.viewCount}</span>
                            <span>${board.regDate}</span>
                        </div>
                    </div>
                </td>
            </c:when>
            <c:otherwise>
                <td class="label">제목</td>
                <td class="contents" style="${active == null ? '' : 'width: 60%;'}"}>${board.title}</td>
                <td class="label">분류</td>
                <td class="date">${board.noticeCtName}</td>
            </c:otherwise>
        </c:choose>
    </tr>
    <tr>
        <td class="label">작성자</td>
        <c:choose>
            <c:when test="${empty active}">
                <td class="contents">${board.employeeName}</td>
            </c:when>
            <c:otherwise>
                <td colspan="3">관리자</td>
            </c:otherwise>
        </c:choose>
    </tr>
    <tr>
        <td class="board-detail-content" colspan="6">${board.content}</td>
    </tr>
    <tr>
        <td class="label">첨부파일</td>
        <td colspan="3">
            <c:forEach var="file" items="${fileList}">
                <div class="file-list-item">
                    <a href="/file/download?path=${file.path}">${file.originFileName}</a>
                </div>
            </c:forEach>
        </td>
    </tr>
</table>
<div class="btnGroup">
    <button class="backBtn secondary" onclick=location.href='/notice/list'>목록</button>
    <c:choose>
        <c:when test="${empty active}">
            <c:if test="${not empty employee and employee.id eq board.employeeId}">
                <a href="/board/write/update?id=${board.id}">
                    <button type="button" class="editBtn primary">수정</button>
                </a>
                <form action="/board/delete" method="post">
                    <input type="hidden" name="id" value="${board.id}"/>
                    <button type="submit" class="deleteBtn secondary">삭제</button>
                </form>
            </c:if>
        </c:when>
        <c:otherwise>
            <c:if test="${employee.role eq 'ADMIN'}">
                <button type="button" class="editBtn primary" onclick="location.href='/notice/write/update/${board.id}'">수정</button>
                <button type="submit" class="deleteBtn secondary" onclick="
                    if (confirm('정말 삭제하시겠습니까?')) {
                        alert('삭제되었습니다.');
                        location.href='/notice/delete/${board.id}'
                    }">삭제</button>
            </c:if>
        </c:otherwise>
    </c:choose>
</div>

<hr>
<c:if test="${empty active}">
    <input type="hidden" id="loginUserId" value="${employee.id}"/>
    <form id="replyForm" enctype="multipart/form-data">
        <div class="replyContainer">
            <div class="addReply">
                <div class="addInput">
                    <input type="text" id="content" placeholder="댓글 입력">
                </div>
                <div class="addBtn">
                    <button id="addButton" class="primary">등록</button>
                    <button class="button" type="button" id="emojiBtn">😀</button>
                </div>
                <div class="emoticons">
                    <div class="emoticon">
                    </div>
                </div>
            </div>
        </div>
    </form>

    <h3 style="color: var(--md-sys-color-primary);">댓글</h3>
    <div class="replyListContainer"></div>

    <script>
        const button = document.querySelector("#emojiBtn");
        const picker = new EmojiButton({
            i18n: {
                search: 'Search emojis...',
                categories: {
                    recents: 'Recent Emojis',
                    smileys: 'Smileys & Emotion',
                    people: 'People & Body',
                    animals: 'Animals & Nature',
                    food: 'Food & Drink',
                    activities: 'Activities',
                    travel: 'Travel & Places',
                    objects: 'Objects',
                    flags: 'Flags'
                },
                notFound: 'No emojis found'
            },
            showSearch: false,
            autoFocusSearch: false,
            position: 'bottom-start'
        });

        button.addEventListener('click', () => {
            picker.togglePicker(button);
        });

        picker.on('emoji', emoji => {
            const text_box = document.querySelector('#content');
            text_box.value += emoji;
        });

        $(".deleteBtn").on("click", function (e) {
            if (!confirm("정말 삭제하시겠습니까?")) {
                e.preventDefault();
            }
        })
        $("#replyForm").on("submit", function (e) {
            e.preventDefault();
            addContent();
        })

        $(document).on("click", ".deleteReplyBtn", function () {
            const replyId = $(this).data("id");
            const employeeId = String($('#loginUserId').val());
            const replyEmployeeId = String($(this).data("employeeId"));
            if (employeeId !== replyEmployeeId) {
                alert("다른 게시물은 삭제 할 수 없습니다.");
            }

            if (employeeId === replyEmployeeId && confirm("정말 삭제하시겠습니까?")) {
                $.ajax({
                    type: "GET",
                    url: "/reply/delete/" + replyId,
                    success: function (response) {
                        response = JSON.parse(response)

                        if (response) {
                            loadReplies(); // 댓글 다시 불러오기
                        } else {
                            alert("삭제 실패했습니다.");
                        }
                    },
                    error: function () {
                        console.log("댓글 삭제 실패");
                    }
                });
            }
        });

        const addContent = () => {
            const content = document.getElementById("content").value;
            const board = '${board.id}';
            const employee = '${employee.id}';

            const formData = new FormData();
            formData.append("content", content);
            formData.append("boardId", board);
            formData.append("employeeId", employee);

            $.ajax({
                type: "post",
                url: "/reply/insert",
                data: formData,
                contentType: false,
                processData: false,
                success: function (response) {
                    loadReplies();
                    document.getElementById("content").value = ""; // 입력창 초기화

                },
                error: function (status, request, error) {
                    console.log("실패");
                    console.log(request.status);
                    console.log(error);
                    console.log("상태:", status);
                    console.log("요청:", request);
                    console.log("오류:", error);
                }
            });
        }

        const loadReplies = () => {
            const boardId = '${board.id}';
            $.ajax({
                type: "get",
                url: "/reply/list",
                data: {boardId: boardId},
                success: function (replyList) {
                    $(".replyListContainer").empty();
                    replyList.forEach(reply => {
                        const $replyDiv = $('<div class="replyList">')
                            .append(
                                $('<div class="profile" style="background-image: url(' + reply.profileImg + ')">'))
                            .append(
                                $('<div class="replyWrite">')
                                    .append(
                                        $('<div class="writerSysdate">')
                                            .append(
                                                $('<div class="realContents">')
                                                    .append($('<input type="text" readonly>').val(reply.employeeName))
                                                    .append($('<input type="text" readonly>').val(reply.regDate))
                                            )
                                    )
                                    .append(
                                        $('<div class="inputReply">')
                                            .append($('<input type="text" readonly>').val(reply.content))
                                    )
                            )
                            .append(
                                $('<div class="replyReport">')
                                    .append(
                                        $('<div class="reReply">')
                                            .append($('<button>').addClass('deleteReplyBtn secondary').text('삭제').attr('data-id', reply.id).attr('data-employee-id', reply.employeeId))
                                    )
                            );
                        $('.replyListContainer').append($replyDiv);
                    });
                },
                error: function () {
                    console.log("실패");
                }
            });


        };
        // 페이지 로드 시 댓글 목록 불러오기
        $(document).ready(function () {
            loadReplies();
        });
    </script>
</c:if>
<script src="/js/main/contact.js" type="text/javascript"></script>
<jsp:include page="/WEB-INF/views/board/board-footer.jsp"/>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<jsp:include page="/WEB-INF/views/board/board-header.jsp"/>
<script src="https://cdn.jsdelivr.net/npm/@joeattardi/emoji-button@3.0.3/dist/index.min.js"></script>
<style>
    table {
        width: 100%;
        border-collapse: collapse;
        border-top: 1px solid #ccc;
        border-bottom: 1px solid #ccc;

    }

    th, td {
        padding: 8px;
        text-align: left;
        border-bottom: 1px solid #ddd;
    }

    .label {
        background-color: #f8f8f8;
        width: 15%;
        border-right: 1px solid #ddd;
    }

    .contents {
        width: 60%;
    }

    .meta {
        width: 15%;
        text-align: center;
        border-left: 1px solid #ddd;
    }

    .date {
        width: 20%;
        text-align: center;
        border-left: 1px solid #ddd;
    }

    .btnGroup {
        margin-top: 10px;
        text-align: center;
        display: flex;
    }

    .editBtn, .deleteBtn, .replyBtn, .backBtn {
        padding: 6px 12px;
        margin: 0 2px;
        border: 1px solid #ccc;
        background-color: white;
        cursor: pointer;
    }

    .editBtn {
        background-color: #f8f8f8;
        color: #333;
    }

    .deleteBtn {
        background-color: #f8f8f8;
        color: #333;
    }

    .replyBtn {
        background-color: #f8f8f8;
        color: #333;
    }

    .backBtn {
        background-color: #f8f8f8;
        color: #333;
    }

    /*----------------버-------------------*/
    .replyContainer {
        border: 1px solid black;
        width: 100%;
        height: 120px;
    }

    .addReply {
        width: 100%;
        height: 100%;
        display: flex;
    }

    .addInput {
        width: 95%;
        height: 100%;
    }

    .addInput input {
        width: 100%;
        height: 100%;
    }

    .addBtn {
        width: 5%;
        height: 100%;
    }

    .addBtn button {
        width: 100%;
        height: 50%;
    }

    .replyList {
        width: 100%;
        height: 120px;
        border: 1px solid black;
        display: flex;
    }

    .profile {
        width: 10%;
        height: 100%;
        border: 1px solid black;
    }

    .replyWrite {
        width: 85%;
        height: 100%;
    }

    .writerSysdate {
        width: 100%;
        height: 23%;
    }

    .realContents {
        width: 30%;
        height: 100%;
        display: flex;
    }

    .realContents input {
        width: 50%;
        height: 100%;
    }

    .inputReply {
        width: 100%;
        height: 77%;
    }

    .inputReply input {
        width: 100%;
        height: 100%;
    }

    .replyReport {
        width: 5%;
        height: 100%;
        display: flow;
    }

    .reReply {
        width: 100%;
        height: 100%;
    }

    .reReply button {
        width: 100%;
        height: 100%;
    }

    .report {
        width: 100%;
        height: 50%;
    }

    .report button {
        width: 100%;
        height: 100%;
    }

    .board-content>td {
        min-height: 500px;
    }

</style>
<div class="content">

</div>

<table>

    <tr>
        <c:choose>
            <c:when test="${empty active}">
                <td class="label">제목</td>
                <td class="contents">${board.title}</td>
                <td class="meta">조회</td>
                <td class="date">${board.viewCount}</td>
            </c:when>
            <c:otherwise>
                <td class="label">제목</td>
                <td class="contents">${board.title}</td>
                <td class="meta">분류</td>
                <td class="date">${board.noticeCtName}</td>
            </c:otherwise>
        </c:choose>
    </tr>
    <tr>
        <td class="label">작성자</td>
        <c:choose>
            <c:when test="${empty active}">
                <td colspan="3">${board.employeeName}</td>
            </c:when>
            <c:otherwise>
                <td colspan="3">관리자</td>
            </c:otherwise>
        </c:choose>
    </tr>
    <tr>
         <td class="label"> 내용
        <td colspan="4">${board.content}</td>
    </tr>
    <c:forEach var="file" items="${fileList}">
        <tr>
            <td class="label">첨부파일</td>
            <td colspan="3">
                <c:forEach var="file" items="${fileList}">
                    <a href="/file/download?path=${file.path}">${file.originFileName}</a>
                </c:forEach>
            </td>
        </tr>
    </c:forEach>
</table>
<div class="btnGroup">
    <button class="backBtn" onclick="window.history.back()">목록</button>
    <c:choose>
        <c:when test="${empty active}">
            <c:if test="${not empty employee and employee.id eq board.employeeId}">
                <a href="/board/write/update?id=${board.id}">
                    <button type="button" class="editBtn">수정</button>
                </a>
                <form action="/board/delete" method="post">
                    <input type="hidden" name="id" value="${board.id}"/>
                    <button type="submit" class="deleteBtn">삭제</button>
                </form>
            </c:if>
        </c:when>
        <c:otherwise>
            <c:if test="${employee.role eq 'ADMIN'}">
                <button type="button" class="editBtn" onclick="location.href='/notice/write/update/${board.id}'">수정</button>
                <button type="submit" class="deleteBtn" onclick="location.href='/notice/delete/${board.id}'">삭제</button>
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
                    <button id="addButton">등록</button>
                    <button class="button" type="button" id="emojiBtn">😀</button>
                </div>
                <div class="emoticons">
                    <div class="emoticon">
                    </div>
                </div>
            </div>
        </div>
    </form>

    <h3>댓글</h3>
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
                                            .append($('<button>').addClass('deleteReplyBtn').text('삭제').attr('data-id', reply.id).attr('data-employee-id', reply.employeeId))
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


<%@ page contentType="text/html;charset=UTF-8" language="java" %>

    <title>Title</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">

<!-- jQuery -->
<script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>

<!-- Date Range Picker CSS & JS -->
<link rel="stylesheet" type="text/css" href="https://cdn.jsdelivr.net/npm/daterangepicker/daterangepicker.css" />
<script src="https://cdn.jsdelivr.net/momentjs/latest/moment.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/daterangepicker/daterangepicker.min.js"></script>

<!-- Chart.js -->
<script src="https://cdn.jsdelivr.net/npm/chart.js"></script>

<!-- Bootstrap 5 JS Bundle -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>

    <jsp:include page="/WEB-INF/views/template/header.jsp" />

<style>
    .kanban-board {
        display: flex;
        gap: 1rem;
        padding: 1rem;
        min-height: 600px;
    }

    .kanban-column {
        flex: 1;
        background: #f5f5f5;
        border-radius: 8px;
        padding: 1rem;
    }

    .work-item {
        background: white;
        padding: 1rem;
        margin-bottom: 0.5rem;
        border-radius: 4px;
        cursor: pointer;
        box-shadow: 0 2px 4px rgba(0,0,0,0.1);
    }

    .priority {
        display: inline-block;
        padding: 2px 8px;
        border-radius: 12px;
        font-size: 12px;
    }

    .priority.high { background: #ff4444; color: white; }
    .priority.middle { background: #ffbb33; color: white; }
    .priority.low { background: #00C851; color: white; }

    .member-profiles {
        display: flex;
        align-items: center;
    }

    .member-profiles img {
        width: 30px;
        height: 30px;
        border-radius: 50%;
        margin-right: -10px;
        border: 2px solid white;
    }
</style>

<div class="project-header mb-4">
    <h2>${project.name}</h2>
    <div class="project-info">
        <span>기간: ${project.regDate} ~ ${project.deadLine}</span>
        <
    </div>

</div>

<!-- 칸반보드 -->
<div class="kanban-board">
    <div class="kanban-column" data-status="TODO">
        <h3>해야할 일</h3>
        <div class="work-items" ondrop="drop(event)" ondragover="allowDrop(event)">
            <c:forEach items="${works}" var="work">
                <c:if test="${work.state == 'TODO'}">
                    <div class="work-item" draggable="true" ondragstart="drag(event)"
                         data-work-id="${work.id}" onclick="openWorkModal(${work.id})">
                        <h4>${work.title}</h4>
                        <p class="priority ${work.priority.toLowerCase()}">${work.priority}</p>
                    </div>
                </c:if>
            </c:forEach>
        </div>
    </div>

    <!-- 작성중, 완료 컬럼도 동일한 구조로 구현 -->
</div>
</div>

<!-- Work 상세 모달 -->
<div class="modal fade" id="workModal">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title">Work 상세</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
            </div>
            <div class="modal-body">
                <form id="workForm">
                    <input type="hidden" name="id">
                    <input type="hidden" name="projectId" value="${project.id}">

                    <div class="mb-3">
                        <label>제목</label>
                        <input type="text" class="form-control" name="title">
                    </div>

                    <div class="mb-3">
                        <label>상태</label>
                        <select class="form-select" name="state">
                            <option value="TODO">해야할 일</option>
                            <option value="ONGOING">작성중</option>
                            <option value="FINISH">완료</option>
                        </select>
                    </div>

                    <div class="mb-3">
                        <label>우선순위</label>
                        <select class="form-select" name="priority">
                            <option value="HIGH">높음</option>
                            <option value="MIDDLE">중간</option>
                            <option value="LOW">낮음</option>
                        </select>
                    </div>

                    <div class="mb-3">
                        <label>내용</label>
                        <textarea class="form-control" name="content"></textarea>
                    </div>

                    <div class="mb-3">
                        <label>파일 첨부</label>
                        <input type="file" class="form-control" multiple>
                    </div>
                </form>
            </div>
        </div>
    </div>
<script>




    // 프로젝트 기간 선택
    $('#projectPeriod').daterangepicker({
        locale: {
            format: 'YYYY-MM-DD'
        },
        opens: 'left'
    }, function(start, end) {
        $('input[name="regDate"]').val(start.format('YYYY-MM-DD'));
        $('input[name="deadLine"]').val(end.format('YYYY-MM-DD'));
    });

    // 프로젝트 생성
    async function createProject() {
        const formData = new FormData(document.getElementById('projectForm'));
        const projectData = Object.fromEntries(formData.entries());

        try {
            const response = await fetch('/api/projects', {
                method: 'POST',
                headers: {
                    'Content-Type': 'application/json',
                },
                body: JSON.stringify(projectData)
            });

            if (response.ok) {
                location.reload();
            }
        } catch (error) {
            console.error('프로젝트 생성 실패:', error);
        }
    }

    // 드래그 앤 드롭 기능
    function drag(ev) {
        ev.dataTransfer.setData("workId", ev.target.dataset.workId);
    }

    function allowDrop(ev) {
        ev.preventDefault();
    }

    async function drop(ev) {
        ev.preventDefault();
        const workId = ev.dataTransfer.getData("workId");
        const newState = ev.target.closest('.kanban-column').dataset.status;

        try {
            await updateWorkStatus(workId, newState);
            if (newState === 'FINISH') {
                await updateFinishDate(workId);
            }
        } catch (error) {
            console.error('상태 업데이트 실패:', error);
        }
    }
</script>

<jsp:include page="/WEB-INF/views/template/footer.jsp" />

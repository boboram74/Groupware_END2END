    <!DOCTYPE html>
    <html lang="en">
    <%@ page contentType="text/html;charset=UTF-8" language="java" %>

    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <script src="https://code.jquery.com/jquery-latest.min.js"></script>
        <link rel="stylesheet" href="/css/approval/draft.css">
        <script src="/js/summernote/summernote-lite.js"></script>
        <script src="/js/summernote/lang/summernote-ko-KR.js"></script>
        <link rel="stylesheet" href="/js/summernote/summernote-lite.css">
        <title>Document</title>
        <style>
            .loading-img {
                //background-image: '/image/';
            }
        </style>
    </head>
    <div class="loading-img" style="display: none"></div>
    <body>

    <div class="overlay"></div>
    <div class="modalContainer">
        <div class="approvalModalSelect">
            <div>
                <h3>사원 목록</h3>
                <div id="employees">
                    <div id="departments1">
                        <label for="selector">부서 목록</label>
                        <select id="selector" onchange="employees(this.value)">
                            <option>부서</option>
                            <option value="1">경영</option>
                            <option value="2">인사</option>
                            <option value="3">총무</option>
                            <option value="4">운영지원</option>
                            <option value="5">연구</option>
                            <option value="6">사장</option>
                        </select>
                    </div>
                </div>
            </div>

            <div>
                <h3>결재선</h3>
                <div id="approvalLine" ondrop="drop(event)" ondragover="allowDrop(event)">

                </div>
            </div>
        </div>
        <div>
            <button id="addApproval">추가</button>
            <button id="closeModal">닫기</button>
        </div>
    </div>

    <form action="/approval/insert" id="form">
     <jsp:include page="${dto.form}" />
    </form>

<script>
    const summernoteSetting = (target) => {
        return {
            codeviewFilter: true,
            codeviewIframeFilter: true,
            placeholder : '내용을 입력하십시오',
            height : target.height(),
            minHeight : target.height(),
            lang : 'ko-KR',
            toolbar : [
                [ 'fontname', [ 'fontname' ] ],
                [ 'fontsize', [ 'fontsize' ] ],
                [
                    'style',
                    [ 'bold', 'italic', 'underline',
                        'strikethrough', 'clear' ] ],
                [ 'color', [ 'forecolor', 'color' ] ],
                [ 'table', [ 'table' ] ],
                [ 'para', [ 'ul', 'ol', 'paragraph' ] ],
                [ 'height', [ 'height' ] ],
                [ 'insert', [ 'picture', 'link', 'video' ] ] ],
            fontNames : [ 'Arial', 'Arial Black', 'Comic Sans MS',
                'Courier New', '맑은 고딕', '궁서', '굴림체', '굴림', '돋움체', '바탕체' ],
            fontSizes : [ '8', '9', '10', '11', '12', '14', '16', '18',
                '20', '22', '24', '28', '30', '36', '50', '72' ],
            callbacks : { //여기 부분이 이미지를 첨부하는 부분
                onImageUpload : function(files) {
                    for(let i = 0; i < files.length; i++) {
                        console.log(files);
                        uploadImage(files[i], this);
                    }
                },

                onPaste : function(e) {
                    console.log(e);

                    const clipboardData = e.originalEvent.clipboardData;
                    if (clipboardData && clipboardData.items
                        && clipboardData.items.length) {
                        const item = clipboardData.items[0];
                        if (item.kind === 'file'
                            && item.type.indexOf('image/') !== -1) {
                            e.preventDefault();
                        }
                    }
                },

                onMediaDelete: function (target) {
                    if (confirm('이미지를 삭제 하시겠습니까?')) {
                        const deletedImageUrl = $(target)
                            .attr('src')
                        deleteImage(deletedImageUrl);
                    }
                },

                onKeydown: function(e) {
                    const key = e.keyCode;
                    console.log(key);
                    if (key === 8 || key === 46) {  // 8은 백스페이스, 46은 Delete 키
                        const target = $(this).summernote('invoke', 'moduleInvoke', 'editor.getSelectedNode');
                        console.log(target);

                        if ($(target).is('img')) {
                            if (confirm('이미지를 삭제 하시겠습니까?')) {
                                const deletedImageUrl = $(target)
                                    .attr('src')
                                deleteImage(deletedImageUrl);
                            } else {
                                e.preventDefault();  // 삭제 취소시 기본 동작 방지
                            }
                        }
                    }
                }
            }
        };
    }

    function uploadImage(file, editor) {
        let formData = new FormData();
        formData.append('file', file);
        $.ajax({
            url : '/file/upload/image',
            data : formData,
            type : 'POST',
            contentType : false,
            processData : false,
            beforeSend: function(xhr) {
                xhr.setRequestHeader("Accept-Charset", "UTF-8");
            },
            error : function(request, status, error) {
                console.log("code: " + request.status)
                console.log("message: " + request.responseText)
                console.log("error: " + error);
            }
        }).done(function(data) {
            // 경로에서 파일명만 추출하여 디코딩
            const path = data.split('/');
            const fileName = decodeURIComponent(path.pop());
            path.push(fileName);

            console.log(fileName);
            const decodedPath = path.join('/');

            $(editor).summernote('insertImage', decodedPath);
        });
    }

    function deleteImage(path) {
        console.log(path);
        $.ajax({
            url: '/file/delete/image?path=' + path
        })
    }
</script>
    <script>
        window.onload = function() {
            const date = new Date();
            $('.date').html(date.toLocaleDateString());
        }
        const approvalList = [];

        $('#addApproval').on('click', function () {
            const lineBox = $('#lineBox');
            const approvalLine = $('#approvalLine');

            approvalList.forEach(employee => {

                if ($('#lineBox').find(`#${employee.name}`).length === 0) {
                    const div = makeEmployee(employee);
                    div.append($('<input>').attr('type', 'hidden').attr('name', 'approverId').val(employee.id))

                    lineBox.append(div);
                }
            });

            $('.modalContainer').fadeOut();
            $('.overlay').fadeOut();
        });


        function allowDrop(event) {
            event.preventDefault();
        }

        function drag(event) {
            event.dataTransfer.setData("text", event.target.textContent);

        }


        function drop(event) {
            event.preventDefault();
            let employee = JSON.parse(event.dataTransfer.getData("application/json"));
            const exists = approvalList.some(emp => emp.id === employee.id);
            if (exists) {
                alert("이미 추가된 사원입니다.");
                return;
            }
            if (employee) {
                $('#' + employee.id).remove();
                const div = makeEmployee(employee);
                $('#approvalLine').append(div);
                approvalList.push(employee);
            }

        }

        $('#add').on('click', function () {
            $('.modalContainer').fadeIn();
            $('.overlay').fadeIn();
        });

        $('#closeModal').on('click', function () {
            $('.modalContainer').fadeOut();
            $('.overlay').fadeOut();
        });

        $('#contents').summernote(summernoteSetting($('#contents')));

        function employees(departmentId) {
            $.ajax({
                url: '/employee/department/' + departmentId,
                type: 'GET',
                dataType: 'json',
                success: function (response) {
                    let employeesHtml = '';
                    $('#employees').find('div:not(#departments1)').remove();
                    if (response.length === 0) {
                        employeesHtml = "<p>해당 부서에 사원이 없습니다.</p>";
                    } else {
                        response.forEach(function (employee) {
                            const div = makeEmployee(employee)

                            $('#employees').append(div);
                        });
                    }
                },
                error : function(request, status, error) {
                    console.log("code: " + request.status)
                    console.log("message: " + request.responseText)
                    console.log("error: " + error);
                }
            });
        }
        function makeEmployee(employee) {
            const div = $('<div>')
                .addClass("employee")
                .attr('draggable', true)
                .attr('id', employee.id);

            div.append($("<span>").addClass("jobName").html(employee.jobName));
            div.append($("<span>").html(" : "));
            div.append($("<span>").addClass("name").html(employee.name));

            // 삭제 버튼 추가
            const removeBtn = $('<button>')
                .addClass("removeBtn")
                .text("❌")
                .css({
                    marginLeft: '10px',
                    color: 'red',
                    cursor: 'pointer',
                    background: 'none',
                    border: 'none',
                    fontSize: '14px'
                })
                .on('click', function () {
                    div.remove(); // DOM에서 제거
                    const index = approvalList.findIndex(emp => emp.id === employee.id);
                    if (index > -1) approvalList.splice(index, 1); // 배열에서 제거
                });

            div.append(removeBtn);

            div.on('dragstart', function (event) {
                event.originalEvent.dataTransfer.setData("application/json", JSON.stringify(employee));
            });

            return div;
        }

        $('form').on('submit', function(e) {
            e.preventDefault();

            if (approvalList.length < 1) {
                alert('결재자는 최소 2명 이상이어야 합니다.');
                return;
            }

            const formData = new FormData(document.getElementById('form'));
            formData.append('content', $('#contents').summernote('code'));

            approvalList.forEach(employee => {
                formData.append('approverId', employee.id);
            });

            const type = $('.container').attr('type');
            if (type === 'vacation') {
                const date = $('#date').val();
                const time = $('.time:visible').val();

                const vacationType = formData.get('vacationType');

                console.log(vacationType);

                if (vacationType === 'ANNUAL') {
                    formData.append('startDate', date + " 00:00:00");
                } else {
                    console.log(date, time);
                    formData.append('startDate', date + " " + time);
                    $('input [name="vacationDate"]').val(0.5);
                }
            }

            for (const key of formData.keys()) {
                console.log(key +": " + formData.get(key));
            }

            $.ajax({
                url: '/approval/insert',
                method: 'POST',
                data: formData,
                processData: false,
                contentType: false,
                error : function(request, status, error) {
                    console.log("code: " + request.status)
                    console.log("message: " + request.responseText)
                    console.log("error: " + error);

                }
            }).done(function(resp) {
                console.log('전송됨');
                if (window.opener) {
                    window.opener.location.reload();
                    window.close();
                } else {
                    location.href = '/approval/list';
                }
            });
        });
    </script>

    </body>

    </html>

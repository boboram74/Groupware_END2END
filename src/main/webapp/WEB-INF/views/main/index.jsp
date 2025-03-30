<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:choose>
    <c:when test="${login != null}">
        <jsp:include page="login.jsp"/>
    </c:when>
    <c:otherwise>
        <jsp:include page="/WEB-INF/views/template/header.jsp"/>
        <script src="/js/summernote/summernote-lite.js"></script>
        <script src="/js/summernote/lang/summernote-ko-KR.js"></script>
        <link rel="stylesheet" href="/js/summernote/summernote-lite.css">
        <div>
            <form action="file/upload/test" method="post" enctype="multipart/form-data">
                <jsp:include page="/WEB-INF/views/template/fileInput.jsp" />
                <textarea id="contents"></textarea>
                <button>submit</button>
            </form>
        </div>
        <script>
            $('#contents').summernote({
                callback: {
                    onImageUpload: (files) => {
                        for(let i = 0; i < files.length; i++) {
                            imageUpload(files[i], this);
                        }
                    },
                    onPaste : (e) => {
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
                    }
                }
            });

            const imageUpload = (file, editor) => {
                console.log(file);
                let formData = new FormData();
                formData.append('file', file);

                $.ajax({
                    url: 'file/upload/image/temp',
                    data: formData,
                    type: 'POST',
                    contentType: false,
                    processData: false
                }).done((response) => {
                    $(editor).summeronte('insertImage', response.path)
                })
            }
        </script>
        <jsp:include page="/WEB-INF/views/template/footer.jsp"/>
    </c:otherwise>
</c:choose>



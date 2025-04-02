const summernoteSetting = (target) => {
        return {
            codeviewFilter: true,
            codeviewIframeFilter: true,
            placeholder : '내용을 입력하십시오',
            height : 700,
            minHeight : null, // set minimum height of editor
            maxHeight : 300, // set maximum height of editor
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
                        const deletedImageUrl = target
                            .attr('src')
                            .split('/')
                            .pop()

                        deleteImage(deletedImageUrl)
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
        error : function(request, status, error) {
            console.log("code: " + request.status)
            console.log("message: " + request.responseText)
            console.log("error: " + error);
        }
    }).done(function(data) {
        $(editor).summernote('insertImage', data);
    });
}

function deleteImage(path) {
    $.ajax({
        url: 'file/delete/image/' + path
    })
}
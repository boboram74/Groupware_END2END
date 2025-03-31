const summernoteSetting = (target) => {
        return {
            codeviewFilter: true,
            codeviewIframeFilter: true,
            placeholder : '내용을 입력하십시오',
            height : 700,
            minHeight : null, // set minimum height of editor
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

                    if (clipboardData && clipboardData.items
                        && clipboardData.items.length) {
                        if (item.kind === 'file'
                            && item.type.indexOf('image/') !== -1) {
                            e.preventDefault();

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
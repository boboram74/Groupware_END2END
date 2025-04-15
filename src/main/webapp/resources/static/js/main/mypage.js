$(document).ready(function(){
    $('form').off('submit').on('submit', function(e) {
        console.log('폼 제출 시도');
        // 이벤트 전파 강제
        e.stopPropagation();
        e.preventDefault();

        // 직접 submit 호출
        this.submit();
    });
    $("#editBtn").on("click", function(e) {
        e.preventDefault();
        if (isHR) {
            $("#nameText, #contactText, #positionText, #departmentText").hide();
            $("#nameInput, #contactInput, #positionInput, #departmentInput").show();
        }
        $("#zipCodeText, #addressText, #detailAddressText").hide();
        $("#zipCodeInput, #addressInput, #detailAddressInput").show();
        $("#searchAddressBtn").show();
        $("#editBtn").hide();
        $("#backBtn").hide();
        $("#saveBtn").show();
        $("#cancelBtn").show();
        $(".hrProfile").addClass("editable");
    });
    $("#profileInput").on("change", function (e) {
        const file = e.target.files[0];
        if (file) {
            const reader = new FileReader();
            reader.onload = function (event) {
                $("#profilePreview").attr("src", event.target.result);
            };
            reader.readAsDataURL(file);

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
                $('input[name=profileImg]').val(data);
                console.log(data);
            });
        } else {
            $("#profilePreview").attr("src", "/image/defaultImg.jpg"); // 기본 이미지 복구
        }
    });
$("#searchAddressBtn").on("click", function (e) {
    e.preventDefault();
    new daum.Postcode({
        oncomplete: function (data) {
            $("#zipCodeInput").val(data.zonecode);
            $("#addressInput").val(data.roadAddress);
            $("#detailAddressInput").focus();
        }
    }).open();
});
    $("#backBtn").on("click", function() {
        window.history.back();
    });
    $("#cancelBtn").on("click", function() {
        location.reload();
    });
    $("#changePwBtn").on("click", function(e) {
        window.open("/employee/toChangePwForm", "changePwPopup", "width=500,height=400");
    });
});
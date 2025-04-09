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

$("#idCheckBtn").on("click",function(){
    $.ajax({
        url:"/hr/idCheck",
        data: { loginId: $("#id").val() }
    }).done(function(resp) {
        resp = JSON.parse(resp)
        if(resp){
            $("#result").css("color","red")
            $("#result").html("이미 사용중인 ID 입니다.")
        }else{
            $("#result").css("color","blue")
            $("#result").html("사용 가능한 ID 입니다.")
        };
    });
});

$("#postBtn").on("click", function () {
    new daum.Postcode({
        oncomplete: function (data) {
            $("#postcode").val(data.zonecode);
            $("input[name='address']").val(data.roadAddress);
            $("input[name='detailAddress']").focus();
        }
    }).open();
});

$("#backBtn").on("click", function () {
    location.href = "/hr/list";
})

$("#form").on("submit", function(e) {
    e.preventDefault(); // 기본 제출 막기

    let name = $("input[name='name']").val().trim();
    let birthday = $("input[name='birthday']").val().trim();
    let loginId = $("input[name='loginId']").val().trim();
    let password = $("input[name='password']").val().trim();
    let repw = $(".repw input").val().trim();
    let contact = $("input[name='contact']").val().trim();
    let postCode = $("input[name='postCode']").val().trim();
    let address = $("input[name='address']").val().trim();
    let jobId = $("select[name='jobId']").val();
    let departmentId = $("select[name='departmentId']").val();

    if(name === "") {
        alert("이름을 입력하세요.");
        $("input[name='name']").focus();
        return false;
    }
    if(birthday === "") {
        alert("생년월일을 선택하세요.");
        $("input[name='birthday']").focus();
        return false;
    }
    if(loginId === "") {
        alert("아이디를 입력하세요.");
        $("input[name='loginId']").focus();
        return false;
    }
    let loginIdPattern = /^[a-z0-9]{8,20}$/;
    if(!loginIdPattern.test(loginId)) {
        alert("아이디는 영어 소문자와 숫자로 8~20자 입력하세요.");
        $("input[name='loginId']").focus();
        return false;
    }
    if(password === "") {
        alert("패스워드를 입력하세요.");
        $("input[name='password']").focus();
        return false;
    }
    let passwordPattern = /^(?=.*[a-zA-Z])(?=.*\d).{8,}$/;
    if(!passwordPattern.test(password)) {
        alert("패스워드는 8자 이상이며, 영문과 숫자를 포함해야 합니다.");
        $("input[name='password']").focus();
        return false;
    }
    if(repw === "") {
        alert("패스워드 확인을 입력하세요.");
        $(".repw input").focus();
        return false;
    }
    if(password !== repw) {
        alert("패스워드와 패스워드 확인이 일치하지 않습니다.");
        $(".repw input").focus();
        return false;
    }
    if(contact === "") {
        alert("연락처를 입력하세요.");
        $("input[name='contact']").focus();
        return false;
    }
    let contactPattern = /^010\d{8,9}$/;
    if(!contactPattern.test(contact.replace(/[-\s]/g, ""))) {
        alert("연락처는 010으로 시작하는 10~11자리 숫자여야 합니다.");
        $("input[name='contact']").focus();
        return false;
    }
    if(jobId === "" || jobId == null) {
        alert("직급을 선택하세요.");
        $("select[name='jobId']").focus();
        return false;
    }
    if(departmentId === "" || departmentId == null) {
        alert("부서를 선택하세요.");
        $("select[name='departmentId']").focus();
        return false;
    }
    if(postCode === "" || address === "") {
        alert("우편번호와 주소를 모두 입력하세요.");
        $("input[name='postCode']").focus();
        return false;
    }
    this.submit();
});
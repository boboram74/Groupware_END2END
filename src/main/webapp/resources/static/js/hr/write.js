var isIdChecked = false;
var checkedId = "";
var isPasswordValid = false;
var isPwMatch = false;

$(document).ready(function(){
    $("#id").on("input", function(){
        isIdChecked = false;
        checkedId = "";
        $("#resultId").html("");
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
                processData : false
            }).done(function(data) {
                console.log(data);
                $('input[name=profileImg]').val(data);
            });
        } else {
            $("#profilePreview").attr("src", "/image/defaultImg.jpg"); // 기본 이미지 복구
        }
    });

    $("#idCheckBtn").on("click", function(){
        var id = $("#id").val().trim();
        if (!id) {
            $("#resultId").css({
                "color": "red",
                "font-size": "14px"
            });
            $("#resultId").html("아이디를 작성해주세요.");
            return;
        }

        var regex = /^[a-z0-9]{6,20}$/;
        if (!regex.test(id)) {
            $("#resultId").css({
                "color": "red",
                "font-size": "14px"
            });
            $("#resultId").html("아이디 형식이 올바르지 않습니다. 영어 소문자와 숫자를 6~20자 사이로 입력해주세요.");
            return;
        }

        $.ajax({
            url:"/hr/idCheck",
            data: { loginId: id }
        }).done(function(resp) {
            resp = JSON.parse(resp);
            if(resp) {
                $("#resultId").css({
                    "color": "red",
                    "font-size": "14px"
                });
                $("#resultId").html("이미 사용중인 ID 입니다.");
                isIdChecked = false;
                checkedId = "";
            } else {
                $("#resultId").css({
                    "color": "blue",
                    "font-size": "14px"
                });
                $("#resultId").html("사용 가능한 ID 입니다.");
                isIdChecked = true;
                checkedId = id;
            }
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
    });

    $("input[name='password']").on("keyup", function(){
        var password = $(this).val().trim();
        var passwordPattern = /^(?=.*[a-zA-Z])(?=.*\d).{8,}$/;

        if(password === "") {
            $("#resultPw").html("");
            isPasswordValid = false;
            return;
        }

        if(!passwordPattern.test(password)){
            $("#resultPw").css({
                "color": "red",
                "font-size": "14px"
            }).html("패스워드는 8자 이상이며, 영문과 숫자를 포함해야 합니다.");
            isPasswordValid = false;
        } else {
            $("#resultPw").html("");
            isPasswordValid = true;
        }
    });

    $("input[name='password'], .repw input").on("keyup", function(){
        var password = $("input[name='password']").val().trim();
        var repw = $(".repw input").val().trim();

        if(password === "" || repw === ""){
            $("#resultRePw").html("");
            isPwMatch = false;
            return;
        }
        if(password !== repw){
            $("#resultRePw").css({
                "color": "red",
                "font-size": "14px"
            }).html("패스워드가 일치하지 않습니다.");
            isPwMatch = false;
        } else {
            $("#resultRePw").html("");
            isPwMatch = true;
        }
    });

    $("input[name='contact']").on("input", function(){
        // 입력값에서 숫자 이외의 문자를 모두 제거
        let sanitized = $(this).val().replace(/\D/g, "");
        $(this).val(sanitized);
    });

    // 연락처 형식을 자동으로 하이픈 포함한 형식으로 변환하는 함수
    function formatPhoneNumber(phone) {
        phone = phone.replace(/\D/g, "");
        if (phone.length === 10) {
            return phone.replace(/(\d{3})(\d{3})(\d{4})/, "$1-$2-$3");
        } else if (phone.length === 11) {
            return phone.replace(/(\d{3})(\d{4})(\d{4})/, "$1-$2-$3");
        } else {
            return phone;
        }
    }

    $("#form").on("submit", function(e) {
        e.preventDefault();

        var loginId = $("input[name='loginId']").val().trim();
        if(!isIdChecked || loginId !== checkedId) {
            alert("아이디 중복체크는 필수 입니다.");
            $("input[name='loginId']").focus();
            return false;
        }

        let name = $("input[name='name']").val().trim();
        let birthday = $("input[name='birthday']").val().trim();
        let password = $("input[name='password']").val().trim();
        let repw = $(".repw input").val().trim();
        let contact = $("input[name='contact']").val().trim();
        let formattedContact = formatPhoneNumber(contact);
        let postCode = $("input[name='postCode']").val().trim();
        let address = $("input[name='address']").val().trim();
        let jobId = $("select[name='jobId']").val();
        let departmentId = $("select[name='departmentId']").val();
        $("input[name='contact']").val(formattedContact);

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
        if(password === "") {
            alert("패스워드를 입력하세요.");
            $("input[name='password']").focus();
            return false;
        }
        if(repw === "") {
            alert("패스워드 확인을 입력하세요.");
            $(".repw input").focus();
            return false;
        }
        if(contact === "") {
            alert("연락처를 입력하세요.");
            $("input[name='contact']").focus();
            return false;
        }
        let contactPattern = /^010-\d{3,4}-\d{4}$/;
        if (!contactPattern.test(formattedContact)) {
            alert("연락처는 010으로 시작하는 10~11자리 숫자여야 하며, 예: 010-1234-3445 형식이어야 합니다.");
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
});

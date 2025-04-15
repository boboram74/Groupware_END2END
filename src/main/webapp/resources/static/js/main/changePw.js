$("#newPw").on("keyup", function(){
    var newPw = $(this).val().trim();
    var passwordPattern = /^(?=.*[a-zA-Z])(?=.*\d).{8,}$/;
    if(newPw === "") {
        $("#resultPw").html("");
        return;
    }
    if(!passwordPattern.test(newPw)){
        $("#resultPw").css({
            "color": "red",
            "font-size": "14px"
        }).html("패스워드는 8자 이상이며, 영문과 숫자를 포함해야 합니다.");
    } else {
        $("#resultPw").html("");
    }
});

$("#newPw, #confirmPw").on("keyup", function(){
    var newPw = $("#newPw").val().trim();
    var confirmPw = $("#confirmPw").val().trim();

    if(newPw === "" || confirmPw === ""){
        $("#resultRePw").html("");
        return;
    }
    if(newPw !== confirmPw){
        $("#resultRePw").css({
            "color": "red",
            "font-size": "14px"
        }).html("패스워드가 일치하지 않습니다.");
    } else {
        $("#resultRePw").html("");
    }
});

$("#form").on("submit", function(e) {
    var currentPw = $("#currentPw").val().trim();
    var newPw = $("#newPw").val().trim();
    var confirmPw = $("#confirmPw").val().trim();

    if(currentPw === ""){
        alert("기존 패스워드를 입력해주세요.");
        $("#currentPw").focus();
        e.preventDefault();
        return false;
    }
    if(newPw === ""){
        alert("새 패스워드를 입력해주세요.");
        $("#newPw").focus();
        e.preventDefault();
        return false;
    }
    if(confirmPw === ""){
        alert("새 패스워드 확인을 입력해주세요.");
        $("#confirmPw").focus();
        e.preventDefault();
        return false;
    }
});



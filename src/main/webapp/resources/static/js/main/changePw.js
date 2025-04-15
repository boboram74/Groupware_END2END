var isCurrentPwVali = false;

$(document).ready(function() {

    $("#currentPw").on("focusout", function(){
        var currentPw = $(this).val().trim();

        if(currentPw === ""){
            $("#resultPw").html("");
            isCurrentPwVali = false;
            return;
        }

        const formData = new FormData();
        $.ajax({
            url: "/employee/pwVali",
            type: "POST",
            contentType: "application/json",
            data: JSON.stringify({ currentPw: currentPw })
        }).done(function(resp) {
            resp = JSON.parse(resp);
            if(!resp) {
                isCurrentPwVali = false;
            } else {
                $("#resultPw").html("");
                isCurrentPwVali = true;
            }
        })
    });
    $("#newPw").on("keyup", function(){
        var newPw = $(this).val().trim();
        var passwordPattern = /^(?=.*[a-zA-Z])(?=.*\d).{8,}$/;

        if(newPw === "") {
            $("#resultNewPw").html("");
            return;
        }
        if(!passwordPattern.test(newPw)){
            $("#resultNewPw").css({
                "color": "red",
                "font-size": "14px"
            }).html("패스워드는 8자 이상이며, 영문과 숫자를 포함해야 합니다.");
        } else {
            $("#resultNewPw").html("");
        }
    });

    $("#newPw, #confirmPw").on("keyup", function(){
        var newPw = $("#newPw").val().trim();
        var confirmPw = $("#confirmPw").val().trim();

        console.log(newPw);
        console.log(confirmPw);

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

    $("#changeBtn").on("click", function(e) {
        e.preventDefault();
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
        if(confirmPw === ""){
            alert("새 패스워드 확인을 입력해주세요.");
            $("#confirmPw").focus();
            e.preventDefault();
            return false;
        }
        if (isCurrentPwVali === false) {
            $("#resultPw").css({
                "color": "red",
                "font-size": "14px"
            }).html("패스워드를 다시 확인해주세요.");
            return false;
        }

        $.ajax({
            url: "/employee/changePw",
            type: "POST",
            data: { newPw : $("#newPw").val() },
        }).done(function(response) {
            if(response === "SUCCESS") {
                opener.location.reload();
                window.close();
            } else {
                alert("오류 발생: " + response);
            }
        })
    });

});
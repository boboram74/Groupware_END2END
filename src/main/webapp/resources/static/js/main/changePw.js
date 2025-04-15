function validateForm() {
    var newPw = document.getElementById("newPw").value;
    var confirmPw = document.getElementById("confirmPw").value;

    if(newPw !== confirmPw) {
    alert("새 패스워드와 확인 패스워드가 일치하지 않습니다.");
    return false;
}
    return true;
}

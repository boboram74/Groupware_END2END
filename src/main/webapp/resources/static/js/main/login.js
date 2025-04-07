$("#newBtn").on("click",function(){
    location.href="hr/write";
})

// 저장된 아이디 불러오기
const savedId = localStorage.getItem("savedId");
if (savedId) {
    $("#id").val(savedId);
    $("#rememberId").prop("checked", true);
}
// 폼 제출 시 아이디 저장
$("form").on("submit", function() {
    if ($("#rememberId").is(":checked")) {
        localStorage.setItem("savedId", $("#id").val());
    } else {
        localStorage.removeItem("savedId");
    }
});



    $(document).ready(function () {
    $("#contents").summernote(setSummerNote());
});

    $("form").on("submit", function () {
    let titleVal = $("#title").val();
    if (titleVal.length >= 50) {
    alert("제목은 최대 50자 미만이어야 합니다.");
    return false;
}
    });

    $("form").on("submit", function () {
    $("#input-contents").val($("#contents").summernote("code"));
});

    $("#listbtn").on("click", function () {
    let last_cpage = sessionStorage.getItem("last_cpage");
    location.href = "/board/list.do?cpage=" + last_cpage;
});

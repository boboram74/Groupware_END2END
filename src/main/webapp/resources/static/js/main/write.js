

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

    function setSummerNote(target) {
    return {
    codeviewFilter: true,
    codeviewIframeFilter: true,
    placeholder: "내용을 입력하십시오",

    width:1430,
    minHeight: 800, // set minimum height of editor
    maxHeight: 800, // set maximum height of editor
    lang: "ko-KR",
    toolbar: [
    ["fontname", ["fontname"]],
    ["fontsize", ["fontsize"]],
    [
    "style",
    ["bold", "italic", "underline", "strikethrough", "clear"],
    ],
    ["color", ["forecolor", "color"]],
    ["table", ["table"]],
    ["para", ["ul", "ol", "paragraph"]],
    ["height", ["height"]],
    ["insert", ["picture", "link", "video"]],
    ],
    fontNames: [
    "Arial",
    "Arial Black",
    "Comic Sans MS",
    "Courier New",
    "맑은 고딕",
    "궁서",
    "굴림체",
    "굴림",
    "돋움체",
    "바탕체",
    ],
    fontSizes: [
    "8",
    "9",
    "10",
    "11",
    "12",
    "14",
    "16",
    "18",
    "20",
    "22",
    "24",
    "28",
    "30",
    "36",
    "50",
    "72",
    ],
    callbacks: {
    //여기 부분이 이미지를 첨부하는 부분
    onImageUpload: function (files) {
    for (let i = 0; i < files.length; i++) {
    uploadImage(files[i], this);
}
},

    onPaste: function (e) {
    console.log(e);

    var clipboardData = e.originalEvent.clipboardData;
    if (
    clipboardData &&
    clipboardData.items &&
    clipboardData.items.length
    ) {
    var item = clipboardData.items[0];
    if (
    item.kind === "file" &&
    item.type.indexOf("image/") !== -1
    ) {
    e.preventDefault();
}
}
},
},
};
}

    function uploadImage(file, editor) {
    var csrfToken = $('meta[name="csrf-token"]').attr("content");
    let formData = new FormData();
    formData.append("file", file);
    formData.append("request", "board");
    formData.append("csrfToken", csrfToken);
    $.ajax({
    url: "/file/image/upload.do",
    data: formData,
    type: "POST",
    contentType: false,
    processData: false,
    csrfToken: csrfToken,
    error: function (request, status, error) {
    console.log("code: " + request.status);
    console.log("message: " + request.responseText);
    console.log("error: " + error);
},
}).done(function (data) {
    console.log(data + "1");
    $(editor).summernote("insertImage", data.path);
});
}

    $("form").on("submit", function () {
    $("#input-contents").val($("#contents").summernote("code"));
});

    $("#listbtn").on("click", function () {
    let last_cpage = sessionStorage.getItem("last_cpage");
    location.href = "/board/list.do?cpage=" + last_cpage;
});

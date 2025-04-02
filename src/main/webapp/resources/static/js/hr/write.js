$("#profileInput").on("change", function (e) {
    const file = e.target.files[0];
    if (file) {
        const reader = new FileReader();
        reader.onload = function (event) {
            $("#profilePreview").attr("src", event.target.result);
        };
        reader.readAsDataURL(file);
    } else {
        $("#profilePreview").attr("src", "/image/defaultImg.jpg"); // 기본 이미지 복구
    }
});
$("#idcheckBtn").on("click",function(){
    $.ajax({
        url:"/hr/idcheck",
        data:{id:$("#id").val()}
    }).done(function(resp) {

        if(JSON.parse(resp)){
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
            $("input[name='address1']").val(data.roadAddress);
            $("input[name='address2']").focus();
        }
    }).open();
});
$("#insertBtn").on("click", function () {
    location.href = "/hr/insert";
})
$("#backBtn").on("click", function () {
    location.href = "/hr/list";
})
// 유효성 검사
$("#editBtn").on("click",function(){
    e.preventDefault();
    if (isHR) {
        $("#nameText, #contactText, #birthdayText, #positionText, #departmentText, #emailText").hide();
        $("#nameInput, #contactInput, #birthdayInput, #positionInput, #departmentInput, #emailInput").show();
    }
    $("#zipCodeText, #addressText, #detailAddressText").hide();
    $("#zipCodeInput, #addressInput, #detailAddressInput").show();
    $("#searchAddressBtn").show();
    $("#EditBtn").hide();
    $("#SaveBtn").show();
})
$("#searchAddressBtn").on("click", function(e){
    e.preventDefault();
    new daum.Postcode({
        oncomplete: function(data) {
            // 선택한 우편번호와 도로명 주소를 입력 필드에 채워줌
            $("#zipCodeInput").val(data.zonecode);
            $("#addressInput").val(data.roadAddress);
            $("#detailAddressInput").focus();
        }
    }).open();
});
$("#saveBtn").on("click",function(){
    location.href="/hr/update";
})
$("#backBtn").on("click",function(){
    window.history.back();
})
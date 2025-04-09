$("#searchBtn").on("click",function(){
    alert("검색버튼 클릭");
})
$("#approveBtn").on("click",function(){
    let empId = $(this).data("id");
    location.href="/hr/roleUpdate?id="+ empId;
})
$("#rejectBtn").on("click",function(){
    let empId = $(this).data("id");
    alert("반려 버튼 클릭, employee id: " + empId);
})

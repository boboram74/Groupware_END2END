$(document).ready(function(){
$("#searchBtn").on("click",function(){
    alert("검색버튼 클릭");
})
$(".approveBtn").on("click",function(){
    let id = $(this).data("id");
    console.log(id);
    location.href="/hr/roleUpdate/" + id;
})
$(".rejectBtn").on("click",function(){
    let id = $(this).data("id");
    alert("반려 버튼 클릭, employee id: " + id);
})
});

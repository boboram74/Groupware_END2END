$(document).ready(function(){
$("#searchBtn").on("click",function(){
    alert("검색버튼 클릭");
})
$(".approveBtn").on("click",function(){
    let id = $(this).data("id");
    location.href="/hr/roleUpdate/" + id;
})
$(".rejectBtn").on("click",function(){
    let id = $(this).data("id");
    location.href="/hr/deleteById/" + id;
})
});

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

    $(".resignationBtn").on("click",function(){
        let id = $(this).data("id");
        location.href="/hr/isResigned/" + id;
    })

    $('.detail-menu-item').on('click', function() {
        $('.detail-menu-item').removeClass('active');
        $(this).addClass('active');
    });

    const $menuBtn = $('.detail-menu-toggle-btn');
    const $detailMenuModal = $('.detail-menu-modal');
    const $closeBtn = $('.detail-modal-close');

    $menuBtn.on('click', function() {
        $detailMenuModal.addClass('active');
        $('body').css('overflow', 'hidden');
    });

    $closeBtn.on('click', function() {
        $detailMenuModal.removeClass('active');
        $('body').css('overflow', '');
    });

    $(window).on('click', function(e) {
        if ($(e.target).is($detailMenuModal)) {
            $detailMenuModal.removeClass('active');
            $('body').css('overflow', '');
        }
    });
});
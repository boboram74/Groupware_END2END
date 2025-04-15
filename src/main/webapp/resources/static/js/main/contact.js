$(document).ready(function() {
    $('.detail-menu-item').on('click', function() {
        $('.detail-menu-item').removeClass('active');
        $(this).addClass('active');
    });

    const $menuBtn = $('.detail-menu-toggle-btn');
    const $detailMenuModal = $('.detail-menu-modal');
    const $closeBtn = $('.detail-modal-close');

    // 메뉴 버튼 클릭 시 모달 열기
    $menuBtn.on('click', function() {
        $detailMenuModal.addClass('active');
        $('body').css('overflow', 'hidden');
    });

    // 닫기 버튼 클릭 시 모달 닫기
    $closeBtn.on('click', function() {
        $detailMenuModal.removeClass('active');
        $('body').css('overflow', '');
    });

    // 모달 외부 클릭 시 닫기
    $(window).on('click', function(e) {
        if ($(e.target).is($detailMenuModal)) {
            $detailMenuModal.removeClass('active');
            $('body').css('overflow', '');
        }
    });

    $("#searchBtn").on("click",function(){
        alert("검색버튼 클릭");
    })
});

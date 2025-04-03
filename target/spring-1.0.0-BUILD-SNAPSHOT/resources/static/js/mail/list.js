
$(function () {
    let cpage = sessionStorage.getItem("page") || 1;
    $.ajax({
        url: "/mail/listAll",
        data: { cpage: cpage }
    }).done(function (resp) {
        let list = resp.list;
        for(let i = 0; i < list.length; i++) {
                let tr = $('<tr>');

                tr.append($('<td style="width: 5%; text-align: center;">').html('<input style="zoom: 1.5;" type="checkbox">'));

                tr.append($('<td>').html(list[i].SENDEREMAILADDRESS));

                let a = $('<a>').attr('href','/mail/'+ list[i].id).text(list[i].title);
                tr.append($('<td>').append(a).addClass('contents').attr('id', list.id));

                let rawDate = list[i].regdate;
                if (typeof rawDate !== 'string') {
                    rawDate = String(rawDate);
                }
                if (rawDate) {
                    let isoDate = rawDate.replace(" ", "T").split(".")[0];
                    let timestamp = new Date(isoDate).getTime();
                    tr.append($('<td>').addClass('relative-date').attr('data-timestamp', timestamp).html(rawDate));
                } else {
                    tr.append($('<td>').addClass('relative-date').html("날짜 정보 없음"));
                }
                $('#buttons').before(tr);
        }
        let pagingTr = $('<tr>');
        let pagingTd = $('<td colspan="5" style="text-align: center;">');
        if(resp.needPrev) {
            let prevSpan = $('<span>').addClass('paging').attr("page", resp.startNavi - 1).html("<");
            pagingTd.append(prevSpan);
        }
        // 페이지 번호
        for(let i = resp.startNavi; i <= resp.endNavi; i++) {
            let pageSpan = $('<span>').addClass('paging').attr("page", i).html(i);
            pagingTd.append(pageSpan);
        }
        // 다음 버튼
        if(resp.needNext) {
            let nextSpan = $('<span>').addClass('paging').attr("page", resp.endNavi + 1).html(">");
            pagingTd.append(nextSpan);
        }

        pagingTr.append(pagingTd);
        $('#buttons').before(pagingTr);

        // 페이지 번호 클릭 시
        $(".paging").on("click", function() {
            let pageNum = $(this).attr("page");
            sessionStorage.setItem("page", pageNum);
            location.href = "/mail/list?cpage=" + pageNum;
        });
        // 상대적 날짜 표시
        let now = new Date();
        $('.relative-date').each(function(){
            let timestamp = parseInt($(this).data('timestamp'), 10);
            let postDate = new Date(timestamp);
            let diffMinutes = Math.floor((now - postDate) / (1000 * 60));

            if(diffMinutes < 1) {
                $(this).text("방금 전");
            } else if(diffMinutes < 60) {
                $(this).text(diffMinutes + "분 전");
            } else if(diffMinutes < 1440) {
                let diffHours = Math.floor(diffMinutes / 60);
                $(this).text(diffHours + "시간 전");
            } else {
                let year = postDate.getFullYear();
                let month = String(postDate.getMonth() + 1).padStart(2, '0');
                let day = String(postDate.getDate()).padStart(2, '0');
                $(this).text(year + "년 " + month + "월 " + day + "일 ");
            }
        });
    })
});
function formatFileSize(bytes) {
    if (bytes < 1024) {
        return bytes + " B";
    } else if (bytes < 1024 * 1024) {
        return (bytes / 1024).toFixed(2) + " KB";
    } else {
        return (bytes / (1024 * 1024)).toFixed(2) + " MB";
    }
}

$(function () {
    $('.fileItemSize').each(function() {
        let sizeInBytes = parseFloat($(this).data('size'));
        let formattedSize = formatFileSize(sizeInBytes);
        $(this).text(formattedSize);
    });
    window.addEventListener('pageshow', function (event) {
        if(event.persisted) {
            window.location.reload();
        }
    })
});

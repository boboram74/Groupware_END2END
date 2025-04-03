const dropArea = document.getElementById("dropArea");
const fileInput = document.getElementById("fileInput");
const fileInfo = document.querySelector(".file-info");
const fileSizeEl = document.querySelector(".fileSize");

$("#sendMail").on("click", function () {
    let sender = $("#sender").val();
    let receiveMail = $("#receiveMail").val();
    let inputTitle = $("#inputTitle").val();
    let contents = $("#mailContent").val();
    console.log(sender + "발신자");

    let mail = {
        from: sender,
        to: receiveMail,
        subject: inputTitle,
        text: contents
    };
    let formData = new FormData();
    formData.append("email", JSON.stringify(mail));

    let files = fileInput.files;
    for (let i = 0; i < files.length; i++) {
        formData.append("files", files[i]);
    }
    if (!receiveMail.endsWith("@end2end.site")) {
        alert("외부 발신은 현재 제한되어있습니다.");
        return;
    }

    $.ajax({
        url: "http://34.70.179.192/mail/send",
        type: "POST",
        data: formData,
        processData: false,
        contentType: false,
    }).done(function (resp) {
        alert("메일 전송 완료!");
        location.reload();
    })
});

dropArea.addEventListener("click", () => {
    fileInput.click();
});

fileInput.addEventListener("change", (e) => {
    handleFiles(e.target.files);
});

dropArea.addEventListener("dragenter", (e) => {
    e.preventDefault();
    dropArea.classList.add("active");
});
dropArea.addEventListener("dragover", (e) => {
    e.preventDefault();
});
dropArea.addEventListener("dragleave", (e) => {
    dropArea.classList.remove("active");
});
dropArea.addEventListener("drop", (e) => {
    e.preventDefault();
    dropArea.classList.remove("active");
    const files = e.dataTransfer.files;
    handleFiles(files);
});

function handleFiles(files) {
    if (files.length > 0) {
        let fileNames = [];
        let totalSize = 0;

        for (let i = 0; i < files.length; i++) {
            fileNames.push(files[i].name);
            totalSize += files[i].size;
        }

        fileInfo.textContent = fileNames.join(", ");
        const sizeInMB = (totalSize / (1024 * 1024)).toFixed(2);

        if (sizeInMB > 30) {
            alert("파일 총 용량이 30MB를 초과했습니다. 다시 선택해 주세요.");
            fileInfo.textContent = "파일 없음";
            fileSizeEl.textContent = "0/30 MB";
            fileInput.value = "";
            return;
        }
        fileSizeEl.textContent = `${sizeInMB}MB / 30MB`;
    } else {
        fileInfo.textContent = "선택된 파일 없음";
        fileSizeEl.textContent = "0/30 MB";
    }
}
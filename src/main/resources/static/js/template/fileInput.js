$("document").on("dragover", (event) => {
    event.preventDefault();
});

$("document").on("drop", (event) => {
    event.preventDefault();
});

$("#drop-file").on("dragover", (event) => {
    event.preventDefault();
    $("#drop-file").css("border-color", "blue");
});

$("#drop-file").on("dragleave", (event) => {
    event.preventDefault();
    $("#drop-file").css("border-color", "black");
});

$("#drop-file").on("drop", (event) => {
    event.preventDefault();
    const files = event.originalEvent.dataTransfer.files;
    updateFile(files);
});

const updateFile = (newFiles) => {
    const fileInput = $("input[name='files']");
    const files = fileInput[0].files;

    let totalFileSize = 0;
    const dataTransfer = new DataTransfer();
    for (let i = 0; i < files.length; i++) {
        dataTransfer.items.add(files[i]);
        totalFileSize += files[i].size;
    }

    for (let i = 0; i < newFiles.length; i++) {
        dataTransfer.items.add(newFiles[i]);
        totalFileSize += newFiles[i].size;
    }

    const parseTotalFileSize = parseByteToMB(totalFileSize);
    console.log(parseTotalFileSize);

    if(parseTotalFileSize * 100 < 200 * 100) {
        $("#totalFileSize").html(parseByteToMB(totalFileSize) + "MB");
        fileInput[0].files = dataTransfer.files;

        for (let i = 0; i < dataTransfer.files.length; i++) {
            fileList(dataTransfer.files[i]);
        }
    } else {
        alert("입력 가능한 사이즈를 초과했습니다.");
    }

    $("#drop-file").css("border-color", "black");
};

const deleteFile = (target) => {
    const fileInput = $("input[name='files']");
    const files = fileInput[0].files;

    let totalFileSize = 0;
    const dataTransfer = new DataTransfer();

    for (let i = 0; i < files.length; i++) {
        if (files[i].name !== target.name) {
            dataTransfer.items.add(files[i]);
            totalFileSize += files[i].size;
        }
    }
    $("#totalFileSize").html(parseByteToMB(totalFileSize) + "MB");
    fileInput[0].files = dataTransfer.files;
};

const fileList = (file) => {
    const deleteButton = $("<button>").html("x").addClass("delete-file");

    const li = $("<li>").append(
        $("<div>")
            .addClass("file-list-item")
            .html(
                "<span>" +
                file.name +
                "</span><span>(" +
                parseByteToMB(file.size) +
                "MB)</span>"
            )
            .append(deleteButton)
    );
    $("#file-list").append(li);

    deleteButton.on("click", (event) => {
        deleteFile(file);
        event.target.closest("li").remove();
    });
};

const parseByteToMB = (size) =>
    Math.round((size / (1024 * 1024)) * 100) / 100;
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<link rel="stylesheet" href="/css/template/fileInput.css" />
<style>
  /* 파일 입력 폼 스타일 */
  .file-form {
    margin: 10px 0;
  }

  .file-add {
    display: flex;
    align-items: center;
    gap: 15px;
  }

  .file-add span:first-child {
    padding: 8px 15px;
    border-radius: 4px;
    font-size: 0.9em;
  }

  .drop-form {
    flex: 1;
    padding: 10px 15px;
    border: 2px dashed var(--md-sys-color-surface);
    border-radius: 4px;
    display: flex;
    justify-content: space-between;
    align-items: center;
    min-height: 40px;
  }

  #file-disc {
    color: var(--md-sys-color-on-surface-variant);
    font-size: 0.9em;
  }

  .drop-form span:last-child {
    color: var(--md-sys-color-on-surface-variant);
    font-size: 0.85em;
  }

  .file-list-form {
    margin-top: 10px;
  }

  #file-list {
    list-style: none;
    padding: 0;
    margin: 0;
  }

  #file-list li {
    display: flex;
    justify-content: space-between;
    align-items: center;
    padding: 8px 10px;
    margin: 5px 0;
    border-radius: 4px;
    font-size: 0.9em;
  }

  #file-list li:hover {
    background-color: var(--md-custom-read-color);
  }

  .delete-file {
    cursor: pointer;
    color: var(--md-sys-color-surface);
    padding: 2px 8px;
  }
</style>
<div class="file-form">
  <input type="file" name="files" multiple style="display: none" />
  <div>
    <div class="file-add">
      <span>파일추가</span>
      <div class="drop-form" id="drop-file">
        <span id="file-disc">이곳에 파일을 놓아주세요</span>
        <span> <span id="totalFileSize">0</span><span>/200MB</span></span>
      </div>
    </div>
    <div class="file-list-form">
      <ul id="file-list">
      </ul>
    </div>
  </div>
</div>
<script src="/js/template/fileInput.js" type="text/javascript"></script>
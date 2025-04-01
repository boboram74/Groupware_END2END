<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<jsp:include page="/WEB-INF/views/template/header.jsp" />
<div>
    ${titleIcon} ${title}
</div>
<jsp:include page="/WEB-INF/views/template/footer.jsp" />

public String 어쩌구(Model modal) {
    model.setAttribute("title", "전사 게시판");
}
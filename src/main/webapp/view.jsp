<%@ page pageEncoding="UTF-8" %>
<%@ include file="functions/get-user.jsp" %>
<%@ include file="functions/get-code.jsp" %>
<% if (request.getAttribute("code") == null) { %>
    <jsp:forward page="404.jsp"></jsp:forward>
<% } else if (request.getAttribute("owner") == null) { %>
    <jsp:forward page="500.jsp"></jsp:forward>
<% } else { %>
    <jsp:include page="includes/common.jsp"></jsp:include>
<% } %>

<%@ page pageEncoding="UTF-8" %>
<% if (request.getParameter("id") == null) { %>
    <%@ include file="functions/require-login.jsp" %>
    <%
    request.setAttribute("target", request.getAttribute("user"));
    %>
<% } else { %>
    <%@ include file="functions/get-user.jsp" %>
    <%@ include file="functions/get-target.jsp" %>
<% } %>
<% if (request.getAttribute("target") == null) { %>
    <jsp:forward page="404.jsp"></jsp:forward>
<% } else { %>
    <jsp:include page="includes/common.jsp"></jsp:include>
<% } %>

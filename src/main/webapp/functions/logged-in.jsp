<%@ include file="get-user.jsp" %>
<%
if (request.getAttribute("user") != null) {
    response.sendRedirect(".");
    return ;
}
%>

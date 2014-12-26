<%@ page pageEncoding="UTF-8" %>
<%
Cookie cookie = new Cookie("token", "deleted");
cookie.setMaxAge(0);
response.addCookie(cookie);
%>
<jsp:include page="includes/common.jsp"></jsp:include>

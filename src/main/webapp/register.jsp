<%@ page pageEncoding="UTF-8" %>
<%@ page import="java.util.*" %>
<%@ page import="java.util.regex.*" %>
<%@ page import="com.sorakasugano.pasteboard.*" %>
<%@ include file="functions/logged-in.jsp" %>
<%
if ("POST".equalsIgnoreCase(request.getMethod())) {
    String id = request.getParameter("username");
    if (id != null && Pattern.matches("\\w+", id)) {
        Setter setter = new Setter();
        setter.type = "user";
        setter.id = id;
        setter.object = new Extractor(request).extract("password", "email");
        setter.replace = false;
        request.setAttribute("success", Adapter.invoke(setter));
    }
}
%>
<jsp:include page="includes/common.jsp">
    <jsp:param name="controller" value="1" />
</jsp:include>

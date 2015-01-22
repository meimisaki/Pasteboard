<%@ page pageEncoding="UTF-8" %>
<%@ page import="java.util.*" %>
<%@ page import="com.sorakasugano.pasteboard.*" %>
<%@ include file="functions/get-user.jsp" %>
<%@ include file="functions/get-code.jsp" %>
<%
Map<String, String> code = (Map<String, String>)request.getAttribute("code");
Map<String, String> user = (Map<String, String>)request.getAttribute("user");
Map<String, String> owner = (Map<String, String>)request.getAttribute("owner");
%>
<% if (code == null) { %>
    <jsp:forward page="404.jsp"></jsp:forward>
<% } else if (owner == null) { %>
    <jsp:forward page="500.jsp"></jsp:forward>
<% } else { %>
    <%
    if ("POST".equalsIgnoreCase(request.getMethod())) {
        if (user == null) {
            response.sendRedirect("login.jsp");
            return ;
        }
        Setter setter = new Setter();
        setter.owner = "code:" + code.get("id");
        setter.type = "comment";
        setter.id = UUID.randomUUID().toString();
        Map<String, String> object = new Extractor(request).extract("text");
        object.put("user", user.get("id"));
        setter.object = object;
        Adapter.invoke(setter);
    }
    %>
    <jsp:include page="includes/common.jsp">
        <jsp:param name="controller" value="1" />
    </jsp:include>
<% } %>

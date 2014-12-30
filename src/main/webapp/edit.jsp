<%@ page pageEncoding="UTF-8" %>
<%@ page import="java.util.*" %>
<%@ include file="functions/require-login.jsp" %>
<% if (request.getParameter("id") != null) { %>
    <%@ include file="functions/get-code.jsp" %>
    <%
    Map<String, String> user = (Map<String, String>)request.getAttribute("user");
    Map<String, String> code = (Map<String, String>)request.getAttribute("code");
    Map<String, String> owner = (Map<String, String>)request.getAttribute("owner");
    %>
    <% if (code == null) { %>
        <jsp:forward page="404.jsp"></jsp:forward>
    <% } else if (owner == null) { %>
        <jsp:forward page="500.jsp"></jsp:forward>
    <% } else if (!user.get("id").equals(owner.get("id"))) { %>
        <jsp:forward page="403.jsp"></jsp:forward>
    <% } %>
<% } %>
<%
if ("POST".equalsIgnoreCase(request.getMethod())) {
    String uid = ((Map<String, String>)request.getAttribute("user")).get("id");
    String cid = request.getParameter("id");
    cid = cid == null ? UUID.randomUUID().toString() : cid;
    request.setAttribute("cid", cid);
    Setter setter = new Setter();
    setter.owner = "user:" + uid;
    setter.type = "code";
    setter.id = cid;
    Map<String, String> object = new Extractor(request).extract("title", "description", "source", "language", "tags");
    object.put("owner", uid);
    setter.object = object;
    Adapter.invoke(setter);
}
%>
<jsp:include page="includes/common.jsp">
    <jsp:param name="controller" value="1" />
</jsp:include>

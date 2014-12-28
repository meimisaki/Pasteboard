<%@ page pageEncoding="UTF-8" %>
<%@ page import="java.util.*" %>
<%@ page import="com.sorakasugano.pasteboard.*" %>
<%
Map<String, String> target = (Map<String, String>)request.getAttribute("target");
Selector selector = new Selector();
selector.type = "user";
selector.id = target.get("id");
selector.subtype = "code";
selector.limit = 10;
request.setAttribute("list", Adapter.invoke(selector));
%>
<h3 class="tab-header">
    <i class="fa fa-book fa-fw"></i>
    Library
</h3>
<jsp:include page="list.jsp"></jsp:include>

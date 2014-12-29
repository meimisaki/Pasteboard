<%@ page pageEncoding="UTF-8" %>
<%@ page import="java.util.*" %>
<%@ page import="com.sorakasugano.pasteboard.*" %>
<%
final int limit = 10;
int pageNumber;
try {
    pageNumber = Math.max(0, Integer.parseInt(request.getParameter("page")));
}
catch (Exception except) {
    pageNumber = 0;
}
Map<String, String> target = (Map<String, String>)request.getAttribute("target");
Selector selector = new Selector();
selector.type = "user";
selector.id = target.get("id");
selector.subtype = "star";
selector.alias = "code";
selector.offset = pageNumber * limit;
selector.limit = limit + 1;
List<Map<String, String>> list = Adapter.invoke(selector);
request.setAttribute("list", list.subList(0, Math.min(limit, list.size())));
request.setAttribute("page", new Integer(pageNumber));
request.setAttribute("has-previous", new Boolean(list.size() > limit));
request.setAttribute("has-next", new Boolean(pageNumber > 0));
%>
<h3 class="tab-header">
    <i class="fa fa-star fa-fw"></i>
    Starred
</h3>
<jsp:include page="list.jsp"></jsp:include>

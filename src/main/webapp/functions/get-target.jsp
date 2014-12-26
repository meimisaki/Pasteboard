<%@ page import="java.util.*" %>
<%@ page import="redis.clients.jedis.*" %>
<%@ page import="com.sorakasugano.pasteboard.*" %>
<%
String id = request.getParameter("id");
if (id != null) {
    Getter getter = new Getter();
    getter.type = "user";
    getter.id = id;
    Map<String, String> target = Adapter.invoke(getter);
    request.setAttribute("target", target);
}
%>

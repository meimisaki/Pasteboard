<%@ page import="java.util.*" %>
<%@ page import="redis.clients.jedis.*" %>
<%@ page import="com.sorakasugano.pasteboard.*" %>
<%
String id = request.getParameter("id");
if (id != null) {
    Getter getter = new Getter();
    getter.type = "code";
    getter.id = id;
    Map<String, String> code = Adapter.invoke(getter);
    request.setAttribute("code", code);
    if (code != null) {
        id = code.get("owner");
        if (id != null) {
            getter.type = "user";
            getter.id = id;
            Map<String, String> owner = Adapter.invoke(getter);
            request.setAttribute("owner", owner);
        }
    }
}
%>

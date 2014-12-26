<%@ page import="java.util.*" %>
<%@ page import="redis.clients.jedis.*" %>
<%@ page import="com.sorakasugano.pasteboard.*" %>
<%
String token = null;
for (Cookie cookie : request.getCookies()) {
    if (cookie.getName().equals("token")) {
        token = cookie.getValue();
        break;
    }
}
if (token != null) {
    Reader<String> reader = new Reader<String>() {
        @Override
        public String call(Jedis jedis) throws Exception {
            return jedis.get(type + ":" + id);
        }
    };
    reader.type = "token";
    reader.id = token;
    String id = Adapter.invoke(reader);
    if (id != null) {
        Getter getter = new Getter();
        getter.type = "user";
        getter.id = id;
        Map<String, String> user = Adapter.invoke(getter);
        request.setAttribute("user", user);
    }
}
%>

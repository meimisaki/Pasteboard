<%@ page pageEncoding="UTF-8" %>
<%@ page import="java.util.*" %>
<%@ page import="redis.clients.jedis.*" %>
<%@ page import="com.sorakasugano.pasteboard.*" %>
<%@ include file="functions/logged-in.jsp" %>
<%
if ("POST".equalsIgnoreCase(request.getMethod())) {
    String id = request.getParameter("username");
    String password = request.getParameter("password");
    if (id != null && password != null) {
        Getter getter = new Getter();
        getter.type = "user";
        getter.id = id;
        Map<String, String> user = Adapter.invoke(getter);
        if (password.equals(user.get("password"))) {
            String uuid = UUID.randomUUID().toString();
            final String username = id;
            final int maxAge = 60 * 60 * 24;
            Writer writer = new Writer() {
                @Override
                public String call(Jedis jedis) throws Exception {
                    return jedis.setex(type + ":" + id, maxAge, username);
                }
            };
            writer.type = "token";
            writer.id = uuid;
            Adapter.invoke(writer);
            Cookie cookie = new Cookie("token", uuid);
            String remember = request.getParameter("remember");
            if (remember != null && remember.equals("1")) {
                cookie.setMaxAge(maxAge);
            }
            response.addCookie(cookie);
            request.setAttribute("success", new Boolean(true));
        }
    }
}
%>
<jsp:include page="includes/common.jsp"></jsp:include>

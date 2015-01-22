<%@ page import="java.util.*" %>
<%@ page import="redis.clients.jedis.*" %>
<%@ page import="com.sorakasugano.pasteboard.*" %>
<%
request.setAttribute("user", DBUtils.self(request));
%>

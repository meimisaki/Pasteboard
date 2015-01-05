<%@ page pageEncoding="UTF-8" %>
<%@ page import="java.util.*" %>
<%@ page import="redis.clients.jedis.*" %>
<%@ page import="com.sorakasugano.pasteboard.*" %>
<%
Randomizer randomizer = new Randomizer();
randomizer.subtype = "user";
String id = Adapter.invoke(randomizer);
response.sendRedirect(".?id=" + (id == null ? "" : id));
%>

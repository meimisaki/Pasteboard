<%@ page pageEncoding="UTF-8" %>
<%@ page import="java.util.*" %>
<%@ page import="com.sorakasugano.pasteboard.*" %>
<%@ page isELIgnored="false" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%
Map<String, String> target = (Map<String, String>)request.getAttribute("target");
Selector selector = new Selector();
selector.type = "user";
selector.id = target.get("id");
selector.limit = 20;
selector.subtype = "code";
request.setAttribute("posts", Adapter.invoke(selector));
selector.subtype = "star";
selector.alias = "code";
request.setAttribute("stars", Adapter.invoke(selector));
%>
<h3 class="tab-header">
    <i class="fa fa-home fa-fw"></i>
    Home
</h3>
<div class="row">
    <div class="col-md-6">
        <div class="panel panel-default">
            <div class="panel-heading">
                <span class="panel-title">
                    <i class="fa fa-book fa-fw text-muted"></i>
                    Recent Posts
                </span>
            </div>
            <div class="list-group">
                <c:forEach items="${posts}" var="item">
                    <a href="view.jsp?id=${item.id}" class="list-group-item">
                        <i class="fa fa-bookmark fa-fw"></i>
                        <c:out value="${item.title}" />
                    </a>
                </c:forEach>
            </div>
        </div>
    </div>
    <div class="col-md-6">
        <div class="panel panel-default">
            <div class="panel-heading">
                <span class="panel-title">
                    <i class="fa fa-star fa-fw text-muted"></i>
                    Recent Stars
                </span>
            </div>
            <div class="list-group">
                <c:forEach items="${stars}" var="item">
                    <a href="view.jsp?id=${item.id}" class="list-group-item">
                        <i class="fa fa-heart fa-fw"></i>
                        <c:out value="${item.title}" />
                    </a>
                </c:forEach>
            </div>
        </div>
    </div>
</div>

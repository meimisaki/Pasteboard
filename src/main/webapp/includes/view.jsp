<%@ page pageEncoding="UTF-8" %>
<%@ page import="java.util.*" %>
<%@ page import="redis.clients.jedis.*" %>
<%@ page import="com.sorakasugano.pasteboard.*" %>
<%@ page isELIgnored="false" %>
<%@ taglib uri="/utils" prefix="u" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%
Map<String, String> code = (Map<String, String>)request.getAttribute("code");
Map<String, String> user = (Map<String, String>)request.getAttribute("user");
Map<String, String> owner = (Map<String, String>)request.getAttribute("owner");
final String cid = code == null ? null : code.get("id");
final String uid = user == null ? null : user.get("id");
final String oid = owner == null ? null : owner.get("id");
boolean self = uid != null && oid != null && uid.equals(oid);
Selector selector = new Selector();
selector.type = "code";
selector.id = cid;
selector.subtype = "comment";
List<Map<String, String>> comments = Adapter.invoke(selector);
Collections.reverse(comments);
request.setAttribute("comments", comments);
%>
<script type="text/javascript" src="bower_components/highlightjs/highlight.pack.js"></script>
<link rel="stylesheet" type="text/css" href="bower_components/highlightjs/styles/default.css" />
<div class="container">
    <form>
        <h2 class="breadcrumb page-header">
            <li><a href=".?id=${owner.id}">${owner.id}</a></li>
            <li><a href="view.jsp?id=${code.id}"><c:out value="${code.title}" /></a></li>
            <% if (self) { %>
                <a href="edit.jsp?id=${code.id}" class="btn btn-default pull-right">
                    <i class="fa fa-pencil fa-fw"></i>
                    Edit
                </a>
            <% } else if (user != null) { %>
                <%
                Reader<Boolean> reader = new Reader<Boolean>() {
                    @Override
                    public Boolean call(Jedis jedis) throws Exception {
                        return jedis.zrank("user:" + uid + ":star-list", cid) != null;
                    }
                };
                boolean star = Adapter.invoke(reader);
                %>
                <button type="submit" class="btn btn-default pull-right">
                    <i class="fa fa-star<%= star ? "-o" : "" %> fa-fw"></i>
                    <%= star ? "Unstar" : "Star" %>
                </button>
            <% } %>
        </h2>
    </form>
    <div class="page-body">
        <p><c:out value="${code.description}" /></p>
        <pre><code><c:out value="${code.source}" /></code></pre>
        <%
        String tags = code.get("tags");
        if (tags != null) tags = tags.trim();
        %>
        <% if (tags != null && tags.length() != 0) { %>
            <% for (String tag : tags.split("\n")) { %>
                <a href="#" class="btn btn-xs btn-default tag">
                    <i class="fa fa-tag fa-fw"></i>
                    <%= tag %>
                </a>
            <% } %>
        <% } %>
        <div class="divider"></div>
        <div class="row">
            <div class="col-md-8 col-md-offset-2">
                <h4>
                    <i class="fa fa-comments fa-fw"></i>
                    Comments
                </h4>
                <c:forEach items="${comments}" var="comment">
                    <div class="comment">
                        <img src="" title="avatar" class="avatar" />
                        <div class="content">
                            <h5 class="comment-header">
                                ${comment.user}
                                <span class="text-muted">
                                    <c:out value="${fn:substring(comment.modified_time, 0, 10)}" />
                                </span>
                            </h5>
                            <div class="comment-body">
                                <c:out value="${comment.text}" />
                            </div>
                        </div>
                    </div>
                </c:forEach>
                <% if (user == null) { %>
                    <div class="divider"></div>
                    Please <a href="login.jsp">login</a> to comment
                <% } else { %>
                    <form class="comment" action="view.jsp?id=${code.id}" method="POST">
                        <textarea class="form-control" name="text" placeholder="Write your comment"></textarea>
                        <div class="comment-footer">
                            <button type="submit" class="btn btn-primary pull-right">
                                <i class="fa fa-check fa-fw"></i>
                                Comment
                            </button>
                        </div>
                    </form>
                <% } %>
            </div>
        </div>
    </div>
    <div class="page-footer"></div>
</div>
<script type="text/javascript">
$(document).ready(function () {
    $.getJSON('langs.json', function (langs) {
        var val = langs[${u:JSONEncode(code.language)}];
        val && $('pre code').addClass(val[0]);
        hljs.initHighlighting();
    });
});
</script>

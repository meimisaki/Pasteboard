<%@ page pageEncoding="UTF-8" %>
<%@ page import="java.util.*" %>
<%@ page import="redis.clients.jedis.*" %>
<%@ page import="com.sorakasugano.pasteboard.*" %>
<%@ page isELIgnored="false" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%
Map<String, String> code = (Map<String, String>)request.getAttribute("code");
Map<String, String> user = (Map<String, String>)request.getAttribute("user");
Map<String, String> owner = (Map<String, String>)request.getAttribute("owner");
final String cid = code == null ? null : code.get("id");
final String uid = user == null ? null : user.get("id");
final String oid = owner == null ? null : owner.get("id");
boolean self = uid != null && oid != null && uid.equals(oid);
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
            <% } else { %>
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
        String tags = code.get("tags").trim();
        %>
        <% if (tags.length() != 0) { %>
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
                <div class="comment">
                    <img src="" title="avatar" class="avatar" />
                    <div class="content">
                        <h5 class="comment-header">
                            @NAME
                            <span class="text-muted">
                                @DATE
                            </span>
                        </h5>
                        <div class="comment-body">
                            @COMMENT-BODY
                        </div>
                    </div>
                </div>
                <form class="comment">
                    <textarea class="form-control" placeholder="Write your comment"></textarea>
                    <div class="comment-footer">
                        <button type="submit" class="btn btn-primary pull-right">
                            <i class="fa fa-check fa-fw"></i>
                            Comment
                        </button>
                    </div>
                </form>
            </div>
        </div>
    </div>
    <div class="page-footer"></div>
</div>
<script type="text/javascript">
hljs.initHighlightingOnLoad();
</script>

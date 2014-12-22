<%@ page pageEncoding="UTF-8" %>
<h3 class="tab-header">
    <i class="fa fa-star fa-fw"></i>
    Starred
</h3>
<% request.setAttribute("list", new Object[2]); %>
<jsp:include page="list.jsp"></jsp:include>

<%@ page pageEncoding="UTF-8" %>
<h3 class="tab-header">
    <i class="fa fa-book fa-fw"></i>
    Library
</h3>
<% request.setAttribute("list", new Object[3]); %>
<jsp:include page="list.jsp"></jsp:include>

<%@ page pageEncoding="UTF-8" %>
<%@ page import="java.util.*" %>
<%@ page isELIgnored="false" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%
Map<String, String> user = (Map<String, String>)request.getAttribute("user");
Map<String, String> target = (Map<String, String>)request.getAttribute("target");
String uid = user == null ? null : user.get("id");
String tid = target == null ? null : target.get("id");
boolean self = uid != null && tid != null && uid.equals(tid);
%>
<div class="container">
    <h2 class="page-header">
        <a href=".?id=${target.id}">${target.id}</a>
        <% if (self) { %>
            <a href="edit.jsp" class="btn btn-primary pull-right">
                <i class="fa fa-cloud-upload fa-fw"></i>
                Post code
            </a>
        <% } %>
    </h2>
    <div class="row page-body">
        <div class="col-md-3 col-sm-4">
            <div class="row">
                <div class="col-sm-12 col-xs-4 text-center">
                    <div class="visible-xs">
                        <img src="" title="avatar" class="avatar avatar-xs" />
                    </div>
                    <div class="row hidden-xs">
                        <div class="col-sm-6 col-sm-offset-3">
                            <div class="aspect-1-1">
                                <div class="content">
                                    <img src="" title="avatar" class="avatar" />
                                </div>
                            </div>
                        </div>
                    </div>
                    <a href="mailto:${target.email}" class="email">
                        <c:out value="${target.email}" />
                    </a>
                </div>
                <div class="col-xs-12 hidden-xs">
                    <div class="divider"></div>
                </div>
                <div class="col-sm-12 col-xs-8">
                    <div class="list-group" role="sidebar">
                        <a href=".?id=${target.id}" class="list-group-item">
                            <i class="fa fa-home fa-fw"></i>
                            &nbsp;Home
                        </a>
                        <a href="?id=${target.id}&amp;tab=library" class="list-group-item">
                            <i class="fa fa-book fa-fw"></i>
                            &nbsp;Library
                        </a>
                        <a href="?id=${target.id}&amp;tab=starred" class="list-group-item">
                            <i class="fa fa-star fa-fw"></i>
                            &nbsp;Starred
                        </a>
                        <% if (self) { %>
                            <a href="#" class="list-group-item">
                                <i class="fa fa-cog fa-fw"></i>
                                &nbsp;Settings
                            </a>
                        <% } %>
                    </div>
                </div>
            </div>
        </div>
        <div class="col-md-9 col-sm-8">
            <% String tab = request.getParameter("tab"); %>
            <% if (tab == null || !(tab.equals("library") || tab.equals("starred"))) tab = "home"; %>
            <% request.setAttribute("tab", tab); %>
            <% tab += ".jsp"; %>
            <jsp:include page="<%= tab %>"></jsp:include>
        </div>
    </div>
</div>

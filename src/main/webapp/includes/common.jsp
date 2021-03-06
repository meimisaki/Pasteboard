<%@ page pageEncoding="UTF-8" %>
<%
Object user = request.getAttribute("user");
%>
<!DOCTYPE html>
<html ng-app="App">
<head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1" />
    <meta http-equiv="X-UA-Compatible" content="IE=edge, chrome=1" />
    <title>Pasteboard</title>
    <link rel="stylesheet" type="text/css" href="bower_components/bootstrap/dist/css/bootstrap.min.css" />
    <link rel="stylesheet" type="text/css" href="bower_components/font-awesome/css/font-awesome.min.css" />
    <link rel="stylesheet" type="text/css" href="styles/main.css" />
    <script src="bower_components/jquery/dist/jquery.min.js"></script>
    <script src="bower_components/bootstrap/dist/js/bootstrap.min.js"></script>
</head>
<body>
    <div class="wrap">
        <nav class="navbar" role="navigation">
            <div class="container">
                <div class="navbar-header">
                    <a href="." class="navbar-brand">
                        <b>Pasteboard</b>
                    </a>
                    <form class="navbar-form navbar-left" role="search">
                        <div class="input-group">
                            <span class="input-group-addon">
                                <i class="fa fa-search fa-fw"></i>
                            </span>
                            <input type="text" class="form-control" name="keyword" placeholder="Search" />
                        </div>
                    </form>
                    <button type="button" class="navbar-toggle collapsed" data-toggle="collapse" data-target=".navbar-collapse">
                        <i class="fa fa-bars fa-lg"></i>
                    </button>
                </div>
                <div class="navbar-collapse collapse">
                    <ul class="nav navbar-nav">
                        <li><a href="random-user.jsp" title="random author">
                            <i class="fa fa-user fa-lg fa-fw"></i>
                            <span class="visible-xs">Random author</span>
                        </a></li>
                    </ul>
                    <ul class="nav navbar-nav navbar-right">
                        <% if (user == null) { %>
                            <li><a href="login.jsp" title="login" rel="login">
                                <i class="fa fa-sign-in fa-lg fa-fw"></i>
                                Login
                            </a></li>
                        <% } else { %>
                            <li><a href="javascript:;" title="logout" rel="logout" ng-click="logout()">
                                <i class="fa fa-sign-out fa-lg fa-fw"></i>
                                Logout
                            </a></li>
                        <% } %>
                    </ul>
                </div>
            </div>
        </nav>
        <% String path = request.getContextPath(); %>
        <% String uri = request.getRequestURI().substring(path.length() + 1); %>
        <% if (uri.length() == 0) uri = "index.jsp"; %>
        <jsp:include page="<%= uri %>"></jsp:include>
    </div>
    <footer class="footer">
        <span class="text-muted">
            &copy; 2014 そらかすがの &amp; ZYZ
        </span>
    </footer>
    <script src="bower_components/angular/angular.min.js"></script>
    <script src="scripts/app.js"></script>
    <% if (request.getParameter("controller") != null) { %>
        <script src="scripts/controllers/<%= uri.substring(0, uri.length() - 4) %>.js"></script>
    <% } %>
</body>
</html>

<%@ page pageEncoding="UTF-8" %>
<%@ page import="java.util.*" %>
<%@ page import="java.util.regex.*" %>
<%@ page import="com.sorakasugano.pasteboard.*" %>
<%
boolean post = "POST".equalsIgnoreCase(request.getMethod());
boolean valid = true;
boolean success = false;
if (post) {
    String id = request.getParameter("username");
    valid = id == null ? false : Pattern.matches("\\w+", id);
    if (valid) {
        Setter setter = new Setter();
        setter.type = "user";
        setter.id = id;
        Map<String, String> object = new HashMap<String, String>();
        object.put("password", request.getParameter("password"));
        object.put("email", request.getParameter("email"));
        setter.object = object;
        setter.replace = false;
        success = Adapter.invoke(setter);
    }
}
%>
<div class="container" ng-controller="registerCtrl" centering>
    <div class="row">
        <div class="col-md-6 col-md-offset-3">
            <div class="panel panel-default">
                <div class="panel-heading">
                    <span class="panel-title">
                        Register
                    </span>
                </div>
                <div class="panel-body">
                    <% if (post && success) { %>
                        <script type="text/javascript">
                        setTimeout(function() {
                            window.location.href = './login.jsp';
                        }, 3000);
                        </script>
                        Register success! You will be redirected to
                        <a href="login.jsp" rel="home">login page</a>
                        in 3 seconds.
                    <% } else { %>
                        <form action="register.jsp" method="POST">
                            <div class="form-group">
                                <label class="control-label" for="username">Username</label>
                                <input type="text" class="form-control" id="username" name="username" placeholder="Username" validator="validateUsername" hint="Username should only contain A-Z, a-z, 0-9 and underscore" />
                            </div>
                            <div class="form-group">
                                <label class="control-label" for="email">Email</label>
                                <input type="email" class="form-control" id="email" name="email" placeholder="Email" validator="validateEmail" />
                            </div>
                            <div class="form-group">
                                <label class="control-label" for="password">Password</label>
                                <input type="password" class="form-control" id="password" name="password" placeholder="Password" ng-model="password" validator="validatePassword" hint="Password must be at least 6 characters long" />
                            </div>
                            <div class="form-group">
                                <label class="control-label" for="repeatPassword">Repeat password</label>
                                <input type="password" class="form-control" id="repeatPassword" placeholder="Repeat password" validator="validatePassword" />
                            </div>
                            <button type="submit" class="btn btn-primary btn-block">
                                Submit
                                <i class="fa fa-rocket fa-fw"></i>
                            </button>
                        </form>
                    <% } %>
                </div>
            </div>
        </div>
    </div>
</div>

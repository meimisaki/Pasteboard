<%@ page pageEncoding="UTF-8" %>
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
                    <%
                    Boolean success = (Boolean)request.getAttribute("success");
                    success = success != null && success;
                    %>
                    <% if (success) { %>
                        <script type="text/javascript">
                        setTimeout(function() {
                            window.location.href = './login.jsp';
                        }, 3000);
                        </script>
                        Register success! You will be redirected to
                        <a href="login.jsp" rel="login">login page</a>
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

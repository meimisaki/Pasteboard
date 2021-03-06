<%@ page pageEncoding="UTF-8" %>
<div class="container" centering>
    <div class="row">
        <div class="col-md-4 col-md-offset-4">
            <div class="panel panel-default">
                <div class="panel-heading">
                    <span class="panel-title">
                        Pasteboard
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
                            window.location.href = '.';
                        }, 3000);
                        </script>
                        Login success! You will be redirected to
                        <a href="." rel="home">your homepage</a>
                        in 3 seconds.
                    <% } else { %>
                        <form action="login.jsp" method="POST">
                            <div class="form-group">
                                <div class="input-group">
                                    <span class="input-group-addon">
                                        <i class="fa fa-at fa-fw"></i>
                                    </span>
                                    <input type="text" class="form-control" name="username" placeholder="Username" autofocus="autofocus" />
                                </div>
                            </div>
                            <div class="form-group">
                                <div class="input-group">
                                    <span class="input-group-addon">
                                        <i class="fa fa-lock fa-fw"></i>
                                    </span>
                                    <input type="password" class="form-control" name="password" placeholder="Password" />
                                </div>
                            </div>
                            <div class="checkbox">
                                <label>
                                    <input type="checkbox" name="remember" value="1" />
                                    Remember me
                                </label>
                                <label class="pull-right">
                                    <a href="register.jsp">Register</a>
                                </label>
                            </div>
                            <button type="submit" class="btn btn-primary btn-block">
                                Login
                                <i class="fa fa-arrow-circle-right fa-fw"></i>
                            </button>
                        </form>
                    <% } %>
                </div>
            </div>
        </div>
    </div>
</div>

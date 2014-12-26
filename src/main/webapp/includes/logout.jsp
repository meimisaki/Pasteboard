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
                    <script type="text/javascript">
                    setTimeout(function() {
                        window.location.href = './login.jsp';
                    }, 3000);
                    </script>
                    Logout success! You will be redirected to
                    <a href="login.jsp" rel="login">login page</a>
                    in 3 seconds.
                </div>
            </div>
        </div>
    </div>
</div>

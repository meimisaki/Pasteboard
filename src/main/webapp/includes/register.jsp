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
                    <form>
                        <div class="form-group">
                            <label class="control-label" for="username">Username</label>
                            <input type="text" class="form-control" id="username" name="username" placeholder="Username" validator="validateUsername" />
                        </div>
                        <div class="form-group">
                            <label class="control-label" for="email">Email</label>
                            <input type="email" class="form-control" id="email" name="email" placeholder="Email" validator="validateEmail" />
                        </div>
                        <div class="form-group">
                            <label class="control-label" for="password">Password</label>
                            <input type="password" class="form-control" id="password" name="password" placeholder="Password" ng-model="password" validator="validatePassword" />
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
                </div>
            </div>
        </div>
    </div>
</div>

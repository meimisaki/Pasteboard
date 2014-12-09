<%@ page pageEncoding="UTF-8" %>
<div class="container">
    <h2 class="page-header">
        <a href=".">@AUTHOR</a>
        <a href="edit.jsp" class="btn btn-primary pull-right">
            <i class="fa fa-cloud-upload fa-fw"></i>
            Post code
        </a>
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
                    <a href="mailto:" class="email">@EMAIL</a>
                </div>
                <div class="col-xs-12 hidden-xs">
                    <div class="divider"></div>
                </div>
                <div class="col-sm-12 col-xs-8">
                    <div class="list-group" role="sidebar">
                        <a href="#" class="list-group-item">
                            <i class="fa fa-home fa-fw"></i>
                            &nbsp;Home
                        </a>
                        <a href="#" class="list-group-item">
                            <i class="fa fa-book fa-fw"></i>
                            &nbsp;Library
                        </a>
                        <a href="#" class="list-group-item">
                            <i class="fa fa-star fa-fw"></i>
                            &nbsp;Starred
                        </a>
                        <a href="#" class="list-group-item">
                            <i class="fa fa-cog fa-fw"></i>
                            &nbsp;Settings
                        </a>
                    </div>
                </div>
            </div>
        </div>
        <div class="col-md-9 col-sm-8">
            <div class="row">
                <div class="col-md-6">
                    <div class="panel panel-default">
                        <div class="panel-heading">
                            <span class="panel-title">
                                <i class="fa fa-book fa-fw text-muted"></i>
                                Recent Posts
                            </span>
                        </div>
                        <div class="list-group">
                            <a href="view.jsp" class="list-group-item">
                                <i class="fa fa-bookmark fa-fw"></i>
                                Merge Sort
                            </a>
                            <a href="view.jsp" class="list-group-item">
                                <i class="fa fa-bookmark fa-fw"></i>
                                Linear Select
                            </a>
                        </div>
                    </div>
                </div>
                <div class="col-md-6">
                    <div class="panel panel-default">
                        <div class="panel-heading">
                            <span class="panel-title">
                                <i class="fa fa-star fa-fw text-muted"></i>
                                Recent Stars
                            </span>
                        </div>
                        <div class="list-group">
                            <a href="view.jsp" class="list-group-item">
                                <i class="fa fa-heart fa-fw"></i>
                                Link Cut Tree
                            </a>
                            <a href="view.jsp" class="list-group-item">
                                <i class="fa fa-heart fa-fw"></i>
                                Network Flow
                            </a>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

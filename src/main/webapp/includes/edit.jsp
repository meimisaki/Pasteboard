<%@ page pageEncoding="UTF-8" %>
<div class="container">
    <h2 class="breadcrumb page-header">
        <li><a href="#">@AUTHOR</a></li>
        <li><input type="text" class="form-control" name="title" placeholder="Title" /></li>
        <div class="btn-group pull-right">
            <button type="button" class="btn btn-default dropdown-toggle" data-toggle="dropdown">
                Language
                <span class="caret"></span>
            </button>
            <ul class="dropdown-menu" role="menu">
                <li><a href="#">C++</a></li>
                <li><a href="#">Java</a></li>
                <li><a href="#">Python</a></li>
            </ul>
        </div>
    </h2>
    <div class="page-body">
        <pre><code contenteditable="true" class="form-control">codes...</code></pre>
        <a href="#" class="btn btn-xs btn-default">
            <i class="fa fa-tag fa-fw"></i>
            C++
        </a>
        <div class="divider"></div>
    </div>
    <div class="page-footer clearfix">
        <button type="submit" class="btn btn-primary pull-right">
            <i class="fa fa-check fa-fw"></i>
            Post
        </button>
    </div>
</div>

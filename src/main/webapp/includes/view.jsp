<%@ page pageEncoding="UTF-8" %>
<script type="text/javascript" src="bower_components/highlightjs/highlight.pack.js"></script>
<link rel="stylesheet" type="text/css" href="bower_components/highlightjs/styles/default.css" />
<div class="container">
    <form>
        <h2 class="breadcrumb page-header">
            <li><a href="#">@AUTHOR</a></li>
            <li><a href="#">@TITLE</a></li>
            <button type="submit" class="btn btn-default pull-right">
                <i class="fa fa-star fa-fw"></i>
                Star
            </button>
            <a href="edit.jsp" class="btn btn-default pull-right">
                <i class="fa fa-pencil fa-fw"></i>
                Edit
            </a>
        </h2>
    </form>
    <div class="page-body">
        <pre><code>function (window) { console.alert(window.name); }</code></pre>
        <a href="#" class="btn btn-xs btn-default tag">
            <i class="fa fa-tag fa-fw"></i>
            C++
        </a>
        <div class="divider"></div>
        <div class="row">
            <div class="col-md-8 col-md-offset-2">
                <h4>
                    <i class="fa fa-comments fa-fw"></i>
                    Comments
                </h4>
                <div class="comment">
                    <img src="" title="avatar" class="avatar" />
                    <div class="content">
                        <h5 class="comment-header">
                            @NAME
                            <span class="text-muted">
                                @DATE
                            </span>
                        </h5>
                        <div class="comment-body">
                            @COMMENT-BODY
                            [add like btn]
                        </div>
                    </div>
                </div>
                <form class="comment">
                    <textarea class="form-control" placeholder="Write your comment"></textarea>
                    <div class="comment-footer">
                        <button type="submit" class="btn btn-primary pull-right">
                            <i class="fa fa-check fa-fw"></i>
                            Comment
                        </button>
                    </div>
                </form>
            </div>
        </div>
    </div>
    <div class="page-footer"></div>
</div>
<script type="text/javascript">
hljs.initHighlightingOnLoad();
</script>

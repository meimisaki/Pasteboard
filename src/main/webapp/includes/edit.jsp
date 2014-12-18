<%@ page pageEncoding="UTF-8" %>
<script type="text/javascript" src="bower_components/highlightjs/highlight.pack.js"></script>
<link rel="stylesheet" type="text/css" href="bower_components/highlightjs/styles/default.css" />
<div class="container" ng-controller="editCtrl">
    <h2 class="breadcrumb page-header">
        <li><a href="#">@AUTHOR</a></li>
        <li><input type="text" autocomplete="off" class="form-control" name="title" placeholder="Title" ng-model="title" /></li>
        <div class="btn-group pull-right">
            <button type="button" class="btn btn-default dropdown-toggle" data-toggle="dropdown">
                {{lang.key || 'Language'}}
                <span class="caret"></span>
            </button>
            <ul class="dropdown-menu" role="menu">
                <li ng-repeat="(key, val) in langs">
                    <a href="javascript:;" ng-click="$parent.lang = {key: key, val: val}">{{key}}</a>
                </li>
            </ul>
        </div>
    </h2>
    <div class="page-body">
        <pre><code contenteditable="true" autocomplete="off" spellcheck="false" class="form-control">function (window) { console.alert(window.name); }</code></pre>
        <a href="javascript:;" class="btn btn-xs btn-default tag" ng-repeat="tag in tags" ng-click="tags.splice($index, 1)">
            <i class="fa fa-tag fa-fw"></i>
            {{tag}}
            <i class="fa fa-remove fa-fw"></i>
        </a>
        <input type="text" autocomplete="off" class="form-control tag" name="tag" id="tag" placeholder="Tag" />
        <div class="divider"></div>
    </div>
    <div class="page-footer clearfix">
        <button type="submit" class="btn btn-primary pull-right">
            <i class="fa fa-check fa-fw"></i>
            Post
        </button>
    </div>
</div>

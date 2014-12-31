'use strict';

var editor = 'pre code[contenteditable]';

function length(node) {
    return node.textContent.length;
}

function range(node, offset) {
    var range = document.createRange();
    range.setStart(node, offset);
    range.setEnd(node, offset);
    return range;
}

function select(node, offset) {
    for (var child = node.firstChild ; child ; child = child.nextSibling) {
        var len = length(child);
        if (len < offset) offset -= len;
        else if (child.nodeType == document.TEXT_NODE) return range(child, offset);
        else return select(child, offset);
    }
}

function execCommand(cmd, val) {
    document.designMode = 'on';
    document.execCommand(cmd, false, val || null);
    document.designMode = 'off';
}

$(document).ready(function () {
    var key;
    $(editor).on('keydown', function (event) {
        if ((key = event.which) != 9) return ;
        event.preventDefault();
        execCommand('insertText', '    ');
        $(this).trigger('input');
    }).on('input', function () {
        var elem = this;
        if (!$(elem).data('lang')) return ;
        setTimeout(function () {
            var selection = window.getSelection();
            var range = selection.rangeCount ? selection.getRangeAt(0) : null;
            var focus = range && $(range.commonAncestorContainer).closest(editor).toArray().indexOf(elem) != -1;
            var offset = 0;
            if (focus) {
                var node = range.startContainer;
                if (node == elem) {
                    var child = node.firstChild;
                    for (var i = 0 ; i < range.startOffset ; ++i) {
                        offset += length(child);
                        child = child.nextSibling;
                    }
                }
                else {
                    offset = range.startOffset;
                    for (; node != elem ; node = node.parentNode) {
                        var child = node;
                        do {
                            child = child.previousSibling;
                            if (!child) break;
                            offset += length(child);
                        }while (true);
                    }
                }
                if (key == 13) ++offset;
                key = null;
                offset = Math.min(offset, length(elem));
            }
            elem.innerText = elem.innerText;
            hljs.highlightBlock(elem);
            if (focus) {
                range = select(elem, offset);
                selection = window.getSelection();
                selection.removeAllRanges();
                selection.addRange(range);
                elem.focus();
            }
        }, 0);
    });
});

app.controller('editCtrl', function ($scope, $http, $document) {
    $http.get('langs.json').success(function (data) {
        $scope.langs = data;
        $scope.$watch('lang', function (lang) {
            var elem = $(editor);
            $.each($scope.langs, function () {
                $.each(this, function () {
                    elem.removeClass(this);
                });
            });
            if (!lang) return ;
            lang = lang.val[0];
            elem.data('lang', lang).addClass(lang).trigger('input');
        });
        $document.ready(function () {
            var key = $scope.language;
            var val = $scope.langs[key];
            val && ($scope.lang = {key: key, val: val});
            var tags = $scope.allTags.trim();
            $scope.tags = tags ? tags.split('\n') : [];
        });
    });
    var tag = $('#tag').keydown(function (event) {
        if (event.which != 13) return ;
        event.preventDefault();
        var val = tag.val().trim();
        val && $scope.$apply(function () {
            if ($scope.tags.indexOf(val) == -1) $scope.tags.push(val);
            tag.val('');
        });
    });
    $scope.post = function () {
        if (!$scope.title || !$scope.lang) return ;
        var obj = {
            title: $scope.title,
            description: $scope.description,
            source: $(editor).text(),
            language: $scope.lang.key,
            tags: $scope.tags.join('\n')
        };
        if ($scope.id) obj.id = $scope.id;
        $.submit(obj, {
            action: './edit.jsp',
            method: 'POST'
        });
    };
});

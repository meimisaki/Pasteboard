'use strict';

$(document).ready(function () {
    $('.avatar').each(function () {
        var elem = $(this);
        $('<img />').on('error', function () {
            elem.attr('src', './images/default_avatar.png');
        }).attr('src', elem.attr('src'));
    });
});

$.extend({
    submit: function (obj, opts) {
        opts = $.extend.call({
            action: '.',
            method: 'GET'
        }, opts);
        var form = $('<form></form>');
        form.attr('action', opts.action);
        form.attr('method', opts.method);
        obj && $.each(obj, function (key, val) {
            var field = $('<input />');
            field.attr('type', 'hidden');
            field.attr('name', key);
            field.val(val);
            form.append(field);
        });
        form.hide();
        $(document.body).append(form);
        form.submit();
    }
});

var app = angular.module('App', []);

app.run(function ($rootScope) {
    $rootScope.logout = function () {
        $.submit(null, {
            action: 'logout.jsp',
            method: 'POST'
        });
    };
});

app.directive('validator', function () {
    var tmpl = $('<span class="glyphicon form-control-feedback"></span>');
    return {
        link: function (scope, elem, attr) {
            var group = elem.closest('.form-group');
            group.addClass('has-feedback');
            var feedback = tmpl.clone();
            group.append(feedback);
            elem.popover({
                trigger: 'manual',
                content: function () {
                    return attr.hint;
                }
            });
            function toggle(curr, prev) {
                if (curr == prev) return ;
                elem.popover(curr ? 'show' : 'hide');
            }
            elem.on('input', function () {
                var prev = group.hasClass('has-warning');
                group.removeClass('has-success has-warning');
                feedback.removeClass('glyphicon-ok glyphicon-warning-sign');
                var val = elem.val();
                var validator = scope.$eval(attr.validator);
                if (!val || typeof validator != 'function') return toggle(false, prev);
                if (validator.call(elem, val)) {
                    group.addClass('has-success');
                    feedback.addClass('glyphicon-ok');
                    toggle(false, prev);
                }
                else {
                    group.addClass('has-warning');
                    feedback.addClass('glyphicon-warning-sign');
                    toggle(true, prev);
                }
            });
        }
    };
});

app.directive('centering', function () {
    var navbar = $('.navbar');
    var footer = $('.footer');
    function centering() {
        var height = window.innerHeight - navbar.height() - footer.height();
        var top = (height - this.height()) * 0.5;
        this.css('margin-top', Math.max(top, 15));
    }
    return {
        link: function (scope, elem, attr) {
            $(window).resize(centering.bind(elem));
            centering.call(elem);
        }
    };
});

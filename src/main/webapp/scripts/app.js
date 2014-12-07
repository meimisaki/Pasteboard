'use strict';

$(document).ready(function () {
    $('.avatar').each(function () {
        var elem = $(this);
        $('<img />').on('error', function () {
            elem.attr('src', './images/default_avatar.png');
        }).attr('src', elem.attr('src'));
    });
});

var app = angular.module('App', []);

app.directive('validator', function () {
    var tmpl = $('<span class="glyphicon form-control-feedback"></span>');
    return {
        link: function (scope, elem, attr) {
            var group = elem.closest('.form-group');
            group.addClass('has-feedback');
            var feedback = tmpl.clone();
            group.append(feedback);
            elem.on('input', function () {
                group.removeClass('has-success has-warning');
                feedback.removeClass('glyphicon-ok glyphicon-warning-sign');
                var val = elem.val();
                var validator = scope.$eval(attr.validator);
                if (!val || typeof validator != 'function') return ;
                if (validator.call(elem, val)) {
                    group.addClass('has-success');
                    feedback.addClass('glyphicon-ok');
                }
                else {
                    group.addClass('has-warning');
                    feedback.addClass('glyphicon-warning-sign');
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

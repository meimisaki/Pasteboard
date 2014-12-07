'use strict';

app.controller('registerCtrl', function ($scope) {
    var REs = {
        username: /^\w+$/,
        email: /^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$/
    };
    $.each(REs, function (key) {
        $scope[$.camelCase('validate-' + key)] = this.test.bind(this);
    });
    var repeat = $('#repeatPassword');
    var trigger = repeat.trigger.bind(repeat, 'input');
    $('#password').on('input', setTimeout.bind(null, trigger, 0));
    $scope.validatePassword = function (val) {
        return val == $scope.password;
    };
});

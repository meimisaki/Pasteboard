'use strict';

app.controller('viewCtrl', function ($scope, $http, atomic) {
    $scope.toggle = atomic(function () {
        $http.post(($scope.star ? 'unstar' : 'star') + '/' + $scope.id).success(function () {
            $scope.star = !$scope.star;
        });
    });
});

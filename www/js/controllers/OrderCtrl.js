define(function () {
    'use strict';
    function ctrl($scope,$state,$ionicHistory) {
        $state.go('service-order');
        $scope.goBack = function () {
            $ionicHistory.goBack();
        }


    }
    ctrl.$inject = ['$scope','$state','$ionicHistory'];
    return ctrl;
});
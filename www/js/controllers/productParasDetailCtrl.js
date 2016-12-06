define(function () {
    'use strict';
    function ctrl($scope,getData) {
    		$scope.paras=getData.give();
	}
    ctrl.$inject = ['$scope',"getData"];
    return ctrl;
});




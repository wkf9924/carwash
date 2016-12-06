define(function () {
    'use strict';
    function ctrl($scope,CarWashRequest,getId,getData) {
    		$scope.pictureDetail=getData.give();
        	console.log( $scope.pictureDetail);

}
    ctrl.$inject = ['$scope',"CarWashRequest","getId","getData"];
    return ctrl;
});




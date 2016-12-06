define(function () {
    'use strict';
    function ctrl($scope,CarWashRequest,getId) {
		/*发送参数*/
		var sendParas={
			id:"3",
			token:"MTU1Mjk2MjE4OTN8MjAxNi0wOS0wNHwxNzYzNjZmMjI4NGU0Y2VlYTAwYzM1OTAzYjE0NjNlZQ==",

		};
		/*获取商品详情*/
      	CarWashRequest.runHttp("get","/good/productList",sendParas).success(function(response){
      		console.log(response);
      		$scope.produstList=response.result;
      		console.log($scope.produstList)
      	}).error(function(response) {
      		console.log(response)
      	});

		/*获取商品id*/
		$scope.getGoodsId=function(id){
			getId.addIdName(id);
		};

    }


    ctrl.$inject = ['$scope','CarWashRequest','getId'];
    return ctrl;
});




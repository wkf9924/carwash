define(function () {
    "use strict";
    var addtoCart = function () {
    	/*加入到购物车指令*/
        return {
            restrict:"CA",
           	controller:function($scope,CarWashRequest,customePopu,$timeout,getTokenR,customeLoading){
				//var token=getTokenR.giveToken();
      		/*加入购物车*/
            	$scope.goCart=function(id,mechant_id,sku_stock_id,count){
                    getToken(function(token){
                    			customeLoading.show();
                               $scope.token=token;
                               CarWashRequest.runHttp("post","/good/saveCart",{
                                          count:count,
                                          id:id,
                                          mechant_id:mechant_id,
                                          sku_stock_id:sku_stock_id,
                                          token:$scope.token
                                        }).success(function(response){
                                                    if(response.code===0){
                                                      mallPrompt("添加成功");
                                                      customeLoading.hide();
                                                    }else{
                                                      //customePopu("添加失败,请重新添加");
                                                      mallPrompt("添加失败,请重新添加");
                                                    }
                                        }).error(function(response) {
                                          /* Act on the event */
                                            	mallPrompt("网络连接失败");
                                        });

                     });
            		/*请求购物车*/
             	}

           	},
            
        };
    }
    return addtoCart;
});

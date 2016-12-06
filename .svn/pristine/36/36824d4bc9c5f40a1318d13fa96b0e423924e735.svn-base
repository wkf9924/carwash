define(function () {
    'use strict';
    	function ctrl($scope,CarWashRequest,confirmPopu,customePopu,$timeout,$location,getGoodList,getTokenR,customeLoading,$state) {
    		customeLoading.show();
    		//$scope.token=getTokenR.giveToken();
    		/*请求购物车里面的商品列表*/
        getToken(function(token){
          $scope.token=token;
            CarWashRequest.runHttp("get","/good/shoppingcart",{
              token:$scope.token
          //token:"MTg3MTA3MjcwNzJ8MjAxNi0xMS0xNHxmYTVjMGRlYzAyZmU0YmMwYmVmNmM2ZjVlYzRmMzRkNA=="
        }).success(function(response){

          customeLoading.hide();
                  /*获取购物车列表*/
          $scope.buyedGoodsList=response.result;
             
          /*结算全选*/
          $scope.selectChecked={
            isCheckedAll:true
          };
          /*编辑全选*/
          $scope.editChecked={
            isCheckedAll:false
          };
          /*购物车的总数量*/
          $scope.buyedCount=0;
          /*是否编辑*/
          $scope.isEdit=false;
          /*遍历数组*/
          angular.forEach($scope.buyedGoodsList,function(value){
            value["checked"]=true;/*增加结算全选属性*/
            value["eidtChecked"]=false;/*增加编辑全选属性*/
          });
          /*删除购物车*/
          $scope.removeList=function(){
            for(var i=0;i<$scope.buyedGoodsList.length;i++){
              if($scope.buyedGoodsList[i].eidtChecked){
                $scope.buyedGoodsList.splice(i,1);
                i--;
              }
            }
          }
         
          /*计算购物车的总数量*/

          /*选择购物车中列表*/
          $scope.selectList=function(obj,isEdit){
            	/*每次点击以后执行*/
                var proName=null;
            	isEdit? proName="eidtChecked" : proName="checked";
        		obj.isCheckedAll=true;
        		angular.forEach($scope.buyedGoodsList,function(value){
          			if(!value[proName]){
            			obj.isCheckedAll=false;
          			};
        		})
          };
          /*全部选择或全部取消购物车中的列表操作*/
          $scope.allSelect=function(obj,isEdit){
            var proName=null;
            isEdit? proName="eidtChecked" : proName="checked";
            angular.forEach($scope.buyedGoodsList,function(value){
          if(obj.isCheckedAll){
            value[proName]=true;/*全部选择*/
          }else{
            value[proName]=false;/*全部取消*/
          }
        });
          };
          $scope.$watchCollection("buyedGoodsList",function(newVal){
            
          });
          /*计算总价*/
          $scope.totalPrice=function(){
            var total=0;
            angular.forEach($scope.buyedGoodsList,function(value){
              if(value.checked){
                total+=value.buy_count*value.price;
              }
            });
            return total;
          };
          /*编辑购物车*/
          $scope.edit=function(){
            if(!$scope.isEdit){
              $scope.isEdit=true;
            }else{
              $scope.isEdit=false;
            }
          }
          $scope.hasEdit=function(){
          };
          /*没有选择时alert自定义弹窗*/
          $scope.showPopup = function() {
            var l=$scope.buyedGoodsList.length;
            /*选取所要删除商品的id*/
            var idArr=selectEditeId();
            console.log(idArr);
            if(idArr.length===0){
              /*一个都没有选择的弹框*/
                	customePopu("您还没有选择商品哦")
            }else{
              /*选择后确认删除对话框*/
              var myconfirmPopup = confirmPopu("确定删除哦！")
              /*删除promise*/
                  myconfirmPopup.then(function(response) {
                      if(response) {
                        /*购物车的id*/
                        customeLoading.show()
                        var id=$scope.buyedGoodsList[0].cart_id;
                        CarWashRequest.runHttp("get","/good/delProduct",{
                          cart_id:id,
                          token:$scope.token,
                          good_id:idArr
                        }).success(function(response){
                         
                          $scope.removeList();
                          customeLoading.hide();
                          /*购物车删完后自动跳转到首页重新选购商品*/
                          if($scope.buyedGoodsList.length===0){
                          
                          }
                        }).error(function(response) {
                        	customeLoading.hide();
                          	mallPrompt("网络连接失败")
                        });
                      } else {
                          
                      }
                  });
            }
              };
              /*生成选择商品的id*/
              function selectEditeId(){
                var idArr=[];
                angular.forEach($scope.buyedGoodsList, function(value){
                  if(value.eidtChecked){
                    idArr.push(value.id)
                  }
                });
                return idArr;
              };
              /* 得到商品列表 跳转到下一页*/
              $scope.getList=function(arr){
                /*清空数组*/
                //getGoodList.emptyGoodList();
                if(angular.isArray(arr)){
                    var getArr=[];
                    angular.forEach(arr,function(value, key){
                      if(value.checked){
                        getArr.push(value);
                      };
                    });
                    if(getArr.length==0){
                      console.log("您还没有选择商品")
                    }else{
                      getGoodList.addGoods(getArr);
                      $state.go("sure-order")
                    }
                }
              }

        }).error(function() {
        	/* Act on the event */
        	mallPrompt("网络连接失败");
        	customeLoading.hide();
        });

        })
    	

	}
    ctrl.$inject = ['$scope',"CarWashRequest","confirmPopu","customePopu","$timeout","$location","getGoodList","getTokenR","customeLoading","$state"];
    return ctrl;
});




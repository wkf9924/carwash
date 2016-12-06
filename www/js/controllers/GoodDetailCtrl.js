define(function () {
    'use strict';
    function ctrl($scope,$ionicScrollDelegate,CarWashRequest,getId,operateUrl,getData,getGoodList,getTokenR,$stateParams,$state,$location,$log,$ionicSlideBoxDelegate,$window,customeLoading,$timeout) {
		customeLoading.show();
            setTabbarVisibility("GONE");
    		var goodId;
    		/*获取商品id*/
    		if(angular.isDefined(getId.getIdName())){
    			goodId=getId.getIdName();
    		};
    		/*获取地址的id*/
    		if($location.search()["id"]){
    			goodId=$location.search()["id"]
    		};
    		//$log.debug("goodId",goodId);
    		/*发送参数*/
    		var sendParas={};
          	sendParas.good_id=goodId;
      		//$log.debug("sendParas",sendParas);
      		$stateParams.id="ren";
        	/*获取商品详情*/
      		CarWashRequest.runHttp("get","/good",sendParas).success(function(response){
				//alert(JSON.striungify(response.result));
      			customeLoading.hide();
      			$scope.goodsInfo=response.result;
      			$scope.goodsInfo.buyedCount=1;
        		$window.mechant_id=$scope.goodsInfo.mechant_id;
      			/*数据库有问题 多余数据 随后删掉*/
              	$scope.goodsInfo.expand_service=[0,1];
      			/*更新slide*/
          		$timeout( function() {
					$ionicSlideBoxDelegate.update();
				}, 50)
      			$scope.urls=operateUrl($scope.goodsInfo.image_urls);
      			/*获取参数列表 图文参数*/
				$scope.get=function(obj){
					getData.get(obj);
				};
            	/*跳转至购订单确认页面*/
            	/*立即购买呢*/
            	$scope.getList=function(obj){
            		if($scope.netError){
            			mallPrompt("网络连接失败");
            			return
            		}
            		/*获取token*/
            		getToken(function(token){
            			$state.go("sure-order");
            		})
            		var arr=["buyedCount","id","image_urls","name","mechant_id","price","sku_stock_id"];
            		var addObj={};
            		angular.forEach(arr, function(value){
              			if(value==="image_urls"){
                				addObj["img_url"]=obj[value];
              			}else{
                				addObj[value]=obj[value];
              			};
           		});
            		getGoodList.addGoods(addObj)
            	}
      		}).error(function(response) {
            	customeLoading.hide();
            	mallPrompt("网络连接失败");
                $scope.netError="true";
      		    /* Act on the event */
      		});
          	$scope.nextSlide=function(){
          		$ionicSlideBoxDelegate.next(false);
          	};
            /*跳转至最新购物车页面*/
            $scope.goToCar=function(){
            	if($scope.netError){
            		mallPrompt("网络连接失败");
            		return
            	}
            	/*获取token 并跳转至我的购物车页面*/
              	getToken(function(token){
            		$state.go("my-car");
            	})
            }
			//时间格式转换
			function add0(m){return m<10?'0'+m:m }
			function format(timers)
			{
				//timers是整数，否则要parseInt转换
				var time = new Date(timers);
				var y = time.getFullYear();
				var m = time.getMonth()+1;
				var d = time.getDate()+1;
				var h = time.getHours()+1;
				var mm = time.getMinutes()+1;
				var s = time.getSeconds()+1;
				return y+'-'+add0(m)+'-'+add0(d)+' '+add0(h)+':'+add0(mm)+':'+add0(s);
			}
			$scope.commentCreatAt=function(create_at){
				return format(create_at);
				//return new Date(parseInt(create_at)).toLocaleString();
			};

			//评分保留一位小数
			function fomatFloat(src,pos){
				return Math.round(src*Math.pow(10, pos))/Math.pow(10, pos);
			}
			$scope.scoreNmu=function(score){
				if(score=="NaN"){
					return "5.0";
				}else {
					return fomatFloat(score,1);
				}
			}
	}

    ctrl.$inject = ['$scope','$ionicScrollDelegate','CarWashRequest',"getId","operateUrl","getData","getGoodList","getTokenR","$stateParams","$state","$location","$log","$ionicSlideBoxDelegate","$window","customeLoading","$timeout"];
    return ctrl;
});




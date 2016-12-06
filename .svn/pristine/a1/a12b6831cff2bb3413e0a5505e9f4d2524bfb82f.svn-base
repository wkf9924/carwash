angular.module('linkAddress', [])
/*省循环结束*/
.directive("provinceRepeatFinished",function($window,getAddressData){
	return function(scope,element,attrs){
		element.on("click",function(){
			$window.provinceCode=attrs["itemCode"];
			var text=element.find("span").text();
			getAddressData.getProvince(text);
		});
	}
})
/*选择省*/
.directive("selectProvince",function($window,$state){
	return {
           	restrict:"CAE",
           	scope:true,
           	link:function(scope,element,attrs){
           		var city_json=$window.CITY_JSON;
           		scope.provinceArr=[];
           		angular.forEach(city_json, function(obj){
           			if(obj.item_code.substr(2,4)==="0000"){
           				scope.provinceArr.push(obj)
           			}
           		});
           	}
     	};
})
/*城市循环结束*/
.directive("cityRepeatFinished",function($window,getAddressData){
	return function(scope,element,attrs){
		element.on("click",function(){
			$window.cityCode=attrs["itemCode"];
			var text=element.find("span").text();
			getAddressData.getCity(text);
		})
	}
})
/*选择城市*/
.directive("selectCity",function($window,getAddressData){
	return{
		restrict:"CAE",
		scope:true,
		link:function(scope,element,attrs){
			var city_json=$window.CITY_JSON;
			var provinceCode=$window.provinceCode;
			scope.cityArr=[];
			angular.forEach(city_json,function(obj){
				if(obj.item_code.substr(0,2)===provinceCode.substr(0,2)&&obj.item_code.substr(4,2)==="00"&&obj.item_code.substr(2,4)!=="0000"){
					scope.cityArr.push(obj)
				}
			});
		}
	}
})
/*区域循环结束*/
.directive("districtRepeatFinished",function(getAddressData,$rootScope,$state,$ionicHistory,$timeout){
	return function(scope,element,attr){
		element.on("click",function(){
			var text=element.find("span").text();
			getAddressData.getDistrict(text);
			console.log(getAddressData.giveAddress());
			
           		scope.$apply(function(){
           			//$state.go("address-add");
           			$ionicHistory.goBack(-3);
           		});
           		$timeout(function(){
                		/*发布选择完成事件*/
           			$rootScope.$broadcast("selectFinished")
           		},0)
		})
	}
})
/*选择区域*/
.directive("selectDistrict",function($window){
	return{
		restrict:"CAE",
		scope:true,
		link:function(scope,element,attrs){
			var city_json=$window.CITY_JSON;
			var cityCode=$window.cityCode;
			scope.districtArr=[];
			angular.forEach(city_json, function(obj){
				if(obj.item_code.substr(0,4)===cityCode.substr(0,4)&&obj.item_code.substr(4,2)!=="00"){
					scope.districtArr.push(obj);
				}
			});
		}
	}
})
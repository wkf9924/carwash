/*×Ô¶¨ÒåÊÂ¼þ*/
function EventTarget(){
	var event={};
	return{
		on:function(name,handler){
			name.split(" ").forEach(function(value){
				if(!event[value]){
					event[value]=[];
				};
				event[value].push(handler)
			});
			return this
		},
		trigger:function(name,args){
			angular.forEach(event[name],function(handler){
				handler.call(null,args);
			})
		}
	}
};
angular.module('tabSlideBox', [])
.directive("loadFinished",function(){
	return{
		restrict:"A,C,E",
		link:function(scope,element,attrs){
			if(scope.$last){
				/*µ½´ï×îºóÒ»¸öÔªËØ¿ªÊ¼·¢²¼ÊÂ¼þ*/
				scope.$emit("loadFinished");
			}
		}
	}
}).directive("tabPane",function(){
	return{

		restrict:"A,C,E",
		link:function(scope,element,attrs){
			scope.$tabSpanes.push(element[0]);
		}
	}
})
.directive("tabSlideBox",function(){
	return{
		restrict:"A,C,E,",
		link:function(scope,element,attrs){

			function renderTab(){

				var $tab=element;/*jqLite¶ÔÏó*/
				var tab=element[0];/*dom¶ÔÏó*/
				console.log(tab)
				var iconsDiv=angular.element(tab.querySelector(".scroll"));
				var icons=iconsDiv.children();

				$tab.addClass('tabbed-box');
				angular.forEach(icons, function(icon,key){
					var a=angular.element(icon);
					a.on("click",function(){
						setPosition(key);
					})
				});
				setPosition(0)
			};
			function setPosition(index){
				/*ÔÝÊ±Ã»ÓÐ¼Ó¶¯Ì¬Ð§¹û*/
				var $tab=element;
				var tab=element[0];
				var tabIcWrp=tab.querySelector(".tab-ic-wrp");
				var iconsDiv=angular.element(tab.querySelector(".scroll"));
				var icons=iconsDiv.children();
				var middle=tabIcWrp.offsetWidth/2;
				var curEl=angular.element(icons[index]);/*µ±Ç°ÔªËØ*/
				var preEl=angular.element(iconsDiv[0].querySelector(".active"));/*Ç°Ò»¸öÔªËØ*/
				
				preEl.removeClass('active');
				curEl.addClass('active');
			}
			
			var event=scope.event;
			event.on("loadFinished",function(){
				renderTab();
				
			});
			
			
		},
		controller:function($scope,$element,$attrs){
			$scope.event=new EventTarget();
			$scope.$on("loadFinished",function(ngLoadFinishedEvent){
				$scope.event.trigger('loadFinished',{name:ngLoadFinishedEvent})
			});
			$scope.test=function(){
				
			}
			
		}
	}
})

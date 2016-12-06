define(function () {
	"use strict";
	var score = function () {
		/*打分指令*/
		return {
			restrict:"CA",
			link:function(scope,element,attrs){
				//console.log(element);
				scope.totalScore=5;
				scope.scoreArr=[];
				for(var i=0;i<scope.totalScore;i++){
					scope.scoreArr.push(i)
				};
				//console.log(scope.scoreArr)
				/*用户已经打的分*/
				scope.scoped=attrs["score"];
				console.log(scope.scoped)
				scope.makeScope=function(index){
					if( angular.isDefined(scope.scoped) ){
						if(scope.scoped<index){
							return "ion-ios-star-outline"
						}else{
							return "ion-ios-star" 
						}
					}
				}
			}
		};
	}
	return score;
});

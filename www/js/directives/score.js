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
				/*用户已经打的分*/
				//scope.scoped=attrs["score"];
				scope.makeScope=function(index,score){
					if( angular.isDefined(score) ){
						if(score>index+1 || score==index+1){
							return "ion-ios-star";
						}else if(score>index &score<(index+1)) {
							return "ion-ios-star-half"
						}else{
							return "ion-ios-star-outline"
						}
					}
				}
			}
		};
	}
	return score;
});

define(function () {
    "use strict";
    var score = function ($parse) {
    	/*打分指令*/
        return function(scope,element,attrs){
        	var list=element.children('li');
        	var star=attrs["boldStart"];
        	var outLineStar=attrs["outlineStar"];
        	/*转化表达式*/
        	var evaluateExrFn=$parse(attrs.degreeEvaluate);
        	for(var i=0;i<5;i++){
        		(function(i){
        			var $li=angular.element(list[i]);
        			$li.on("click",function(){
        				var stringI=i+1;
        				angular.forEach(list, function(value, key){
        					if(angular.element(list[key]).hasClass(outLineStar)){
	        					if(key<=i){
	        						angular.element(list[key]).removeClass(outLineStar).addClass(star);
	        					}
	        				}else{
	        					if(key>i){
	        						angular.element(list[key]).removeClass(star).addClass(outLineStar);
	        					}
	        				}
        				});
        				evaluateExrFn.assign(scope,stringI.toString())
        			});

        		})(i)
        	}
        	
        	
        	
          
        }
            
       
    }
    return score;
});

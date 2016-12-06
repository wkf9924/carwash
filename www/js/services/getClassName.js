define(function () {
	"use strict";
	var factory = function ($http) {
		var className;
		return {
				addClassName:function(id){
					className=id;
				},
				getClassName:function(){
					return className;
				}
		}
	};
	factory.$inject = ['$http'];
	return factory;
});

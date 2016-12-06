define(function () {
		"use strict";
		var factory = function () {
				return {
					getProvince:function(text){
						this.addressObj={};
						this.addressObj.province=text;
					},
					getCity:function(text){
						this.addressObj.city=text;
					},
					getDistrict:function(text){
						this.addressObj.area=text;
					},
					giveAddress:function(){
						if(angular.isDefined(this.addressObj)){
							return this.addressObj;
						}else{
							return false;
						}
					},
					emptyAddress:function(){
						this.addressObj={};
					}
				}
						
				

		};
		factory.$inject = [];
		return factory;
});

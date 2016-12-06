define([
		'services/services',
		'controllers/controllers',
		'directives/directives',
		'filters/filters',/*过滤器*/],
		function () {
			'use strict';
			var app = angular.module('starter', ['ionic', 'starter.controllers', 'starter.services','starter.directives','starter.filters','tabSlideBox',"linkAddress"])
						.config(function ($stateProvider, $urlRouterProvider,$ionicConfigProvider) {
									
									$stateProvider
										.state("mall", {
												url: "/",
												templateUrl: "templates/mall/mall.html",
												controller: 'MallCtrl'

										})
										.state("detail", {
												url: "/detail",
												templateUrl: "templates/mall/detail.html",
												controller: 'GoodDetailCtrl'
												/*params:{id:2}*/
										})
										//商品列表
										.state("productList", {
												url: "/productList",
												templateUrl: "templates/mall/product-list.html",
												controller: 'ProductList'
										})
										.state("discovery", {
												url: "/discovery",
												templateUrl: "templates/discovery/discovery.html",
												controller: 'DiscoveryCtrl'
										})

										.state("discovery-detail", {
												url: "/discovery-detail",
												templateUrl: "templates/discovery/discovery-detail.html",
												controller: 'DiscoveryDetailCtrl'
										})
										//服务订单
										.state("service-order", {
												url: "/service-order",
												//cache:'false',
												templateUrl: "templates/mall/serviceorder/service-order.html",
												controller: 'ServiceOrderCtrl'
										})
										//服务订单详情
											.state("service-order-nopay", {
												url: "/service-order-nopay",
												templateUrl: "templates/mall/serviceorder/service-order-nopay.html",
												controller: 'ServiceOrderDetailCtrl'
											})
										//使用服务扫二维码
										.state("service-qr-code", {
												url: "/service-qr-code",
												templateUrl: "templates/mall/serviceorder/service-qr-code.html",
												controller: 'ServiceQrCodeCtrl'
										})
										/*订单详情*/
										.state("order-info", {
												url: "/order-info",
												templateUrl: "templates/mall/order-info.html",
												controller: 'orderInfoCtrl'
										})
										/*所有订单列表*/
										.state("myorder", {
												url: "/myorder",
												templateUrl: "templates/mall/myorder.html",
												controller: "myOrderCtrl"
										})
										/*商品评价*/
										.state("comment", {
												url: "/comment",
												templateUrl: "templates/mall/comment.html",
												controller: 'commentCtrl'
											
										})
										/*我的购物车*/
										.state("my-car", {
												url: "/my-car",
												templateUrl: "templates/mall/my-car.html",
												controller: 'myCarCtrl'
										})
										 /*我的地址*/
										.state("address-my", {
												url: "/address-my",
												templateUrl: "templates/mall/address-my.html",
												controller: 'AddressMyCtrl'
										})
										/*添加收货地址*/
										.state("address-add", {
												url: "/address-add",
												templateUrl: "templates/mall/address-add.html",
												controller: 'addressAddCtrl'
										})
										.state("sure-order", {
												url: "/sure-order",
												templateUrl: "templates/mall/sure-order.html",
												controller: 'sureOrderCtrl'
										})
										/*图文详情*/
										.state("picture-detail", {
												url: "/picture-detail",
												templateUrl: "templates/mall/picture-detail.html",
												controller: 'pictureDetailCtrl'
										})
										/*产品参数*/
										.state("product-paras", {
												url: "/product-paras",
												templateUrl: "templates/mall/product-paras.html",
												controller: 'productParasDetailCtrl'
										})
										/*选择省*/ 
										.state("select-province", {
												url: "/select-province",
												templateUrl: "templates/mall/select-province.html",
												controller: 'SelectProvinceCtrl'
										})
										 /*选择市*/
										.state("select-city", {
												url: "/select-city",
												templateUrl: "templates/mall/select-city.html",
												/*controller: 'productParasDetailCtrl'*/
										})
										/*选择区域*/
										.state("select-district", {
												url: "/select-district",
												templateUrl: "templates/mall/select-district.html",
												/*controller: 'productParasDetailCtrl'*/
										})
										/*银行卡协议*/
										.state("card-agreement", {
											url: "/card-agreement",
											templateUrl: "templates/other/card-agreement.html",
										})
										/*关于我们*/
											.state("about-us", {
												url: "/about-us",
												templateUrl: "templates/other/about-us.html",
										})
										/*洗洋洋软件许可及服务协议及法律声明*/
										.state("service-agreement", {
											url: "/service-agreement",
											templateUrl: "templates/other/service-agreement.html",
										})
										// $urlRouterProvider.otherwise('/');
						});
				app.run(['$rootScope', '$location' , '$state', '$http','$ionicPopup',"$log", function($rootScope, $location, $state,$http,$ionicPopup,$log){
					//var isFirst=true;
					$rootScope.$on('$stateChangeSuccess',
						function(event, toState, toParams, fromState, fromParams){
							var path=$location.path();
							if(path=='/'){
								setTabbarVisibility("VISIBLE");
							}
							//else if(path=='/detail' || path=='/address-my'|| path=='/service-order' || path=='/my-car'){
							//	if(fromState.url=="^"){
							//		alert("fromState.url="+fromState.url+"，点击返回-进入插件跳原生");
							//		//goBack("返回原生界面");
							//	}else{
							//		alert("fromState.url="+fromState.url+"，点击返回-进入web页面");
							//	}
							//	setTabbarVisibility("GONE");
							//}
							else if(path=="/detail"){
								// var isFirst=true;
								// if(isFirst){
								// 	isFirst=false;
								// 	setTabbarVisibility("GONE");
								// }
								
							};
						});
						
				}]);
				return app;
		});

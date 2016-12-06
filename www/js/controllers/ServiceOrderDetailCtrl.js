define([
    //'css!../../css/discovery/discovery.css',
    //'css!../../css/common.css'
], function () {
    'use strict';
    function ctrl($scope,$http,getfield,urlData,$location,confirmPopu,$timeout,$rootScope) {

        //获取服务订单详情
        getserviceOrderEdit();
        function getserviceOrderEdit(){
            getToken(function(token){
            $scope.token = token;
                var serviceOrderEditData = {
                    id:getfield.getIdName(),
                    token: $scope.token
                };
                $http({
                    method: "get",
                    dataType:"json",
                    url:"http://192.168.2.249:8081/carwash/my/serviceOrderInfo",
                    withCredentials:true,
                    params:serviceOrderEditData,
                    headers : { 'Content-Type': 'application/x-www-form-urlencoded;charset=utf-8' }
                }).success(function(response){
                       if(response.code==0){
                           $scope.service_name = response.result.service_name;
                           $scope.seller_name = response.result.seller_name;
                           $scope.seller_tel = response.result.seller_tel;
                           $scope.service_price = response.result.service_price;
                           $scope.create_time = response.result.create_time;
                           $scope.img_url = response.result.img_url;
                           $scope.id = response.result.id;
                           $scope.status = response.result.status;
                           $scope.coupon_price = response.result.coupon_price;
                           $scope.service_type = response.result.service_type;
                           if ( $scope.service_type =="-1"){
                              $scope.coupon_price="0"
                           }
                           $scope.accepter_userid = response.result.accepter_userid;
                           $scope.coupon_id = response.result.coupon_id;
                           $scope.service_id = response.result.service_id;
                           console.log("ok");

                       }else{
                        return null;
                    }
                });


            });
        }

        $scope.orderPic=function(service_type){
            switch(service_type){
                //-1： 特惠洗车）1：洗车 2：四轮定位 3：全车打蜡 4：大保养 5：小保养
                case "-1": return"icon-tehui.png";
                    break;
                case "1": return"icon-xiche.png";
                    break;
                case "2": return"icon-silun.png";
                    break;
                case "3": return"icon-dala.png";
                    break;
                case "4": return"icon-dabaoyang.png";
                    break;
                case "5": return"icon-xiaobaoyang.png";
                    break;
            }
        }




        //删除订单
            $scope.delServiceOrder = function(){
                getToken(function(token){
                    $scope.token = token;
                    var delServiceOrderData = {
                        token: $scope.token,
                        id:getfield.getIdName(),
                        type:"1"
                    };
                    confirmPopu("确认删除").then(function(res){
                        if(res){
                            urlData.runHttp("get","/my/editService",delServiceOrderData).success(function(response){
                                if(response.code==0){
                                    mallPrompt("删除成功");
                                    $timeout(function(){
                                        $location.path('/service-order');
                                        $rootScope.$broadcast("servicelist")
                                    },1500)
                                }else{
                                    mallPrompt(response.message);
                                }
                            }).error(function(response) {
                                    mallPrompt(response.message);
                                });

                        }else{
                            console.log("shanchu")
                        }
                    });
                });
            };

            //取消订单
            $scope.cancelServiceOrder = function(){
                getToken(function(token){
                    $scope.token = token;
                    var cancelServiceOrderData = {
                        token: $scope.token,
                        id:getfield.getIdName(),
                        type:"2"
                    };
                    confirmPopu("确认取消").then(function(res){
                        if(res){
                            urlData.runHttp("get","/my/editService",cancelServiceOrderData).success(function(response){
                                //console.log("parse   result bbb:"+JSON.stringify(response));
                                //customePopu("取消订单成功");
                                mallPrompt("取消订单成功");
                                $timeout(function(){
                                    $location.path('/service-order');
                                    $rootScope.$broadcast("cancellist")
                                },1500)

                            })

                        }else{
                            console.log("quxiao")
                        }
                    });
                 });
            };

            //使用服务
             $scope.useservice = function(){
                $location.path('/service-qr-code')
            }


            //立即支付
            $scope.servicePay = function(){
                getToken(function(token){
                    $scope.token = token;
                    var servicePaydata={
                        accepter_userid:$scope.accepter_userid,
                        coupon_id:$scope.coupon_id,
                        id:getfield.getIdName(),
                        price:$scope.service_price,
                        service_id:$scope.service_id,
                        token:$scope.token,
                        type:"1"
                    };
                    goSerPay(servicePaydata.accepter_userid,servicePaydata.coupon_id,servicePaydata.id,servicePaydata.price,servicePaydata.service_id,servicePaydata.token,servicePaydata.type);
                });
            };

    }

    ctrl.$inject = ['$scope','$http','getfield','urlData','$location',"confirmPopu","$timeout",'$rootScope'];
    return ctrl;
});


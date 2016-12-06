define([
    //'css!../../css/discovery/discovery.css',
    //'css!../../css/common.css'
], function () {
    'use strict';
    function ctrl($scope,urlData,getfield,$rootScope,customeLoading) {
        customeLoading.show();
        //状态说明：0:待支付，1：已支付 ，4：已完成， 5：全部

        //获取服务订单列表
        $scope.onTabSelected = function(status){
            getToken(function(token){
                $scope.token = token;
                var serviceorderdata={
                    status:status,
                    token: $scope.token
                };
                urlData.runHttp("get","/my/serviceOrderList",serviceorderdata).success(function(response){
                     customeLoading.hide();
                        if(response.code=="0"){
                            console.log(response.result);
                            $scope.soreders = response.result;
                            for (var i=0;i<response.result.length;i++)
                            {
                                if(response.result[i].status=="1"){
                                    response.result[i].status="未使用"
                                }else if(response.result[i].status=="3"){
                                    response.result[i].status="已使用";
                                }else{
                                    console.log(response.message)
                                };
                            }
                        }else{
                            console.log(response.message);
                        }
                    })

                /*服务订单图片*/
                $scope.orderPic=function(server_type){
                    switch(server_type){
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
            });

        };

        // 删除--删除订单
        $rootScope.$on("servicelist",function(){
            $scope.soreders.splice($scope.deleteIndex,1);
        })
        // 删除--取消订单
        $rootScope.$on("cancellist",function(){
            $scope.soreders.splice($scope.deleteIndex,1);
        })

        //获取服务订单id
        $scope.serviceOrderEdit=function(id,index){
            $scope.deleteIndex=index;
            getfield.addIdName(id);
            console.log(getfield.getIdName());
        }


        //切换内容
        $scope.currentTabOne = "templates/mall/serviceorder/service-order-fwcont.html";
        $scope.btnswitchservice = function(){
            $scope.currentTabOne = "templates/mall/serviceorder/service-order-fwcont.html";
            $scope.currentTabTwo="none";
            document.getElementById("btnswitchservice").className="button button-energizedv active";
            document.getElementById("btnswitchgoods").className="button button-light";


        };
        //$scope.currentTabTwo = "templates/mall/myorder.html";
            $scope.btnswitchgoods = function(){
            $scope.currentTabTwo = "templates/mall/myorder.html";
            $scope.currentTabOne="none"
            document.getElementById("btnswitchservice").className="button button-energizedv";
            document.getElementById("btnswitchgoods").className="button button-light active";
        };


    }

    ctrl.$inject = ['$scope','urlData','getfield','$rootScope','customeLoading'];
    return ctrl;
});


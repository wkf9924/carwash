define([
    // 'css!../../css/discovery/discovery-detail.css',
    // 'css!../../css/common.css'
], function () {
    'use strict';
    function ctrl($scope,DiscoveryService,$http,getfield,getToken) {

        //获取Token
        $scope.$watch("token",function(newVal){
            if(newVal){
                getToken.addToken(newVal);
                console.log(getToken.giveToken());
            }
        });

        //点赞
        $scope.discoverContjia = function () {
            getToken();
            function getToken() {

                data.getToken(function(token){
                    $scope.token=token;

                    document.getElementById("discover-like-active").style.display="none";
                    document.getElementById("discover-like").style.display="block";

                    var Contjiadata = {
                        id:getfield.getIdName()
                    };

                    $http({
                        method: "post",
                        dataType:"json",
                        //url:"http://192.168.2.249:8081/carwash/news/likes?token=MTU1Mjk2MjE4OTN8MjAxNi0wOS0wNHwxNzYzNjZmMjI4NGU0Y2VlYTAwYzM1OTAzYjE0NjNlZQ==",
                        url:"http://192.168.2.249:8081/carwash/news/info?token="+token,
                        withCredentials:true,
                        params:Contjiadata,
                        headers : { 'Content-Type': 'application/x-www-form-urlencoded;charset=utf-8' }
                    }).success(function(response){
                        console.log("parse   result bbb:"+JSON.stringify(response));
                        //$scope.account =JSON.stringify(response).account;
                        // console.log("=======response:=======>"+response  );
                        //console.log("==============>"+$scope.account  );

                        if(response.code==0){
                            console.log("ok");
                            return response.result;
                        }else{
                            return null;
                        }
                    });



                },function(error){

                    alert("get token fail："+error);

                });

            };


        };

        $scope.discoverContjian = function () {
            document.getElementById("discover-like-active").style.display="block";
            document.getElementById("discover-like").style.display="none";

        };

        //收藏
        $scope.collectionInfoadd = function () {
            document.getElementById("discover-like-active").style.display="block";
            document.getElementById("discover-like").style.display="none";

            getToken();
            function getToken() {

                data.getToken(function(token){
                    $scope.token=token;

                    document.getElementById("discover-like-active").style.display="none";
                    document.getElementById("discover-like").style.display="block";

                    var collectiondata = {
                        id:getfield.getIdName()
                    };

                    $http({
                        method: "post",
                        dataType:"json",
                        //url:"http://192.168.2.249:8081/carwash/news/article?token=MTU1Mjk2MjE4OTN8MjAxNi0wOS0wNHwxNzYzNjZmMjI4NGU0Y2VlYTAwYzM1OTAzYjE0NjNlZQ==",
                        url:"http://192.168.2.249:8081/carwash/news/info?token="+token,
                        withCredentials:true,
                        params:collectiondata,
                        headers : { 'Content-Type': 'application/x-www-form-urlencoded;charset=utf-8' }
                    }).success(function(response){
                        console.log("parse   result bbb:"+JSON.stringify(response));
                        //$scope.account =JSON.stringify(response).account;
                        // console.log("=======response:=======>"+response  );
                        //console.log("==============>"+$scope.account  );

                        if(response.code==0){
                            console.log("ok");
                            return response.result;
                        }else{
                            return null;
                        }
                    });



                },function(error){

                    alert("get token fail："+error);

                });

            };

        };

        //评价信息
        $scope.addEvaluate = function () {
            getToken();
            function getToken() {

                data.getToken(function(token){
                    $scope.token=token;

                        var addEvaluatedata={
                            eva_content:$scope.eva_content
                        };
                        $http({
                            method:"post",
                            dataType:"json",
                           // url:"http://192.168.2.249:8081/carwash/news/saveEva?token=MTU1Mjk2MjE4OTN8MjAxNi0wOS0wNHwxNzYzNjZmMjI4NGU0Y2VlYTAwYzM1OTAzYjE0NjNlZQ==",
                            url:"http://192.168.2.249:8081/carwash/news/saveEva?token="+token,
                            withCredentials:true,
                            params:addEvaluatedata,
                        }).success(function(response){
                            console.log("parse   result 评论:"+JSON.stringify(response));
                            if(response.code==0){
                                return response.result;
                            }else{
                                return null;
                            }

                        })



                },function(error){

                    alert("get token fail："+error);

                });

            };

        };

        //获取文章详细信息
        getdiscoveryDetail(token);
        function getdiscoveryDetail(token){
            var discoverydata = {
                id:getfield.getIdName()
            };
            $http({
                method: "get",
                dataType:"json",
                //url:"http://192.168.2.32:8080/carwash/news/info?token=MTU1Mjk2MjE4OTN8MjAxNi0wOS0wNHwxNzYzNjZmMjI4NGU0Y2VlYTAwYzM1OTAzYjE0NjNlZQ==",
                url:"http://192.168.2.249:8081/carwash/news/info",
                withCredentials:true,
                params:discoverydata,
                headers : { 'Content-Type': 'application/x-www-form-urlencoded;charset=utf-8' }
            }).success(function(response){
                console.log("parse   result bbb:"+JSON.stringify(response));
                //$scope.account =JSON.stringify(response).account;
                // console.log("=======response:=======>"+response  );
                //console.log("==============>"+$scope.account  );
                $scope.title = response.result.title;
                $scope.publisher = response.result.publisher;
                $scope.send_time = response.result.send_time;
                $scope.content = response.result.content;
                $scope.img_url = response.result.img_url;
                $scope.likes_count = response.result.likes_count;
                $scope.comment_count = response.result.comment_count;

                if(response.code==0){
                    console.log("ok");
                    return response.result;
                }else{
                    return null;
                }
            });
        }

        //获取文章评价信息
        getevaluateDetail();
        function getevaluateDetail(){
            var evaluatedata = {
                id:getfield.getIdName()
            };
            $http({
                method: "get",
                dataType:"json",
                url:"http://192.168.2.249:8081/carwash/news/evaluate",
                withCredentials:true,
                params:evaluatedata,
                headers : { 'Content-Type': 'application/x-www-form-urlencoded;charset=utf-8' }
            }).success(function(response){
                console.log("parse   result bbb:"+JSON.stringify(response));

                $scope.commentlists = response.result;

                if(response.code==0){
                    console.log("ok");
                    return response.result;
                }else{
                    return null;
                }
            });
        };





    };

    ctrl.$inject = ['$scope','DiscoveryService','$http','getfield',"getToken"];
    return ctrl;
});




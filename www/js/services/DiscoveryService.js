define(function () {
  "use strict";
  var factory = function ($http) {
    var classes = null;

    return {
      getNewsList: function() {
        return $http.get("http://192.168.2.249:8081/carwash/news/list?token=MTU1Mjk2MjE4OTN8MjAxNi0wNy0xMXwxNzYzNjZmMjI4NGU0Y2VlYTAwYzM1OTAzYjE0NjNlZQ==");
      },
      //getNewIinfo: function() {
      //  return $http.get("http://192.168.2.32:8080/mockjs/1/news/info?token=1&id=1");
      //},
      //getComments: function() {
      //  return $http.get("http://192.168.2.32:8080/carwash/news/evaluate?count=1&id=1&token=1&page=1");
      //},
      parseResult:function(response) {
        //if(response.code==0){
        return response.result;
        //}else{
        //  return null;
        //}
      }
    };


  };
  factory.$inject = ['$http'];
  return factory;
});

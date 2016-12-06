/**
 * Created by behring on 16/7/11.
 */
var token = null;
function setTabbarVisibility(visibility){
    var success = function () { alert('successfully'); };
    var error = function (e) { alert('failed:' + e); };
    tabbarvisibility.setVisibility(visibility,success, error);
}

//获取token
function getToken(fn,errorFn){
   // var error = function (e) { /*alert('获取失败:' + e);*/ };
    data.getToken(fn, errorFn);
}

//跳转到原生的商品支付页面
function goToPay(Accepter_userid,Amount,Appid){
    var success = function () { alert('跳转到商品订单收款页面成功'); };
    var error = function (e) { alert('跳转到商品订单收款页面失败:' + e); };
    gotopay.goToPay(Accepter_userid,Amount,Appid, success, error);
}

//跳转到原生的服务订单支付页面
function goSerPay(accepter_userid,coupon_id,id,price,service_id,token,type){
    var success = function () { alert('跳转到服务订单收款页面成功'); };
    var error = function (e) { alert('跳转到服务订单收款页面失败:' + e); };
    goserpay.goSerPay(accepter_userid,coupon_id,id,price,service_id,token,type,success, error);
}

//调用原生提示框
function mallPrompt(content) {
        var success = function () {console.log("调用原生提示成功");};
        var error = function (e) { console.log( "调用原生提示失败"+ e); };
        mallprompt.mallPrompt(content,success,error);
}

//返回按钮跳转到原生页面
function goBackNative(gotoback){
    var success = function () { alert('返回成功'); };
    var error = function (e) { /*alert('返回失败:' + e); */};
    gobackN.goBack(gotoback, success, error);
}
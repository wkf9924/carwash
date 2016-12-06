/**
 * Created by behring on 16/7/21.
 */
/**
 * Created by behring on 16/7/21.
 */
requirejs.config({
    baseUrl:'js',

    paths:{
        "bootstrap": "bootstrap",
    },
    map: {
        '*': {
            'css': 'css'
        }
    },
    shim : {
        'bootstrap': [
            'css!../css/mall/mall.css',
            'css!../css/common.css',
            'css!../css/mall/order.css',
            'css!../css/mall/detail.css',
            'css!../css/mall/my-car.css',
            'css!../css/mall/address.css',
            'css!../css/mall/sure-order.css',
            'css!../css/mall/tabSlideBox.css',

            'css!../css/discovery/discovery.css',
            'css!../css/discovery/discovery-detail.css',

            'css!../css/mall/serviceorder/serviceorder.css',
            'css!../css/discovery/discovery.css',
            'css!../css/ohter/other.css',
        ]
    }
});
requirejs(["bootstrap"]);
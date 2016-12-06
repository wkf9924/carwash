//
//  LoginModel.h
//  CarWash
//
//  Created by WangKaifeng on 2016/9/28.
//  Copyright © 2016年 xiyangyang. All rights reserved.
//

#import <Foundation/Foundation.h>
//car_plate = "沪A65405678",
//phone = "18089263262",
//blance = "0",
//avatar_url = <null>,
//car_brandlogo = "http://img5.xcarimg.com/PicLib/logo/pl3_160s.png?t=20160919",
//car_model = <null>,
//car_id = "66c03daed43f448d980a8fd9d68dcab5",
//bank_card_count = "0",
//car_brand = "奔驰",
//car_type = "奔驰C级混合动力",
//token = "MTgwODkyNjMyNjJ8MjAxNi0wOS0yOHwxZTQyOGFmNWEyOWU0N2QxOWViZTU0ODAxMjJhMDU1Mg==",
//ticket_count = 18,
//is_vip = "1",
//name = <null>,
//gender = <null>,
@interface LoginModel : NSObject

@property (nonatomic, strong) NSString *car_plate;
@property (nonatomic, strong) NSString *phone;
@property (nonatomic, strong) NSString *blance;
@property (nonatomic, strong) NSString *avatar_url;
@property (nonatomic, strong) NSString *car_brandlogo;
@property (nonatomic, strong) NSString *car_model;
@property (nonatomic, strong) NSString *car_id;
@end

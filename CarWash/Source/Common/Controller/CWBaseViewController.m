//
//  SQRBaseViewController.m
//  Merchant
//
//  Created by 赵林 on 15/9/1.
//  Copyright (c) 2015年 Ivan. All rights reserved.
//

#import "CWBaseViewController.h"
#import "CCLocationManager.h"
#define RED_DOT_VIEW_TAG 1001
#define IS_IOS7 ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7)
#define IS_IOS8 ([[[UIDevice currentDevice] systemVersion] floatValue] >= 8)
#define IS_IOS9 ([[[UIDevice currentDevice] systemVersion] floatValue] >= 9)

static id ext_param;
@interface CWBaseViewController ()
@end

@implementation CWBaseViewController

-(void)viewDidLoad
{
    [super viewDidLoad];

    
    if([((NSObject *)_superDelegate) respondsToSelector:@selector(handleParam:)]){
        [_superDelegate handleParam:ext_param];
    }
    [_superDelegate initViews];
    
    ext_param = nil;
}


-(void)initViews
{
    
}


-(void)setParam:(id)param
{
    ext_param= param;
}

-(id)getParam{
    return ext_param;
}


//输入框前面空格
- (UITextField *)setTextField:(UITextField *)tf{
    UILabel *paddingView = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 13, 25)];
    paddingView.text = @"  ";
    paddingView.textColor = [UIColor lightGrayColor];
    paddingView.backgroundColor = [UIColor clearColor];
    tf.leftView = paddingView;
    tf.leftViewMode = UITextFieldViewModeAlways;
    
    return tf;
}

//#pragma mark -- 纬度
//-(void)getLat
//{
    //if (IS_IOS8) {
        
        //[[CCLocationManager shareLocation] getLocationCoordinate:^(CLLocationCoordinate2D locationCorrrdinate) {
            
            //latString = locationCorrrdinate.latitude;
            ////NSLog(@"%f %f",locationCorrrdinate.latitude,locationCorrrdinate.longitude);
            
        //}];
    //}
    
    
    
//}

//#pragma mark -- 经度
//(void)getLon
//{
    
    //if (IS_IOS8) {
        
        //[[CCLocationManager shareLocation] getLocationCoordinate:^(CLLocationCoordinate2D locationCorrrdinate) {
            
            //NSLog(@"%f %f",locationCorrrdinate.latitude,locationCorrrdinate.longitude);
            
        //}];
    //}
    
//}


//-(void)getCity
//{
    //__block __weak ViewController *wself = self;
    
    //if (IS_IOS8) {
        
        //[[CCLocationManager shareLocation]getCity:^(NSString *cityString) {
            //NSLog(@"%@",cityString);
            //[wself setLabelText:cityString];
            
        //}];
        
    //}
    
//}


//-(void)getAllInfo
//{
    //__block NSString *string;
    //__block __weak ViewController *wself = self;
    
    
    //if (IS_IOS8) {
        
        //[[CCLocationManager shareLocation]getLocationCoordinate:^(CLLocationCoordinate2D locationCorrrdinate) {
            //string = [NSString stringWithFormat:@"%f %f",locationCorrrdinate.latitude,locationCorrrdinate.longitude];
        //} withAddress:^(NSString *addressString) {
            //NSLog(@"%@",addressString);
            //string = [NSString stringWithFormat:@"%@\n%@",string,addressString];
            //[wself setLabelText:string];
            
        //}];
    //}
    
//}





@end

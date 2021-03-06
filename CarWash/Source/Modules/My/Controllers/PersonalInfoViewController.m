//
//  PersonalInfoViewController.m
//  CarWash
//
//  Created by xa on 16/7/26.
//  Copyright © 2016年 xiyangyang. All rights reserved.
//                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                    

#import "PersonalInfoViewController.h"
#import "DefineConstant.h"
#import "MyManager.h"
#import "AFHTTPRequestOperationManager.h"
#import "UIImageView+AFNetworking.h"
#import "UIImageView+WebCache.h"
@interface PersonalInfoViewController ()<UIImagePickerControllerDelegate, UINavigationControllerDelegate,BZEventCenterDelegate>

@end

@implementation PersonalInfoViewController

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [[BZEventCenter defaultCenter]subscribeWithEventType:CWEventCenterTypeUploadImage callback:self];
    [[BZEventCenter defaultCenter] subscribeWithEventType:CWEventCenterTypePersonalInfo callback:self];
    self.tabBarController.tabBar.hidden = YES;
}
-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [[BZEventCenter defaultCenter]cancelSubscribeWithEventType:CWEventCenterTypeUploadImage callback:self];
    [[BZEventCenter defaultCenter] cancelSubscribeWithEventType:CWEventCenterTypePersonalInfo callback:self];
    self.tabBarController.tabBar.hidden = NO;
}
#pragma mark - BZEventCenterDelegate
-(void)eventCenter:(BZEventCenter *)eventCenter eventType:(NSString *)eventType callbackParam:(id)param
{
    if([eventType isEqualToString:CWEventCenterTypeUploadImage]){
        NSLog(@"param;%@", param);
        [COM saveUserURL:param[@"head_img"]];
        NSString *imageString = [NSString stringWithFormat:@"%@%@/%@", @"http://", API_SERVER_HOST, param[@"head_img"]];
        NSURL *URL = [NSURL URLWithString:imageString];
        [self.personalImage sd_setImageWithURL:URL placeholderImage:[UIImage imageNamed:@"头像(未登录)"]];
    }else {
        
    }
    if ([eventType isEqualToString:CWEventCenterTypePersonalInfo]) {
        NSLog(@"%@",param);
        [COM saveLoginName:param[@"name"]];
        [COM saveUserSex:param[@"sex"]];
        
        [self.navigationController popViewControllerAnimated:YES];
    }
}




- (IBAction)personalImagePickButtonAction:(UIButton *)sender {
    [self photoSelect];
}
- (IBAction)genderSelectButtonAction:(UIButton *)sender {
    [self genderSelect];
}

#pragma mark--选择性别方法
- (void)genderSelect{
    UIAlertController *alertC = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    UIAlertAction *action_1 = [UIAlertAction actionWithTitle:@"男" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        self.genderLabel.text = action.title;
        
    }];
    [action_1 setValue:[UIColor grayColor] forKey:@"titleTextColor"];
    UIAlertAction *action_2 = [UIAlertAction actionWithTitle:@"女" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        self.genderLabel.text = action.title;
    }];
    [action_2 setValue:[UIColor grayColor] forKey:@"titleTextColor"];
    UIAlertAction *action_3 = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    [action_3 setValue:[UIColor blackColor] forKey:@"titleTextColor"];
    [alertC addAction:action_2];
    [alertC addAction:action_3];
    [alertC addAction:action_1];
    [self presentViewController:alertC animated:YES completion:nil];
}
#pragma mark--选择照片方法
- (void)photoSelect{
    UIAlertController *alertVC = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:(UIAlertControllerStyleActionSheet)];
    
    UIAlertAction *alertAction = [UIAlertAction actionWithTitle:@"相册" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action){
        
        //sourceType 是用来确认用户界面样式, 选择相册
        UIImagePickerControllerSourceType sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        
        UIImagePickerController *imagePicker = [[UIImagePickerController alloc] init];
        //设置代理
        imagePicker.delegate = self;
        //允许编辑弹框
        imagePicker.allowsEditing = YES;
        //使用手机相册来获取图片的
        imagePicker.sourceType = sourceType;
        
        //模态推出pickViewController
        [self presentViewController:imagePicker animated:YES completion:nil];
    }];
    
    UIAlertAction *alertAction1 = [UIAlertAction actionWithTitle:@"相机拍照" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        //sourceType 是用来确认用户界面的样式, 选择相机
        UIImagePickerControllerSourceType sourceType = UIImagePickerControllerSourceTypeCamera;
        
        UIImagePickerController *imagePicker = [[UIImagePickerController alloc]init];
        //设置代理
        imagePicker.delegate = self;
        //允许编辑弹框
        imagePicker.allowsEditing = YES;
        //使用相机来获取图片
        imagePicker.sourceType = sourceType;
        //模态推出pickViewController
        [self presentViewController:imagePicker animated:YES completion:nil];
    }];
    
    UIAlertAction *alertAction2 = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
    
    [alertVC addAction:alertAction];
    [alertVC addAction:alertAction1];
    [alertVC addAction:alertAction2];
    //模态推出
    [self presentViewController:alertVC animated:YES completion:nil];
}
//选择完图片后会回调 didFinishPickingMediaWithInfo 这个方法
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info{
    NSLog(@"info = %@",info);
    
    //隐藏控制器
    [picker dismissViewControllerAnimated:YES completion:nil];
    //给imageView 赋值图片
    
    UIImage *image = [info objectForKey:UIImagePickerControllerEditedImage];
    self.personalImage.image = image;
    
    
    NSData *data = UIImagePNGRepresentation(image);
    NSMutableArray *array  = [[NSMutableArray alloc] initWithObjects:image, image, image, nil];
    SQRUploadParam *param = [[SQRUploadParam alloc] init];
    param.imageData  = data;
    param.imageArray = array;
    LC_LOADING
    [[MyManager sharedManager] uploadUserImage:param];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setBackBarButton];
    self.title = @"个人资料";
    
    self.accountNumber.text = [COM getLoginPhone];
    if ([[COM getLoginName] isEqualToString:@"<null>"]) {
        
    }else{
        self.nameTextFiled.text = [COM getLoginName];
    }
    
    self.genderLabel.text = [COM getUserSex];
    NSString *imageStringUrl = [NSString stringWithFormat:@"http://%@/%@", API_SERVER_HOST, [COM getUserURL]];
    NSURL *URL = [NSURL URLWithString:imageStringUrl];
    [self.personalImage sd_setImageWithURL:URL placeholderImage:[UIImage imageNamed:@"头像(未登录)"]];
    
    UIColor *color = [UIColor darkGrayColor];
    self.navigationItem.rightBarButtonItem =
    [UIBarButtonItem barButtonItemWithBackgroundImage:nil
                                     highlightedImage:nil
                                               titles:@"保存"
                                                alpha:0.3f
                                                color:color
                                               target:self
                                               action:@selector(saveAction:)
                                     forControlEvents:UIControlEventTouchUpInside];
}
#pragma mark -- 保存编辑用户信息
- (void)saveAction:(UIBarButtonItem *)sender{
    
    NSString *name = self.nameTextFiled.text;
    NSString *sex = self.genderLabel.text;
    
    if ([name isEqualToString:@""]) {
        LCFAIL_ALERT(@"姓名不能为空");
        name = @"";
        return;
    }
    if (!sex) {
        LCFAIL_ALERT(@"性别不能为空");
        sex = @"";
        return;
    }
    LC_LOADING
    [[MyManager sharedManager]editUserInfo:name sex:sex];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end

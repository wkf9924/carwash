//
//  SeviceDetailViewController.m
//  CarWash
//
//  Created by xa on 16/7/25.
//  Copyright © 2016年 xiyangyang. All rights reserved.
//

#import "SeviceDetailViewController.h"
#import "DefineConstant.h"
#import "SevicePhotoCell.h"
#import "CarBrandManager.h"
#import "SeviceDedailModel.h"
#import "UIImageView+WebCache.h"
#import "CommonPayViewController.h"
#import "PayForWashViewController.h"

@interface SeviceDetailViewController ()<UITableViewDelegate, UITableViewDataSource,BZEventCenterDelegate>
@property (nonatomic, strong)SeviceDedailModel *seviceDetailModel;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *contentHeight;
@property (nonatomic, strong)NSMutableArray *imageURlArray;
@end

@implementation SeviceDetailViewController
-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [[BZEventCenter defaultCenter]cancelSubscribeWithEventType:CWEventCenterTypeSellerServiceInfo callback:self];
    self.tabBarController.tabBar.hidden = NO;
}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [[BZEventCenter defaultCenter]subscribeWithEventType:CWEventCenterTypeSellerServiceInfo callback:self];
    self.tabBarController.tabBar.hidden = YES;
}
- (void)eventCenter:(BZEventCenter *)eventCenter eventType:(NSString *)eventType callbackParam:(id)param{
    if ([eventType isEqualToString:CWEventCenterTypeSellerServiceInfo]) {
        NSLog(@"===********+++++ %@",param);
        [self.seviceDetailModel setValuesForKeysWithDictionary:param];
    }else{
    }
    [self interfaceAssignmentOperation];
    [self.seviceTableView reloadData];
}
//界面控件赋值操作
- (void)interfaceAssignmentOperation{
    
    self.seviceType.text = self.seviceDetailModel.type;
    self.seviceName.text = self.seviceDetailModel.name;
    self.sevicePrice.text = [NSString stringWithFormat:@"%@ 元", self.seviceDetailModel.price];
    self.seviceValidTime.text = [NSString stringWithFormat:@"%@ - %@",self.seviceDetailModel.start_time,self.seviceDetailModel.end_time];
    
    NSString *describe = self.seviceDetailModel.describe;
    CGSize size = [describe boundingRectWithSize:CGSizeMake(400, 10000) // 用于计算文本绘制时占据的矩形块
                                         options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading // 文本绘制时的附加选项
                                      attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:13]}        // 文字的属性
                                         context:nil].size;
    self.contentHeight.constant = size.height + 40;
    
    self.seviceContent.text = self.seviceDetailModel.describe;
    NSString *imageString = self.seviceDetailModel.img_url;
    if (imageString.length != 0) {
        NSArray *imageArr = [imageString componentsSeparatedByString:@";"];
        for (int i = 0; i < imageArr.count;i++) {
            NSString *url = [NSString stringWithFormat:@"http://%@/%@",API_SERVER_HOST,imageArr[i]];
            [self.imageURlArray addObject:url];
        }
    }
    //图片地址
    //http://192.168.2.249:8081/carwash/upload/20160908/39011473333328223.png
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self setBackBarButton];
    self.title = @"服务详情";
    [[CarBrandManager sharedManager] sellerServiceInfo:self.serviceId];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
//支付按钮回调
- (IBAction)payButton:(UIButton *)sender {
    PayForWashViewController *payForWash = [[UIStoryboard storyboardWithName:@"Pay" bundle:nil] instantiateViewControllerWithIdentifier:@"PayForWashVC"];
    payForWash.serviceModel = self.seviceDetailModel;
    payForWash.interface = @"服务支付";
    payForWash.sellerID = self.sellerID;
    [self.navigationController pushViewController: payForWash animated:YES];
    
}
#pragma mark tableView代理方法实现
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.imageURlArray.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    SevicePhotoCell *cell = [tableView dequeueReusableCellWithIdentifier:@"SevicePhotoCell" forIndexPath:indexPath];
    NSString *imageString = self.imageURlArray[indexPath.row];
    [cell.sevicePhoto sd_setImageWithURL:[NSURL URLWithString:imageString] placeholderImage:[UIImage imageNamed:@"上传服务照片底色"]];
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 200;
}
- (SeviceDedailModel *)seviceDetailModel{
    if (!_seviceDetailModel) {
        _seviceDetailModel = [[SeviceDedailModel alloc] init];
    }
    return _seviceDetailModel;
}
- (NSMutableArray *)imageURlArray{
    if (!_imageURlArray) {
        _imageURlArray = [[NSMutableArray alloc] init];
    }
    return _imageURlArray;
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

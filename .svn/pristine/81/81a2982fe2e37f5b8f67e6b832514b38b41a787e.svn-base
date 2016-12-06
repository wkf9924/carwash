//
//  SetingViewController.m
//  CarWash
//
//  Created by WangKaifeng on 16/7/15.
//  Copyright © 2016年 xiyangyang. All rights reserved.
//

#import "SetingViewController.h"
#import "DefineConstant.h"
#import "SetingCell.h"
#import "CustomCell.h"
#import "PersonalInfoViewController.h"

#import "PersonallInfoModel.h"
#import "MyManager.h"
#import "ForgetViewController.h"
#import "CWLoginViewController.h"
#import "SecretChangeVC.h"
#import "My_userDelegateVC.h"
#import "LegalNoticesVC.h"

@interface SetingViewController () <UITableViewDelegate, UITableViewDataSource,BZEventCenterDelegate>
@property (weak, nonatomic) IBOutlet UITableView *myTableView;
@property (weak, nonatomic) IBOutlet UIView *myFootView;
@property (nonatomic, strong)PersonallInfoModel *personallModel;

- (IBAction)signOutAction:(id)sender;

@end

@implementation SetingViewController

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [[BZEventCenter defaultCenter]subscribeWithEventType:CWEventCenterTypePersonalInfo callback:self];
    self.tabBarController.tabBar.hidden = YES;
}
-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [[BZEventCenter defaultCenter]cancelSubscribeWithEventType:CWEventCenterTypePersonalInfo callback:self];
    self.tabBarController.tabBar.hidden = NO;
}

#pragma mark - BZEventCenterDelegate
-(void)eventCenter:(BZEventCenter *)eventCenter eventType:(NSString *)eventType callbackParam:(id)param
{
    NSLog(@"----------%@",param);
    if([eventType isEqualToString:CWEventCenterTypePersonalInfo]){
        [self.personallModel setValuesForKeysWithDictionary:param];
    }else {
        
    }
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"设置";
    [self setBackBarButton];
    self.myTableView.delegate = self;
    self.myTableView.dataSource = self;
    _myTableView.tableFooterView = _myFootView;
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

#pragma mark - Table View

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    switch (section) {
        case 0:
            return 2;
            break;
        case 1:
            return 2;
            break;
        default:
            break;
    }
    return 1;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellIdenifer = @"SetingCell";
    SetingCell *cell = [_myTableView dequeueReusableCellWithIdentifier:cellIdenifer];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    NSInteger section = indexPath.section;
    NSInteger row = indexPath.row;
    NSString *rowString = [NSString stringWithFormat:@"%ld%ld", section,row];
    NSString *imString = [NSString stringWithFormat:@"set%@", rowString];
    NSLog(@"image%@", imString);
    cell.imIcon.image = [UIImage imageNamed:imString];
    
    if ([rowString isEqualToString:@"00"]) {
        cell.lbTitle.text = @"个人资料";
    } else if ([rowString isEqualToString:@"01"]) {
        cell.lbTitle.text = @"密码管理";
    } else if ([rowString isEqualToString:@"10"]) {
        cell.lbTitle.text = @"关于我们";
    } else {
        cell.lbTitle.text = @"法律条款";
    }
    return cell;
}

//section头部间距
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    return 0;
    
}

//section底部间距
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 5;
}
//cell的点击回调
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if (indexPath.row == 0 && indexPath.section == 0) {
        UIStoryboard *storyboard =[UIStoryboard storyboardWithName:@"Seting" bundle:nil];
        PersonalInfoViewController *personalInfoVC = [storyboard instantiateViewControllerWithIdentifier:@"PersonalInfoViewController"];
        personalInfoVC.personallInfo = self.personallModel;
        [self.navigationController pushViewController:personalInfoVC animated:YES];
    } else if (indexPath.row == 1 && indexPath.section == 0) {
        //修改密码
        UIStoryboard *storyboard =[UIStoryboard storyboardWithName:@"Seting" bundle:nil];
         SecretChangeVC *Secret = [storyboard instantiateViewControllerWithIdentifier:@"SecretChangeVC"];
        [self.navigationController pushViewController:Secret animated:YES];
    }else if (indexPath.row == 0 && indexPath.section == 1){
        UIStoryboard *storyBoard = [UIStoryboard storyboardWithName:@"Seting" bundle:nil];
        My_userDelegateVC *my_userdelegate = [storyBoard instantiateViewControllerWithIdentifier:@"My_userDelegateVC"];
        [self.navigationController pushViewController:my_userdelegate animated:YES];
    }else if (indexPath.row == 1 && indexPath.section == 1){
        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Seting" bundle:nil];
        LegalNoticesVC *legalNotices = [storyboard instantiateViewControllerWithIdentifier:@"LegalNoticesVC"];
        [self.navigationController pushViewController:legalNotices animated:YES];
    }
}
- (PersonallInfoModel *)personallModel{
    if (!_personallModel) {
        _personallModel  = [[PersonallInfoModel alloc] init];
    }
    return _personallModel;
}
#pragma mark --  退出登录
- (IBAction)signOutAction:(id)sender {
    
    UIAlertController *alertC = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    UIAlertAction *action_1 = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [Common sharedInstance].isBind = NO;
        
        [COM saveLoginToken:@""];
        [COM saveLoginPhone:@""];
        [COM saveLoginName:@""];
        [COM saveUserURL:@""];
        [COM saveCarPlate:@""];
        [COM saveCarType:@""];
        [COM saveCarImage:@""];
        [COM saveUserId:@""];
        [COM saveVip:@""];
        [COM saveCarID:@""];
        [COM saveUserBlance:@""];
        [COM saveTiketCount:@""];
        [COM saveBankCardCount:@""];
        [COM saveCarFrameNum:@""];
        [COM saveCarEngineNum:@""];
        [COM saveCarsName:@""];
//        [COM removePersistent];
        LCSUCCESS_ALSERT(@"退出成功！");
        [self popViewController];
    }];
    [action_1 setValue:[UIColor redColor] forKey:@"titleTextColor"];
    
    UIAlertAction *action_2 = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
    }];
   
    [alertC addAction:action_2];
    [alertC addAction:action_1];
    [self presentViewController:alertC animated:YES completion:nil];
    
    
    

}@end

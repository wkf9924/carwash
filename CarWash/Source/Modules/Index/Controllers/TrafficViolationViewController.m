//
//  TrafficViolationViewController.m
//  CarWash
//
//  Created by xa on 16/7/26.
//  Copyright © 2016年 xiyangyang. All rights reserved.
//

#import "TrafficViolationViewController.h"
#import "DefineConstant.h"
#import "CarBrandManager.h"

@interface TrafficViolationViewController ()<UIPickerViewDelegate,UIPickerViewDataSource,BZEventCenterDelegate>
@property (nonatomic, strong)UITapGestureRecognizer *tap;
@property (nonatomic, strong)UIAlertController *alertC;
@property (nonatomic, strong)UIView *myView;
@property (nonatomic, strong)UIPickerView *pickerView;

@property (nonatomic, strong)NSMutableArray *dataArray;
@property (nonatomic, strong)NSMutableArray *citiesArray;
@property (nonatomic, strong)NSString *status;//省,直辖市
@property (nonatomic, strong)NSString *city;//地区
@property (nonatomic, strong)NSString *firstString;//省,直辖市 首字母大写

@property (nonatomic, strong)NSString *cityCode;//城市编码,如  陕西-西安  SX_XA
@property (nonatomic, strong)NSString *searchAddressText;//保存已选择的城市
@end

@implementation TrafficViolationViewController
//发动机型号帮助按钮回调
- (IBAction)EngineButtonAction:(UIButton *)sender {
    self.myView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height)];
    self.myView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.4];
    [[UIApplication sharedApplication].windows[0] addSubview:self.myView];
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(20, 214, self.view.frame.size.width-60, (self.view.frame.size.width-60) * 390 / 545)];
    imageView.image = [UIImage imageNamed:@"发动机号提示信息"];
    [self.myView addSubview:imageView];
    
    [self.myView addGestureRecognizer:self.tap];
}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.tabBarController.tabBar.hidden = YES;
    [[BZEventCenter defaultCenter] subscribeWithEventType:CWEventCenterTypeCityCode callback:self];
    [[BZEventCenter defaultCenter] subscribeWithEventType:CWEventCenterTypeCityCodeFail callback:self];
    
    
    [[BZEventCenter defaultCenter] subscribeWithEventType:CWEventCenterTypeBindingMyCar callback:self];
}
#pragma mark == 保存按钮回调
- (IBAction)queryViolationButtonAction:(id)sender {
    
    if (self.carFrameNumber.text.length == 0) {
        LCSUCCESS_ALSERT(@"车辆识别代码不能为空,请查看行驶证后填写!");
    }else if (self.EngineNumber.text.length == 0){
        LCSUCCESS_ALSERT(@"发动机号码不能为空,请查看行驶证后填写!");
        
    }else if (self.searchAddress.text.length == 0){
        LCSUCCESS_ALSERT(@"请选择查询城市!");
    }else{
        NSLog(@"%@==%@",[COM getLoginToken],[COM logoIconStr]);
        [[CarBrandManager sharedManager] carBranding:[COM getCarsName] carNumber:[COM getCarPlate] carType:[COM getCarType] carLogo:[COM logoIconStr] carModel:[COM getCarModel] carFrame:self.carFrameNumber.text engine:self.EngineNumber.text city:self.searchAddress.text];
    }
}
- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    self.tabBarController.tabBar.hidden = NO;
    [[BZEventCenter defaultCenter] cancelSubscribeWithEventType:CWEventCenterTypeCityCode callback:self];
    [[BZEventCenter defaultCenter] cancelSubscribeWithEventType:CWEventCenterTypeCityCodeFail callback:self];
    [[BZEventCenter defaultCenter] cancelSubscribeWithEventType:CWEventCenterTypeBindingMyCar callback:self];
}
- (void)eventCenter:(BZEventCenter *)eventCenter eventType:(NSString *)eventType callbackParam:(id)param{
    if ([eventType isEqualToString:CWEventCenterTypeCityCode]) {
        NSLog(@"城市编码返回数据:%@",param);
        
        self.cityCode = param[@"city_code"];
        COM.cityCode = param[@"city_code"];
        self.searchAddress.text = self.searchAddressText;
    }else if ([eventType isEqualToString:CWEventCenterTypeCityCodeFail]){
        self.searchAddress.text = @"";
    }
    if ([eventType isEqualToString:CWEventCenterTypeBindingMyCar]) {
        NSLog(@"编辑爱车动作:%@",param);
        [COM saveCarEngineNum:self.EngineNumber.text];//发动机号
        [COM saveCarFrameNum:self.carFrameNumber.text];//车架号
        COM.city = self.searchAddress.text;//查询城市
        LCSUCCESS_ALSERT(@"保存成功,请返回查询!");
        [self.navigationController popToRootViewControllerAnimated:YES];
    }
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title  = @"查询违章";
    [self setBackBarButton];
    self.pickerView = [[UIPickerView alloc] initWithFrame:self.searchAddress.inputView.frame];
    self.pickerView.delegate = self;
    self.pickerView.dataSource = self;
    
    self.searchAddress.inputView = self.pickerView;
    
    [self loadData];
    
    if ([[COM getCarEngineNum] isEqualToString: @"<null>"]) {
        
    }else{
        self.EngineNumber.text = [COM getCarEngineNum];
    }
    if ([[COM getCarFrameNum] isEqualToString:@"<null>"]) {
        
    }else{
        self.carFrameNumber.text = [COM getCarFrameNum];
    }
    if ([[COM city] isEqualToString:@"<null>"]) {
        
    }else{
        self.searchAddress.text = [COM city];
    }
    
    
    
}
- (void)loadData {
    NSBundle *bundle = [NSBundle mainBundle];
    NSString *path = [bundle pathForResource:@"city" ofType:@"plist"];
    self.dataArray = [NSMutableArray arrayWithContentsOfFile:path];
    self.citiesArray = self.dataArray[0][@"cities"];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (UITapGestureRecognizer *)tap{
    if (!_tap) {
        _tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapAction:)];
    }
    return _tap;
}
- (void)tapAction:(UIGestureRecognizer *)sender{
    [self.myView removeFromSuperview];
    [self.myView removeGestureRecognizer:sender];
}
//列数
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return 2;
}

// returns the # of rows in each component..
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    if (component == 0) {
        return self.dataArray.count;
    }else {
        return self.citiesArray.count;
    }
    
}
#pragma mark - delegate
- (CGFloat)pickerView:(UIPickerView *)pickerView widthForComponent:(NSInteger)component {
    return self.view.frame.size.width/2-20;
}
- (CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component {
    return 30;
}
//返回每行显示的内容
- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    if (component == 0) {
        return [NSString stringWithFormat:@"%@",self.dataArray[row][@"state"]];
    }else {
        return [NSString stringWithFormat:@"%@",self.citiesArray[row]];
    }
}
- (NSString *)firstCharactor:(NSString *)aString
{
    NSString *temp = nil;
    NSMutableString *mutableString = [NSMutableString string];
    for(int i = 0; i < [aString length]; i++){
        temp = [aString substringWithRange:NSMakeRange(i, 1)];
        NSLog(@"第%d个字是:%@",i,temp);
        //转成了可变字符串
        NSMutableString *str = [NSMutableString stringWithString:temp];
        //先转换为带声调的拼音
        CFStringTransform((CFMutableStringRef)str,NULL, kCFStringTransformMandarinLatin,NO);
        //再转换为不带声调的拼音
        CFStringTransform((CFMutableStringRef)str,NULL, kCFStringTransformStripDiacritics,NO);
        //转化为大写拼音
        NSString *pinYin = [str capitalizedString];
        //获取并返回首字母
        NSString *result =  [pinYin substringToIndex:1];
        [mutableString appendString:result];
        
    }
    //获取并返回首字母
    return mutableString;
}
//当改变省份时，重新加载第2列的数据，部分加载
- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    if (component == 0) {
        self.citiesArray = self.dataArray[row][@"cities"];
        [self.pickerView reloadComponent:1];
        self.status = [NSString stringWithFormat:@"%@",self.dataArray[row][@"state"]];
        NSLog(@"首字母大写::%@",[self firstCharactor:self.status]);
        self.firstString = [self firstCharactor:self.status];
    }
    if (component == 1) {
        self.city = [NSString stringWithFormat:@"%@",self.citiesArray[row]];
        self.searchAddressText = [NSString stringWithFormat:@"%@%@",self.status,self.city];
        
        [[CarBrandManager sharedManager] searchCityCode:self.firstString city:self.city];
        
//        http://192.168.2.249:8081/carwash/car/cityQuery?token=MTg3MTA3MjcwNzJ8MjAxNi0xMC0yMXxmYTVjMGRlYzAyZmU0YmMwYmVmNmM2ZjVlYzRmMzRkNA==&province_code=SX&city=西安
    }
    
}
- (NSMutableArray *)dataArray {
    if (!_dataArray) {
        _dataArray = [[NSMutableArray alloc] init];
    }
    return _dataArray;
}
- (NSMutableArray *)citiesArray{
    if (!_citiesArray) {
        _citiesArray = [NSMutableArray array];
    }
    return _citiesArray;
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

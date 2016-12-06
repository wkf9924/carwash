//
//  EditMyCarViewController.m
//  CarWash
//
//  Created by xa on 16/7/28.
//  Copyright © 2016年 xiyangyang. All rights reserved.
//

#import "EditMyCarViewController.h"
#import "DefineConstant.h"
#import "Definition.h"
#import "SelectProvinceViewController.h"
#import "SelectCarViewController.h"
#import "UIImageView+WebCache.h"
#import "MyCarDetailModel.h"
#import "CarBrandManager.h"
#import "MyManager.h"
#import "MyLoveCarParam.h"

@interface EditMyCarViewController ()<SelectProvinceViewControllerDelegate,BZEventCenterDelegate,SelectProvinceViewControllerDelegate,UIPickerViewDelegate,UIPickerViewDataSource>
@property (nonatomic, strong)MyCarDetailModel *myCarDetailModel;
@property (nonatomic, strong)MyLoveCarParam *myLoveCarParam;
@property (nonatomic, strong)NSString *logoString;
@property (nonatomic, strong)NSString *car_brand;
@property (nonatomic, strong)NSString *carTypeString;

@property (nonatomic, strong)UIPickerView *pickerView;

@property (nonatomic, strong)NSMutableArray *dataArray;
@property (nonatomic, strong)NSMutableArray *citiesArray;
@property (nonatomic, strong)NSString *status;//省,直辖市
@property (nonatomic, strong)NSString *city;//地区
@property (nonatomic, strong)NSString *firstString;//省,直辖市 首字母大写
@property (nonatomic, strong)NSString *cityCode;//城市编码,如  陕西-西安  SX_XA
@property (nonatomic, strong)NSString *previnceTownText;//保存已选择的城市
@end

@implementation EditMyCarViewController
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.tabBarController.tabBar.hidden = YES;
    [[BZEventCenter defaultCenter] subscribeWithEventType:CWEventCenterTypeCarDetailInfo callback:self];
    [[BZEventCenter defaultCenter] subscribeWithEventType:CWEventCenterTypeBindingMyCar callback:self];
    [[BZEventCenter defaultCenter] subscribeWithEventType:CWEventCenterTypeCityCode callback:self];
    [[BZEventCenter defaultCenter] subscribeWithEventType:CWEventCenterTypeCityCodeFail callback:self];
    
    [self interfaceAssignmentOpretion];
}
- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    self.tabBarController.tabBar.hidden = NO;
    [[BZEventCenter defaultCenter] cancelSubscribeWithEventType:CWEventCenterTypeCarDetailInfo callback:self];
    [[BZEventCenter defaultCenter] cancelSubscribeWithEventType:CWEventCenterTypeBindingMyCar callback:self];
    [[BZEventCenter defaultCenter] cancelSubscribeWithEventType:CWEventCenterTypeCityCode callback:self];
    [[BZEventCenter defaultCenter] cancelSubscribeWithEventType:CWEventCenterTypeCityCodeFail callback:self];
}

- (void)eventCenter:(BZEventCenter *)eventCenter eventType:(NSString *)eventType callbackParam:(id)param{
    if ([eventType isEqualToString:CWEventCenterTypeCityCode]) {
        NSLog(@"城市编码返回数据:%@",param);
        
        self.cityCode = param[@"city_code"];
        COM.cityCode = param[@"city_code"];
        self.prevince_townText.text = self.previnceTownText;
    }else if ([eventType isEqualToString:CWEventCenterTypeCityCodeFail]){
        self.prevince_townText.text = @"";
    }
    if ([eventType isEqualToString:CWEventCenterTypeBindingMyCar]){
        NSLog(@"编辑爱车动作:%@",param);
        [COM saveCarEngineNum:self.engineNumber.text];//发动机号
        [COM saveCarFrameNum:self.carFrameNumberText.text];//车架号
//        [COM saveCarType:self.carsLabel.text];//具体车型
        [COM saveCarModel:self.carBrandType.text];
        [COM saveCarsName:self.carsLabel.text];
        [COM saveCarImage:COM.logoIconStr];
        [COM saveCarPlate:[NSString stringWithFormat:@"%@%@", self.provinceLabel.text,self.carNumberText.text]];//车牌号
        LCSUCCESS_ALSERT(@"编辑成功,请继续使用!");
        [self.navigationController popToRootViewControllerAnimated:YES];
    }else {
        
    }
    
    if ([eventType isEqualToString:CWEventCenterTypeCarDetailInfo]) {
        NSLog(@"车辆详情::%@",param);
        if ([param[@"car_engine"] isEqual:[NSNull null]]) {
           
        }else{
            self.engineNumber.text = param[@"car_engine"];
        }
        if ([param[@"car_frame"] isEqual:[NSNull null]]) {
            
        }else{
            self.carFrameNumberText.text = param[@"car_frame"];
        }
        if ([param[@"car_model"] isEqual:[NSNull null]]) {
            
        }else{
            self.carBrandType.text = param[@"car_model"];
        }
        if ([param[@"city"] isEqual:[NSNull null]]) {
            
        }else{
            self.prevince_townText.text = param[@"city"];
        }
        self.carsLabel.text = [NSString stringWithFormat:@"%@", param[@"car_brand"]];
        self.logoString = [ NSString stringWithFormat:@"%@",param[@"brand_logo"]];
        self.car_brand = [NSString stringWithFormat:@"%@",param[@"car_brand"]];
        [self.carImage sd_setImageWithURL:[NSURL URLWithString:param[@"brand_logo"]] placeholderImage:[UIImage imageNamed:@"绑定爱车"]];
        self.provinceLabel.text = [param[@"car_plate"] substringToIndex:1];//省份
        self.carNumberText.text = [param[@"car_plate"] substringFromIndex:1];
        
    }
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self setBackBarButton];
    self.title = @"编辑爱车";
    
    if ([COM getCarID] == nil || [[COM getCarID] isEqualToString:@"<null>"]) {
        return;
    }else{
        LC_LOADING
        [[MyManager sharedManager] carInfo:[COM getCarID]];
    }
    
    self.pickerView = [[UIPickerView alloc] initWithFrame:self.prevince_townText.inputView.frame];
    self.pickerView.delegate = self;
    self.pickerView.dataSource = self;
    
    self.prevince_townText.inputView = self.pickerView;
    
    [self loadData];
    
}
- (void)loadData {
    NSBundle *bundle = [NSBundle mainBundle];
    NSString *path = [bundle pathForResource:@"city" ofType:@"plist"];
    self.dataArray = [NSMutableArray arrayWithContentsOfFile:path];
    self.citiesArray = self.dataArray[0][@"cities"];
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
        self.previnceTownText = [NSString stringWithFormat:@"%@%@",self.status,self.city];
        
        [[CarBrandManager sharedManager] searchCityCode:self.firstString city:self.city];
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
- (void)interfaceAssignmentOpretion{
    
    if ([COM logoIconStr]) {
        [self.carImage sd_setImageWithURL:[NSURL URLWithString:[COM logoIconStr]] placeholderImage:[UIImage imageNamed:@"绑定爱车"]];//爱车Logo
    }
    if ([COM seriesNameStr]) {
        self.carsLabel.text = [COM seriesNameStr];//具体车型,例:2017款 豪华版
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
//选择车品牌按钮回调
- (IBAction)selectCarBrandAction:(UIButton *)sender {
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Binding" bundle:nil];
    SelectCarViewController *selectCarVC = [storyboard instantiateViewControllerWithIdentifier:@"SelectCarVC"]
    ;
    [self.navigationController pushViewController:selectCarVC animated:YES];
}
//选择车牌号省份按钮回调
- (IBAction)selectProvinceAction:(id)sender {
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Binding" bundle:nil];
    SelectProvinceViewController *selectProvinceVC = [storyboard instantiateViewControllerWithIdentifier:@"SelectProvinceVC"]
    ;
    //指定代理
    selectProvinceVC.delegate = self;
    [self.navigationController pushViewController:selectProvinceVC animated:YES];
}
- (void)sendValue:(NSString *)province{
    self.provinceLabel.text =[province substringToIndex:1];
    self.myLoveCarParam.carNumber = [self.provinceButton.titleLabel.text  stringByAppendingFormat:@"%@",self.carNumberText.text];
}

//保存按钮回调
- (IBAction)saveButtonAction:(UIButton *)sender {
    if (self.carsLabel.text.length == 0 || [self.carsLabel.text isEqual:[NSNull null]]) {
        LCSUCCESS_ALSERT(@"您还没有选择爱车!");
    }else if (self.carImage.image == [UIImage imageNamed:@"preferential_logo_bg_icon"]) {
        LCSUCCESS_ALSERT(@"您还没有选择爱车");
    }else if ([self.provinceLabel.text isEqualToString:@"省"] || self.provinceLabel.text == nil) {
        LCSUCCESS_ALSERT(@"请点击省份按钮选择车牌地区");
    }else if (self.carNumberText.text == nil){
        LCSUCCESS_ALSERT(@"请填写车牌号码");
        
    }else{
        NSString *imageString;
        if ([COM logoIconStr]) {
            imageString = [COM logoIconStr];
        }else{
            imageString = self.logoString;
        }
        
        NSString *carBrand;
        if ([COM brandName]) {
            carBrand = [COM brandName];
        }else{
            carBrand = self.car_brand;
        }
        
        if (self.carFrameNumberText.text.length == 0) {
            self.carFrameNumberText.text = @"";
        }
        if (self.carBrandType.text.length == 0) {
            self.carBrandType.text = @"";
        }
        if (self.engineNumber.text.length == 0) {
            self.engineNumber.text = @"";
        }
        if (self.prevince_townText.text.length == 0) {
            self.prevince_townText.text = @"";
        }
        NSString *series;
        if ([COM seriesNameStr]) {
            series = [COM seriesNameStr];
        }else{
            series = @"";
        }
        NSString *searchText = self.carNumberText.text;
        NSError *error = NULL;
        NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:@"^[A-Z]{1}[A-Z_0-9]{5}$" options:NSRegularExpressionCaseInsensitive error:&error];
        NSTextCheckingResult *result = [regex firstMatchInString:searchText options:0 range:NSMakeRange(0, [searchText length])];
        if (result){
            LC_LOADING
            [[CarBrandManager sharedManager] carBranding:carBrand carNumber:[NSString stringWithFormat:@"%@%@", self.provinceLabel.text,self.carNumberText.text] carType:series carLogo:imageString carModel:[COM getCarType] carFrame:self.carFrameNumberText.text engine:self.engineNumber.text city:self.prevince_townText.text];
        }else{
            LCSUCCESS_ALSERT(@"您输入的车牌号有误");
        }
        
        
    }
}
- (MyLoveCarParam *)myLoveCarParam{
    if (!_myLoveCarParam) {
        _myLoveCarParam = [[MyLoveCarParam alloc] init];
    }
    return _myLoveCarParam;
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

//
//  SelectProvinceViewController.m
//  CarWash
//
//  Created by xa on 16/7/21.
//  Copyright © 2016年 xiyangyang. All rights reserved.
//

#import "SelectProvinceViewController.h"
#import "SelectProvinceCell.h"
#import "DefineConstant.h"

@interface SelectProvinceViewController ()<UICollectionViewDelegate, UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>
@property (strong, nonatomic) IBOutlet UICollectionView *collectionView;
@property (nonatomic, strong)NSArray *stringValue;
@end

@implementation SelectProvinceViewController
- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    self.tabBarController.tabBar.hidden = NO;
}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.tabBarController.tabBar.hidden = YES;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.title = @"选择省份";
    [self setBackBarButton];
    self.collectionView.backgroundColor = [UIColor whiteColor];
    self.collectionView.showsVerticalScrollIndicator = NO;
    [self collectionViewDelegateFlowLayout];
    self.stringValue = [NSArray arrayWithObjects:@"浙(浙江)", @"沪(上海)", @"京(北京)", @"粤(广东)", @"津(天津)",@"苏(江苏)", @"川(四川)",@"辽(辽宁)", @"黑(黑龙江)", @"鲁(山东)", @"湘(湖南)", @"蒙(内蒙古)", @"甘(甘肃)", @"冀(河北)", @"青(青海)", @"新(新疆)",@"陕(陕西)", @"宁(宁夏)", @"皖(安徽)", @"豫(河南)", @"鄂(湖北)", @"晋(山西)", @"渝(重庆)", @"黔(贵州)", @"贵(贵州)",@"桂(广西)", @"藏(西藏)", @"云(云南)", @"赣(江西)", @"吉(吉林)", @"闽(福建)", @"琼(海南)", @"使(大使馆)", nil];
}
- (void)collectionViewDelegateFlowLayout{
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    flowLayout.itemSize = CGSizeMake((self.view.bounds.size.width-20)/3, (self.view.bounds.size.height-160)/11);
    flowLayout.sectionInset = UIEdgeInsetsMake(5, 5, 5, 5);
    flowLayout.minimumLineSpacing = 5;
    flowLayout.minimumInteritemSpacing = 5;
    self.collectionView.collectionViewLayout = flowLayout;
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return 33;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    SelectProvinceCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"SelectProvinceCell" forIndexPath:indexPath];
    cell.provinceLabel.font = [UIFont systemFontOfSize:18];
    cell.provinceLabel.text = self.stringValue[indexPath.row];
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    [collectionView deselectItemAtIndexPath:indexPath animated:YES];
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(sendValue:)]) {
        [self.delegate sendValue:self.stringValue[indexPath.row]];
    }else{
        NSLog(@"没有指定代理人 或者 没有实现代理方法");
    }
    
    [self.navigationController popViewControllerAnimated:YES];
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

@end

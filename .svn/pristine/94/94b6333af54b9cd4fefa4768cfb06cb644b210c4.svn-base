//
//  TabController.m
//  aiYaAngel
//
//  Created by hff on 16/6/1.
//  Copyright © 2016年 threeTi. All rights reserved.
//

#import "TabBarController.h"
#import "TTINavigationController.h"
#import "UIColor+Hex.h"


@interface TabBarController ()<UITabBarControllerDelegate,UITabBarDelegate>

@end

@implementation TabBarController
- (void)viewDidLoad {
    [super viewDidLoad];

    //UIStoryboard *xyy = [UIStoryboard storyboardWithName:@"Index" bundle:nil];
    //TTINavigationController *homeNav1 = [xyy instantiateInitialViewController];
    
    //UIStoryboard *carstore = [UIStoryboard storyboardWithName:@"Mall" bundle:nil];
    //TTINavigationController *homeNav2 = [carstore instantiateInitialViewController];
    
    //UIStoryboard *find = [UIStoryboard storyboardWithName:@"Find" bundle:nil];
    //TTINavigationController *homeNav3 = [find instantiateInitialViewController];
    
    //UIStoryboard *my = [UIStoryboard storyboardWithName:@"My" bundle:nil];
    //TTINavigationController *homeNav4 = [my instantiateInitialViewController];
   
    
    
    //NSArray *controllers = @[homeNav1,homeNav2, homeNav3, homeNav4];
    //self.viewControllers = controllers;
    
    
    //UITabBarItem *tabBarItem1 = [[UITabBarItem alloc]initWithTitle:nil
                                                             //image:[[UIImage imageNamed:@"洗洋洋icon(常态)"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]
                                                     //selectedImage:[[UIImage imageNamed:@"洗洋洋icon(选中)"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
    //UITabBarItem *tabBarItem2 = [[UITabBarItem alloc]initWithTitle:nil
                                                             //image:[[UIImage imageNamed:@"商城icon(常态)"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]
                                                     //selectedImage:[[UIImage imageNamed:@"商城icon(选中)"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
    
    //UITabBarItem *tabBarItem3 = [[UITabBarItem alloc]initWithTitle:nil
                                                             //image:[[UIImage imageNamed:@"发现icon(常态)"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]
                                                     //selectedImage:[[UIImage imageNamed:@"发现icon(选中)"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
    //UITabBarItem *tabBarItem4 = [[UITabBarItem alloc]initWithTitle:nil
                                                             //image:[[UIImage imageNamed:@"我的icon(常态)"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]
                                                     //selectedImage:[[UIImage imageNamed:@"我的icon(选中)"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
   
    

    //tabBarItem1.imageInsets = UIEdgeInsetsMake(5, 0, -5, 0);
    //tabBarItem2.imageInsets = UIEdgeInsetsMake(5, 0, -5, 0);
    //tabBarItem3.imageInsets = UIEdgeInsetsMake(5, 0, -5, 0);
    //tabBarItem4.imageInsets = UIEdgeInsetsMake(5, 0, -5, 0);

   

    //homeNav1.tabBarItem = tabBarItem1;
    //homeNav2.tabBarItem = tabBarItem2;
    //homeNav3.tabBarItem = tabBarItem3;
    //homeNav4.tabBarItem = tabBarItem4;
    
    NSArray *selectAray = @[@"洗洋洋icon(选中)",@"商城icon(选中)",@"发现icon(选中)", @"我的icon(选中)"];
    NSArray *unSelectArray = @[@"洗洋洋icon(常态)",@"商城icon(常态)",@"发现icon(常态)", @"我的icon(常态)"];
    NSArray *titltArray = @[@"洗洋洋",@"车品商城",@"发现",@"我的"];
    self.delegate = self;
    NSArray *allItems = self.tabBar.items;
    for (int i = 0; i<allItems.count; i++)
    {
        //设置每个item的属性
        UITabBarItem *item = allItems[i];
        
        UIImage *selectImage = [[UIImage imageNamed:selectAray[i]] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        item.imageInsets = UIEdgeInsetsMake(5, 0, -5, 0);
        UIImage *unSelectImage = [[UIImage imageNamed:unSelectArray[i]] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        item = [item initWithTitle:titltArray[i] image:unSelectImage selectedImage:selectImage];
    }
    
        [[UITabBarItem appearance] setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor colorWithHexString:@"FF9800" alpha:1.0] } forState:UIControlStateSelected];
        [[UITabBarItem appearance] setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor colorWithHexString:@"4d4d4d" alpha:1.0]} forState:UIControlStateNormal];
    

}

-(BOOL)tabBarController:(UITabBarController *)tabBarController shouldSelectViewController:(UIViewController *)viewController
{
    return YES;
}


- (void)tabBarController:(UITabBarController *)tabBarController didSelectViewController:(UIViewController *)viewController
{
    
}

@end



#import "TTINavigationController.h"
#import "TTINavigationItems.h"
//#import "UIColor+Utils.h"

#define NAVIGATIONBAR_BG_64 @"main_navBG"
#define NAVIGATIONBAR_LEFTITEM_IMAGE @"Home_Nav_bngImage"

@interface TTINavigationController ()<UIGestureRecognizerDelegate>

@end

@implementation TTINavigationController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}



- (void)viewDidLoad
{
    [super viewDidLoad];
    
    //背景图片设置,本app从ios7支持
    //[[UINavigationBar appearance] setBackgroundImage:[UIImage imageNamed:NAVIGATIONBAR_BG_64] forBarPosition:UIBarPositionTopAttached barMetrics:UIBarMetricsDefault];

    //
    //导航栏背景图
    [[UINavigationBar appearance] setBarTintColor:[UIColor redColor]];

    //字体设置
    [[UINavigationBar appearance] setTitleTextAttributes:@{NSFontAttributeName: [UIFont boldSystemFontOfSize:20],NSForegroundColorAttributeName : [UIColor whiteColor]}];
    
    
    [[UINavigationBar appearance] setShadowImage:[[UIImage alloc] init]];
}


#pragma mark - 重载父类进行改写
- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    //先进入子Controller
    [super pushViewController:viewController animated:animated];
    
    
    //使用公共方法创建leftItem
    viewController.navigationItem.leftBarButtonItem = createNavigationButtonItem(nil,
            NAVIGATIONBAR_LEFTITEM_IMAGE,nil,nil,self,@selector(popViewController));
    
 
    //替换掉leftBarButtonItem
//    if (viewController.navigationItem.leftBarButtonItem== nil && [self.viewControllers count] > 1) {
//
//        viewController.navigationItem.leftBarButtonItem = [self customLeftBackButton];
//    }
}

#pragma mark - 自定义返回按钮图片
-(UIBarButtonItem*)customLeftBackButton{
    
    UIImage *image = [UIImage imageNamed:NAVIGATIONBAR_LEFTITEM_IMAGE];
    
    UIButton *backButton = [UIButton buttonWithType:UIButtonTypeCustom];
    backButton.frame = CGRectMake(0, 0, 44, 44);
    [backButton setTitle:@"返回" forState:UIControlStateNormal];
    [backButton setTitleShadowColor:[[UIColor blackColor] colorWithAlphaComponent:0.5] forState:UIControlStateSelected];
    [backButton setImage:image forState:UIControlStateNormal];
    backButton.titleLabel.font = [UIFont systemFontOfSize:15];
    
    
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0f) {
        backButton.imageEdgeInsets = UIEdgeInsetsMake(0, -13, 0, 0);
        backButton.titleEdgeInsets = UIEdgeInsetsMake(0, -11, 0, 0);
    }

    
    [backButton addTarget:self
                   action:@selector(popViewController)
         forControlEvents:UIControlEventTouchUpInside];
    
    backButton.backgroundColor = [UIColor clearColor];
    
    UIBarButtonItem *backItem = [[UIBarButtonItem alloc] initWithCustomView:backButton];
    
    return backItem;
    
}

#pragma mark - 返回按钮事件(pop)
-(void)popViewController
{
    [self popViewControllerAnimated:YES];
}

- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer
{
    if (self.viewControllers.count == 1)//关闭主界面的右滑返回
    {
        return NO;
    }
    else
    {
        return YES;
    }
}


@end

//
//  hDisplayView.m
//  练习
//
//  Created by Hero11223 on 16/5/19.
//  Copyright © 2016年 zyy. All rights reserved.
//

#define MainScreen_width  [UIScreen mainScreen].bounds.size.width//宽
#define MainScreen_height [UIScreen mainScreen].bounds.size.height//高

#import "hDisplayView.h"
#import "Definition.h"

@interface hDisplayView ()<UIScrollViewDelegate>
{
    UIScrollView    *_bigScrollView;
    NSMutableArray  *_imageArray;
    UIPageControl   *_pageControl;
}

@end

@implementation hDisplayView

-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
//        CGFloat sysstring =  [UIScreen mainScreen].bounds.size.height;
        if (IS_IPHONE_4_OR_LESS) {
            _imageArray = [@[@"960_1.png",@"960_2.png", @"960_3.png"]mutableCopy];
        }
        if (IS_IPHONE_5) {
            _imageArray = [@[@"1136_1.png",@"1136_2.png", @"1136_3.png"]mutableCopy];
        }
        if (IS_IPHONE_6) {
            _imageArray = [@[@"1334_1.png",@"1334_2.png", @"1334_3.png"]mutableCopy];
        }
        if (IS_IPHONE_6P) {
            _imageArray = [@[@"1080_1.png",@"1080_2.png", @"1080_3.png"]mutableCopy];
        }
        
        
        
//        _imageArray = [NSMutableArray arrayWithObjects:@"闪屏1.png",@"闪屏2.png", @"闪屏3.png",@"闪屏4.png", nil];
        
        UIScrollView *scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, MainScreen_width, MainScreen_height)];
        
        scrollView.contentSize = CGSizeMake((_imageArray.count + 1)*MainScreen_width, MainScreen_height);
        //设置翻页效果，不允许反弹，不显示水平滑动条，设置代理为自己
        scrollView.pagingEnabled = YES;//设置分页
        scrollView.bounces = NO;
        scrollView.showsHorizontalScrollIndicator = NO;
        scrollView.delegate = self;
        [self addSubview:scrollView];
        _bigScrollView = scrollView;
        
        for (int i = 0; i < _imageArray.count; i++) {
            UIImageView *imageView = [[UIImageView alloc]init];
            imageView.frame = CGRectMake(i * MainScreen_width, 0, MainScreen_width, MainScreen_height);
            UIImage *image = [UIImage imageNamed:_imageArray[i]];
            imageView.image = image;
            
            [scrollView addSubview:imageView];
        }
        
        UIPageControl *pageControl = [[UIPageControl alloc]initWithFrame:CGRectMake(MainScreen_width/2, MainScreen_height - 60, 0, 40)];
        pageControl.numberOfPages = _imageArray.count;
        pageControl.backgroundColor = [UIColor clearColor];
        [self addSubview:pageControl];
        
        _pageControl = pageControl;
        
        //添加手势
        UITapGestureRecognizer *singleRecognizer;
        singleRecognizer = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(handleSingleTapFrom)];
        singleRecognizer.numberOfTapsRequired = 1;
        [scrollView addGestureRecognizer:singleRecognizer];
        
    }
    
    return self;
}

-(void)handleSingleTapFrom
{
    if (_pageControl.currentPage == 2) {
        
        self.hidden = YES;
        
    }
}

-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    if (scrollView == _bigScrollView) {
        
        CGPoint offSet = scrollView.contentOffset;
        
        _pageControl.currentPage = offSet.x/(self.bounds.size.width);//计算当前的页码
        [scrollView setContentOffset:CGPointMake(self.bounds.size.width * (_pageControl.currentPage), scrollView.contentOffset.y) animated:YES];
        
    }
    
    if (scrollView.contentOffset.x == (_imageArray.count) *MainScreen_width) {
        
        self.hidden = YES;
        
    }
    
}

@end

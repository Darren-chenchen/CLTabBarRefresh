//
//  CLTabBarViewController.m
//  Relax
//
//  Created by Darren on 15/12/8.
//  Copyright © 2015年 darren. All rights reserved.
//

#import "CLTabBarViewController.h"
#import "CLTabBarVIew.h"
#import "CLHomeViewController.h"
#import "CLShoppingCarViewController.h"
#import "CLMineViewController.h"
@interface CLTabBarViewController ()<CLTabBarVIewDelegate>


@end

@implementation CLTabBarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupTabBar];
    
    CLHomeViewController *headPage = [[CLHomeViewController alloc] init];
    [self addChildViewController:headPage andTitle:@"首页" andImage:@"icon_home_d" andSelectedImage:@"tabBar_S0"];
    UINavigationController *navHead = [[UINavigationController alloc] initWithRootViewController:headPage];
    [self addChildViewController:navHead];
    
    CLShoppingCarViewController *categoryController = [[CLShoppingCarViewController alloc] init];
    [self addChildViewController:categoryController andTitle:@"购物车" andImage:@"icon_shopping_d" andSelectedImage:@"tabBar_S1"];
    UINavigationController *navcategory = [[UINavigationController alloc] initWithRootViewController:categoryController];
    [self addChildViewController:navcategory];
    
    CLMineViewController *lightning = [[CLMineViewController alloc] init];
    [self addChildViewController:lightning andTitle:@"我的" andImage:@"icon_PersonalCenter_d" andSelectedImage:@"tabBar_S2"];
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:lightning];
    [self addChildViewController:nav];
}

// 移除系统自带的tabbar
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
    for (UIView *child in self.tabBar.subviews) {
        if ([child isKindOfClass:[UIControl class]]) {
            [child removeFromSuperview];
        }
    }
}
- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}
// 自定义tabbar覆盖系统的tabbar
- (void)setupTabBar
{
    CLTabBarVIew *CLTabBar = [[CLTabBarVIew alloc] initWithFrame:self.tabBar.bounds];
    [self.tabBar addSubview:CLTabBar];
    self.CLTabBar = CLTabBar;
    CLTabBar.delegate = self;
}

// 初始化子控制器
- (void)addChildViewController:(UIViewController *)child andTitle:(NSString *)title andImage:(NSString *)image andSelectedImage:(NSString *)selectedImage
{
    child.tabBarItem.title = title;
    child.title = title;
    child.tabBarItem.image = [UIImage imageNamed:image];
    child.tabBarItem.selectedImage = [UIImage imageNamed:selectedImage];
//    child.tabBarItem.image = [[UIImage imageNamed:image] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
//    child.tabBarItem.selectedImage = [[UIImage imageNamed:selectedImage] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    [self.CLTabBar addCustomButtonWithitem:child.tabBarItem];
}

#pragma mark - 代理方法
- (void)tabbar:(CLTabBarVIew *)tabbar DidSeletedFrom:(NSInteger)from To:(NSInteger)to
{
    self.selectedIndex = to;
}

@end

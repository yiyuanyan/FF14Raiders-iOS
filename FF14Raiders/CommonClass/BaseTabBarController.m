//
//  BaseTabBarController.m
//  GoGoTalk
//
//  Created by XieHenry on 2017/4/26.
//  Copyright © 2017年 XieHenry. All rights reserved.
//

#import "BaseTabBarController.h"
//#import "CrusadeViewController.h"
#import "BaseNavigationController.h"
#import "DungeonViewController.h"
#import "ProductionController.h"
#import "OccupationController.h"
#import "AnnihilationController.h"
//#import "OccupationViewController.h"
//#import "ProductionViewController.h"
@interface BaseTabBarController ()

@end

@implementation BaseTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tabBarController.tabBar.delegate = self;
    UIView *view = [[UIView alloc] init];
    view.backgroundColor = UICOLOR_FROM_HEX(0x272627);
    view.frame = self.tabBar.bounds;
    [[UITabBar appearance] insertSubview:view atIndex:0];
    //self.tabBar.tintColor = UICOLOR_FROM_HEX(0x303030);
    //设置tabbar不透明
    self.tabBar.translucent = NO;
    //设置视图
    [self setupChildControllers];
    
}

- (void)setupChildControllers {
    [self setupChildNavigationControllerWithClass:[BaseNavigationController class] tabbarImageName:@"dungeon" rootViewControllerClass:[DungeonViewController class] tabbarTitle:@"副本攻略"];
    [self setupChildNavigationControllerWithClass:[BaseNavigationController class] tabbarImageName:@"taofa" rootViewControllerClass:[AnnihilationController class] tabbarTitle:@"讨伐&歼灭"];
    
    [self setupChildNavigationControllerWithClass:[BaseNavigationController class] tabbarImageName:@"zhiye" rootViewControllerClass:[OccupationController class] tabbarTitle:@"战斗职业"];
    [self setupChildNavigationControllerWithClass:[BaseNavigationController class] tabbarImageName:@"caiji" rootViewControllerClass:[ProductionController class] tabbarTitle:@"生产职业"];
    
    
}
/*
- (void) tabBarController:(UITabBarController *)tabBarController didSelectViewController:(UIViewController *)viewController
{
    UINavigationController *navigation = (UINavigationController *)viewController;
    CrusadeViewController *cv = (CrusadeViewController *)navigation.topViewController;
    [cv refreshData];
}
//禁止tab多次点击
- (BOOL)tabBarController:(UITabBarController *)tabBarController shouldSelectViewController:(UIViewController *)viewController
{
    UIViewController *tbselect = tabBarController.selectedViewController;
    if([tabBarController isEqual:viewController]){
        return NO;
    }
    return YES;
}*/

-(void)setupChildNavigationControllerWithClass:(Class)class tabbarImageName:(NSString *)name rootViewControllerClass:(Class)rootViewControllerClass tabbarTitle:(NSString *)title{
    UIViewController *rootVC = [[rootViewControllerClass alloc] init];
    UINavigationController *navVc = [[class  alloc] initWithRootViewController:rootVC];
    navVc.tabBarItem.title = title;
    navVc.tabBarItem.image = [[UIImage imageNamed:name] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    navVc.tabBarItem.selectedImage = [[UIImage imageNamed:[NSString stringWithFormat:@"%@", name]] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    navVc.tabBarItem.imageInsets = UIEdgeInsetsMake(-2, 0, 2, 0);
    
    //设置字体偏移量，防止字体偏下
    [navVc.tabBarItem setTitlePositionAdjustment:UIOffsetMake(-3, -3)];
    
    //设置tabbar的颜色以及字体大小
    NSMutableDictionary *normalAttrs = [NSMutableDictionary dictionary];
    normalAttrs[NSForegroundColorAttributeName] = UICOLOR_FROM_HEX(0x666666);
    normalAttrs[NSFontAttributeName] = [UIFont systemFontOfSize:12];
    NSMutableDictionary *selectedAttrs = [NSMutableDictionary dictionary];
    selectedAttrs[NSForegroundColorAttributeName] = UICOLOR_FROM_HEX(kThemeColor);
    UITabBarItem *item = [UITabBarItem appearance];
    [item setTitleTextAttributes:normalAttrs forState:UIControlStateNormal];
    [item setTitleTextAttributes:selectedAttrs forState:UIControlStateSelected];
    
    [self addChildViewController:navVc];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

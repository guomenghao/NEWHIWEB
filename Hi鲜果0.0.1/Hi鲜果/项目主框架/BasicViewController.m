//
//  BasicViewController.m
//  Hi鲜果
//
//  Created by 李波 on 15/6/25.
//  Copyright (c) 2015年 Hi fruit. All rights reserved.
//

#import "BasicViewController.h"

@interface BasicViewController ()
/**保存导航栏下默认的阴影图片，以便恢复样式*/
@property (nonatomic, strong) UIImage * navShadowImage;
/**重置导航栏和标签栏样式*/
- (void)resetBar;
@end

@implementation BasicViewController
- (instancetype)init
{
    self = [super init];
    if (self) {
        // 修改返回按钮
        UIBarButtonItem * backItem = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStylePlain target:nil action:nil];
        self.navigationItem.backBarButtonItem = backItem;
    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tabBarController.tabBar.tintColor = [UIColor orangeColor];
//    self.navShadowImage = self.navigationController.navigationBar.shadowImage;
//    if (self.controllerType == UIViewControllerHaveNavigation) {
//        self.view.frame = CGRectMake(0, 64, CGRectGetWidth([UIScreen mainScreen].bounds), CGRectGetHeight(Screen_bounds) - 110);
//    } else if (self.controllerType == UIViewControllerNotNavigation) {
//        self.view.frame = Screen_bounds;
//    } else if (self.controllerType == UIViewControllerNavigationTransluct) {
//        self.navigationController.tabBarController.tabBar.hidden = YES;
//        self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
//        self.navigationController.navigationBar.barStyle = UIBarStyleBlack;
//        [self.navigationController.navigationBar setBackgroundImage:ImageWithName(@"nav_clear_bk.png") forBarMetrics:UIBarMetricsDefault];
//        //去阴影
//        if ([self.navigationController.navigationBar respondsToSelector:@selector(shadowImage)])
//        {
//            [self.navigationController.navigationBar setShadowImage:[[UIImage alloc] init]];
//        }
//    }
}

- (void)initializeDataSource
{
    
}

- (void)initializeUserInterface
{
    
}

- (void)getNetWork:(NSString *)classId
{
    
}

- (void)resetBar {
    
    self.navigationController.navigationBar.shadowImage = self.navShadowImage;
    self.navigationController.navigationBar.hidden = NO;
    self.navigationController.navigationBar.barStyle = UIBarStyleDefault;
    // 修改导航栏颜色
    self.navigationController.navigationBar.barTintColor = [UIColor orangeColor];
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName : [UIColor whiteColor]}];
    [self.navigationController.navigationBar setBackgroundImage:nil forBarMetrics:UIBarMetricsDefault];
    self.navigationController.tabBarController.tabBar.hidden = NO;
}

- (void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
    if (self.controllerType != UIViewControllerNavigationTransluct) {
        [self resetBar];
        return;
    }
    
    self.navShadowImage = self.navigationController.navigationBar.shadowImage;
    if (self.controllerType == UIViewControllerHaveNavigation) {
        self.view.frame = CGRectMake(0, 64, CGRectGetWidth([UIScreen mainScreen].bounds), CGRectGetHeight(Screen_bounds) - 110);
    } else if (self.controllerType == UIViewControllerNotNavigation) {
        self.view.frame = Screen_bounds;
    } else if (self.controllerType == UIViewControllerNavigationTransluct) {
        self.navigationController.tabBarController.tabBar.hidden = YES;
        self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
        self.navigationController.navigationBar.barStyle = UIBarStyleBlack;
        [self.navigationController.navigationBar setBackgroundImage:ImageWithName(@"nav_clear_bk.png") forBarMetrics:UIBarMetricsDefault];
        //去阴影
        if ([self.navigationController.navigationBar respondsToSelector:@selector(shadowImage)])
        {
            [self.navigationController.navigationBar setShadowImage:[[UIImage alloc] init]];
        }
    }
}

@end

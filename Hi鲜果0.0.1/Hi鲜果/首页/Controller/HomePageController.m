//
//  HomePageController.m
//  Hi鲜果
//
//  Created by 李波 on 15/6/25.
//  Copyright (c) 2015年 Hi fruit. All rights reserved.
//

#import "HomePageController.h"
#import "SearchBox.h"
#import "ButtonView.h"
#import "HomePageTableView.h"
#import "MyGardenView.h"
@interface HomePageController ()



@end

@implementation HomePageController

- (instancetype)init
{
    self = [super init];
    if (self) {
        [Framework controllers].homePageVC = self;
        UITabBarItem *item = [[UITabBarItem alloc] initWithTitle:@"首页" image:ImageWithName(@"shouye.png") tag:0];
        [self setTabBarItem:item];
        self.controllerType = UIViewControllerHaveNavigation;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initializeDataSource];
    [self initializeUserInterface];
    [self login];
    
}

- (void)initializeUserInterface
{
    
    
    
    
    /**
     *  自动适应边距
     */
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    UIBarButtonItem *myGarden = [[UIBarButtonItem alloc] initWithImage:ImageWithName(@"user_button_normal.png") style:UIBarButtonItemStylePlain target:self action:@selector(myGardenPressed)];
    self.navigationItem.leftBarButtonItem = myGarden;
    
    UIBarButtonItem *service = [[UIBarButtonItem alloc] initWithImage:ImageWithName(@"kefu.png") style:UIBarButtonItemStylePlain target:self action:@selector(service)];
    self.navigationItem.rightBarButtonItem = service;
    
    /**
     *  搜索框
     */
    SearchBox *searchBox = [[SearchBox alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.view.bounds) * 0.66, 28)];
    searchBox.center = CGPointMake(CGRectGetWidth(self.view.bounds) / 2, 44);//修改mark：22->44
    self.navigationItem.titleView = searchBox;//修改mark
    
    /**
     *  主页tableView
     */
    HomePageTableView *tableView = [[HomePageTableView alloc] init];
    [self.view addSubview:tableView];
    
    
}

/**
 *点击我的果园事件
 */
- (void)myGardenPressed
{
    MyGardenView * gardenView = [[MyGardenView alloc] initWithFrame:Screen_bounds];
    [gardenView openGardenAnimation];
    self.view.userInteractionEnabled = NO;
    [self.navigationController setNavigationBarHidden:YES];
}

- (void)service
{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"温馨提示" message:@"功能开发中..." delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil];
    [alert show];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO];
    [self.tabBarController.tabBar setHidden:NO];
}

- (void)login
{
    if ([[NSUserDefaults standardUserDefaults] objectForKey:@"username"]) {
        [GlobalMethod NotHaveAlertServiceWithMothedName:Login_Url
                                               parmeter:@{@"username":[[NSUserDefaults standardUserDefaults] objectForKey:@"username"],
                                                          @"password":[[NSUserDefaults standardUserDefaults] objectForKey:@"password"]}
                                                success:^(id responseObject) {
                                                    if ([responseObject[@"err_msg"] isEqualToString:@"success"]) {
                                                        NSLog(@"===>登录成功：返回%@", responseObject);
                                                        [GlobalMethod getUserInfoSuccess:^(id responseObject) {
                                                        }];
                                                    }
                                                }
                                                   fail:^(NSError *error) {
                                                       NSLog(@"error：%@", [error localizedDescription]);
                                                   }];
    }
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

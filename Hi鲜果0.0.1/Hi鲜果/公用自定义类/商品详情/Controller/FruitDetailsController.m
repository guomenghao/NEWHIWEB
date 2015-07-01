//
//  FruitDetailsController.m
//  Hi鲜果
//
//  Created by 李波 on 15/6/25.
//  Copyright (c) 2015年 Hi fruit. All rights reserved.
//

#import "FruitDetailsController.h"
#import "ShopToolbar.h"
#import "FruitDetailsTableView.h"
#import "HoverButton.h"

@interface FruitDetailsController ()

@property (nonatomic, strong) ShopToolbar *toolbar;
@property (nonatomic, strong) FruitDetailsTableView *tableView;

@end

@implementation FruitDetailsController

- (void)dealloc
{
    NSLog(@"%s", __FUNCTION__);
}

- (FruitDetailsTableView *)tableView
{
    if (_tableView == nil) {
        _tableView = [[FruitDetailsTableView alloc] init];
    }
    return _tableView;
}

- (ShopToolbar *)toolbar
{
    if (_toolbar == nil) {
        _toolbar = [[ShopToolbar alloc] init];
    }
    return _toolbar;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.controllerType = UIViewControllerNotNavigation;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initializeUserInterface];
    
}

- (void)initializeUserInterface
{
    /**
     *  自动适应边距
     */
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    [self.view addSubview:self.tableView];
    
    
    
    /**
     *  悬浮按钮
     */
    HoverButton *hoverButton = [[HoverButton alloc] init];
    [hoverButton initializeUserInterfaceWithLike:YES controller:self];
    [self.view addSubview:hoverButton];
    
}

- (void)getNetWork:(NSDictionary *)classInfo
{
    [GlobalMethod serviceWithMothedName:GetNewsContent_Url parmeter:@{@"classid" : classInfo[@"classid"], @"id" : classInfo[@"id"]} success:^(id responseObject) {
        self.tableView.dataSourceDic = responseObject[@"data"][@"content"];
        [self.tableView reloadData];
    } fail:^(NSError *error) {
        
    }];
}


- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES];
    [self.tabBarController.tabBar setHidden:YES];
    [self.view addSubview:self.toolbar];
    
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [UIView animateWithDuration:0.25 animations:^{
        self.toolbar.center = CGPointMake(Screen_width / 2, Screen_height - 22);
    }];
}

- (void)backView:(UIButton *)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

@end

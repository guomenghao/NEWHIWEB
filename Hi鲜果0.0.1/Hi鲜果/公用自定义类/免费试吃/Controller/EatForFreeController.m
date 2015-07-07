//
//  EatForFreeController.m
//  Hi鲜果
//
//  Created by 李波 on 15/6/27.
//  Copyright (c) 2015年 Hi fruit. All rights reserved.
//

#import "EatForFreeController.h"
#import "DetailsScrollView.h"
#import "FruitNameAndPrice.h"
#import "EatRules.h"
#import "EatView.h"
#import "HoverButton.h"

@interface EatForFreeController ()

@property (nonatomic, strong) FruitNameAndPrice *fruitNameAndPrice;

@end

@implementation EatForFreeController

- (void)dealloc
{
    NSLog(@"%s", __FUNCTION__);
}

- (FruitNameAndPrice *)fruitNameAndPrice
{
    if (_fruitNameAndPrice == nil) {
        _fruitNameAndPrice = [[FruitNameAndPrice alloc] init];
    }
    return _fruitNameAndPrice;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.controllerType = UIViewControllerNotNavigation;
        self.view.backgroundColor = [UIColor whiteColor];
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
    
    DetailsScrollView *scrollView = [[DetailsScrollView alloc] initWithArray:@[@"1.png", @"2.png", @"3.png"]];
    [self.view addSubview:scrollView];
    
    
    /**
     *  水果信息
     */
    UIView *fruitInfo = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetHeight(scrollView.bounds), CGRectGetWidth(self.view.bounds), Screen_height * 0.15)];
    [self.fruitNameAndPrice getFruitInfo:nil];
    [fruitInfo addSubview:self.fruitNameAndPrice];
    
    /**
     *  自定义下划线
     */
    CustomSeparator *customSeparator = [[CustomSeparator alloc] initWithView:fruitInfo];
    [fruitInfo addSubview:customSeparator];
    [self.view addSubview:fruitInfo];
    
    
    /**
     *  试吃规则
     */
    EatRules *eatRules = [[EatRules alloc] initWithView:fruitInfo];
    [self.view addSubview:eatRules];
    CustomSeparator *customSepar = [[CustomSeparator alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(eatRules.frame) - 1, CGRectGetWidth(self.view.bounds), 1)];
    [self.view addSubview:customSepar];
    
    /**
     *  试吃申请按钮
     */
    EatView *eatView = [[EatView alloc] initWithView:eatRules];
    [self.view addSubview:eatView];
    
    /**
     *  悬浮按钮
     */
    HoverButton *hoverButton = [[HoverButton alloc] init];
    [hoverButton initializeUserInterfaceWithLike:NO controller:self data:nil];
    [self.view addSubview:hoverButton];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES];
    [self.tabBarController.tabBar setHidden:YES];
    
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

- (void)backView:(UIButton *)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

@end

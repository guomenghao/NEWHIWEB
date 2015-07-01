//
//  FruitDetailsController.m
//  Hi鲜果
//
//  Created by 李波 on 15/6/29.
//  Copyright (c) 2015年 Hi fruit. All rights reserved.
//

#import "CategoryDetailsController.h"
#import "CategoryDetailsTableView.h"
#import "CategoryModel.h"
#import "CategoryButton.h"

@interface CategoryDetailsController () {
    NSArray *_dataSource;
}

@property (nonatomic, strong) CategoryDetailsTableView *tableView;

@end

@implementation CategoryDetailsController

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.controllerType = UIViewControllerHaveNavigation;
        self.view.backgroundColor = [UIColor whiteColor];
        [Framework controllers].CategoryDetailsVC = self;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initializeDataSource];
    [self initializeUserInterface];
}

- (void)initializeDataSource
{
    
}

- (void)getNetWork:(NSString *)classId
{
    [GlobalMethod serviceWithMothedName:GetNewsList_Url parmeter:@{@"classid" : classId} success:^(id responseObject) {
        if ([responseObject[@"err_msg"] isEqual:@"success"]) {
            _dataSource = responseObject[@"data"][0];
            self.tableView.dataSourceArray = _dataSource;
            [self.tableView reloadData];
            NSLog(@"%@", _dataSource);
        }
    } fail:^(NSError *error) {
        
    }];
}

- (void)initializeUserInterface
{
    
    /**
     *  自动适应边距
     */
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    CategoryButton *hotSale = [CategoryButton buttonWithType:UIButtonTypeCustom];
    hotSale.frame = CGRectMake(CGRectGetWidth(self.view.bounds) / 2, 64 + Screen_height / 19 / 3.5, CGRectGetWidth(self.view.bounds) / 2 * 0.8, Screen_height / 19);
    [hotSale setTitle:@"热卖" forState:UIControlStateNormal];
    [hotSale setTitleColor:[UIColor orangeColor] forState:UIControlStateNormal];
    [hotSale setTag:121];
    [hotSale setType:@"1"];
    [hotSale addTarget:self action:@selector(buttonPressed:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:hotSale];
    
    [GlobalMethod rectWithView:hotSale corners1:UIRectCornerTopRight corners2:UIRectCornerBottomRight radius:8 lineWidth:2 lineColor:[UIColor orangeColor] fillColor:[UIColor whiteColor]];
    
    
    CategoryButton *newProduct = [CategoryButton buttonWithType:UIButtonTypeCustom];
    newProduct.frame = CGRectMake(CGRectGetWidth(self.view.bounds) / 2 - CGRectGetWidth(self.view.bounds) / 2 * 0.8, 64 + Screen_height / 19 / 3.5, CGRectGetWidth(self.view.bounds) / 2 * 0.8, Screen_height / 19);
    [newProduct setTitle:@"新品" forState:UIControlStateNormal];
    [newProduct setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [newProduct setTag:120];
    [newProduct addTarget:self action:@selector(buttonPressed:) forControlEvents:UIControlEventTouchUpInside];
    [newProduct setSelected:YES];
    [newProduct setType:@"0"];
    [self.view addSubview:newProduct];
    
    [GlobalMethod rectWithView:newProduct corners1:UIRectCornerTopLeft corners2:UIRectCornerBottomLeft radius:8 lineWidth:2 lineColor:[UIColor orangeColor] fillColor:[UIColor orangeColor]];
    
    self.tableView = [[CategoryDetailsTableView alloc] initWithView:newProduct];
    [self.view addSubview:self.tableView];
    
}

- (void)buttonPressed:(CategoryButton *)sender
{
    if (sender.selected) {
        return;
    }
    for (int i = 0; i < 2; i ++) {
        UIButton *button = (UIButton *)[self.view viewWithTag:120 + i];
        [button setTitleColor:[UIColor orangeColor] forState:UIControlStateNormal];
        [GlobalMethod view:button lineWidth:2 lineColor:[UIColor orangeColor] fillColor:[UIColor whiteColor]];
        [button setSelected:NO];
    }
    [sender setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [GlobalMethod view:sender lineWidth:2 lineColor:[UIColor orangeColor] fillColor:[UIColor orangeColor]];
    sender.selected = YES;
    [GlobalMethod serviceWithMothedName:GetNewsList_Url parmeter:@{@"classid" : self.classid} success:^(id responseObject) {
        if ([responseObject[@"err_msg"] isEqual:@"success"]) {
            _dataSource = responseObject[@"data"][0];
            self.tableView.dataSourceArray = _dataSource;
            [self.tableView reloadData];
        }
    } fail:^(NSError *error) {
        
    }];
    NSLog(@"%@", sender.type);
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO];
    [self.tabBarController.tabBar setHidden:NO];
    
}

@end

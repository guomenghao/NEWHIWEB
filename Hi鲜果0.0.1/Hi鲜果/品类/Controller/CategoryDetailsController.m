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

@interface CategoryDetailsController () {
    NSArray *_dataSource;
}

@property (nonatomic, strong) CategoryDetailsTableView *tableView;

@property (nonatomic, strong) CategoryModel *model;

@end

@implementation CategoryDetailsController

- (CategoryModel *)model
{
    if (_model == nil) {
        _model = [[CategoryModel alloc] init];
    }
    return _model;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.title = @"九转金丹";
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
    
    UIButton *hotSale = [UIButton buttonWithType:UIButtonTypeCustom];
    hotSale.frame = CGRectMake(CGRectGetWidth(self.view.bounds) / 2, 64 + Screen_height / 19 / 3.5, CGRectGetWidth(self.view.bounds) / 2 * 0.8, Screen_height / 19);
    hotSale.backgroundColor = [UIColor orangeColor];
    [hotSale setTitle:@"万年" forState:UIControlStateNormal];
    [self.view addSubview:hotSale];
    
    UIButton *newProduct = [UIButton buttonWithType:UIButtonTypeCustom];
    newProduct.frame = CGRectMake(CGRectGetWidth(self.view.bounds) / 2 - CGRectGetWidth(self.view.bounds) / 2 * 0.8, 64 + Screen_height / 19 / 3.5, CGRectGetWidth(self.view.bounds) / 2 * 0.8, Screen_height / 19);
    newProduct.backgroundColor = [UIColor colorWithRed:0.502 green:0.502 blue:0.000 alpha:1.000];
    [newProduct setTitle:@"千年" forState:UIControlStateNormal];
    [self.view addSubview:newProduct];
    
    self.tableView = [[CategoryDetailsTableView alloc] initWithView:newProduct];
    [self.view addSubview:self.tableView];
    
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO];
    [self.tabBarController.tabBar setHidden:NO];
    
}

@end

//
//  OrderDetailController.m
//  Hi鲜果
//
//  Created by rimi on 15/7/9.
//  Copyright (c) 2015年 Hi fruit. All rights reserved.
//

#import "OrderDetailController.h"

@interface OrderDetailController ()
@property (strong, nonatomic) UITableView * tableView;
@property (strong, nonatomic) NSMutableArray * dataSource;
@end

@implementation OrderDetailController

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.title = @"订单详情";
    }
    return self;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.navigationController.tabBarController.tabBar.hidden = YES;
}

- (void)viewDidLoad {
    [super viewDidLoad];

}

@end

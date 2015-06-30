//
//  CategoryController.m
//  Hi鲜果
//
//  Created by 李波 on 15/6/25.
//  Copyright (c) 2015年 Hi fruit. All rights reserved.
//

#import "CategoryController.h"
#import "FruitCategoryTableView.h"
#import "FruitDetailsController.h"

@interface CategoryController ()

@end

@implementation CategoryController

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.title = @"品类";
        self.controllerType = UIViewControllerHaveNavigation;
        [Framework controllers].categoryVC = self;
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
    /**
     *  自动适应边距
     */
    self.automaticallyAdjustsScrollViewInsets = NO;
    FruitCategoryTableView *tableView = [[FruitCategoryTableView alloc] init];
    [self.view addSubview:tableView];
}

- (void)initializeUserInterface
{
    
}





@end

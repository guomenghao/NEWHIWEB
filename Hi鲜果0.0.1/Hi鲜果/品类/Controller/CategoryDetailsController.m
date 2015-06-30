//
//  FruitDetailsController.m
//  Hi鲜果
//
//  Created by 李波 on 15/6/29.
//  Copyright (c) 2015年 Hi fruit. All rights reserved.
//

#import "CategoryDetailsController.h"
#import "Framework.h"

@interface CategoryDetailsController ()

@end

@implementation CategoryDetailsController

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.title = @"九转金丹";
        self.controllerType = UIViewControllerHaveNavigation;
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

- (void)initializeUserInterface
{
    /**
     *  自动适应边距
     */
    self.automaticallyAdjustsScrollViewInsets = NO;
}

@end

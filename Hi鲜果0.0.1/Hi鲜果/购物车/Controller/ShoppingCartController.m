//
//  ShoppingCartController.m
//  Hi鲜果
//
//  Created by 李波 on 15/6/25.
//  Copyright (c) 2015年 Hi fruit. All rights reserved.
//

#import "ShoppingCartController.h"
#import "CartTableView.h"
#import "Fruit.h"
@interface ShoppingCartController () <UITableViewDelegate>

@property (strong, nonatomic) CartTableView * tableView;
@property (strong, nonatomic) NSArray * dataSource;

@end

@implementation ShoppingCartController

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.title = @"购物车";
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initializeDataSource];
    [self initializeUserInterface];
    
}

- (void)initializeDataSource {
    
    // 模拟网络请求
    self.dataSource = @[
                       @{@"id":@"111",
                         @"pic":@"",
                         @"name":@"Apple",
                         @"unit":@"4斤装",
                         @"originalPrice":@"100",
                         @"discountPrice":@"99"},
                       @{@"id":@"222",
                         @"pic":@"",
                         @"name":@"梨子",
                         @"unit":@"4个装",
                         @"originalPrice":@"110",
                         @"discountPrice":@"88"},
                       @{@"id":@"333",
                         @"pic":@"",
                         @"name":@"樱桃",
                         @"unit":@"1斤装",
                         @"originalPrice":@"1110",
                         @"discountPrice":@"77"}];
    // 封装数据模型
    for (int i = 0; i < 3; i ++) {
        NSDictionary * info = self.dataSource[i];
        Fruit * fruit = [[Fruit alloc] initWithInfo:info];
        [self.tableView.goods addObject:fruit];
    }
    [_tableView reloadData];
}

- (void)initializeUserInterface {
    
    self.automaticallyAdjustsScrollViewInsets = NO;
}

- (CartTableView *)tableView {
    
    if (_tableView == nil) {
        _tableView = [[CartTableView alloc] initWithFrame:CGRectMake(0, 64, Screen_width, Screen_height - 110) style:UITableViewStylePlain];
        _tableView.delegate = self;
        [self.view addSubview:_tableView];
    }
    return _tableView;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return 150 * [FlexibleFrame ratios].height;
}

- (void)dealloc {
    
    NSLog(@"%s", __FUNCTION__);
}
@end

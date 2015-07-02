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
#import "CartCell.h"
@interface ShoppingCartController () <UITableViewDelegate>

@property (strong, nonatomic) CartTableView * tableView;
@property (strong, nonatomic) NSMutableArray * dataSource;

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
    [self initializeUserInterface];
}

- (void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
    [GlobalMethod serviceWithMothedName:GetCar_Url parmeter:nil success:^(id responseObject) {
        if (![responseObject[@"data"] isKindOfClass:[NSNull class]]) {
            // 注意返回的总价和个数是NSNumber
            self.dataSource = [[NSMutableArray alloc] initWithArray:responseObject[@"data"]];
            NSLog(@"购物车信息：%@", self.dataSource);
            [self reloadDataSource];
        } else {
            NSLog(@"购物车内没有任何商品哦");
        }
        
    } fail:^(NSError *error) {
        
    }];
}

- (void)reloadDataSource {
    // 封装数据模型
    [self.tableView.goods removeAllObjects];//清空数据
    for (int i = 0; i < self.dataSource.count; i ++) {
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

    if (self.dataSource.count == 0) {
        return 0;
    } else {
        NSDictionary * info = self.dataSource[indexPath.row];
        NSString * title = info[@"title"];
        CGSize size = [GlobalMethod sizeWithString:title font:MiddleFont maxWidth:220 *[FlexibleFrame ratios].width maxHeight:40 * [FlexibleFrame ratios].height];
        CGFloat height = (size.height + 20 + 40 * [FlexibleFrame ratios].height) > 100 * [FlexibleFrame ratios].height ? (size.height + 20 * 3) : 100 * [FlexibleFrame ratios].height;
        return height;
    }
}

- (void)viewWillDisappear:(BOOL)animated {
    
    [super viewWillDisappear:animated];
    self.dataSource = nil;
}

- (void)dealloc {
    
    NSLog(@"%s", __FUNCTION__);
}

@end

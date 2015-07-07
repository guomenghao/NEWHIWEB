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
#import "NoDataView.h"
#import "AutoDismissBox.h"
@interface ShoppingCartController () <UITableViewDelegate, UIAlertViewDelegate>

@property (strong, nonatomic) CartTableView * tableView;
@property (strong, nonatomic) NSMutableArray * dataSource;
@property (strong, nonatomic) NoDataView * noDataView;
- (void)showCustomToolBar;
- (void)showNoDataView;
@end

@implementation ShoppingCartController

- (instancetype)init
{
    self = [super init];
    if (self) {
        UITabBarItem *item = [[UITabBarItem alloc] initWithTitle:@"购物车" image:ImageWithName(@"gouwu.png") tag:2];
        [self setTabBarItem:item];
        self.title = @"购物车";
        self.automaticallyAdjustsScrollViewInsets = NO;
        [Framework controllers].shoppingCartVC = self;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    UIBarButtonItem * clearCarItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemTrash target:self action:@selector(clearCarItemPressed:)];
    self.navigationItem.rightBarButtonItem = clearCarItem;
}

- (void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
    
    [GlobalMethod serviceWithMothedName:GetCar_Url parmeter:nil success:^(id responseObject) {
        if (![responseObject[@"data"] isKindOfClass:[NSNull class]]) {
            // 注意返回的总价和个数是NSNumber
            self.dataSource = [[NSMutableArray alloc] initWithArray:responseObject[@"data"]];
            NSLog(@"购物车信息：%@", self.dataSource);
            NSLog(@"购物车总价为:%@", responseObject[@"totalmoney"]);
            self.toolBar.totalPrice = [responseObject[@"totalmoney"] integerValue];
            [self reloadDataSource];
            [self showCustomToolBar];
        } else {
            [self showNoDataView];
        }
    } fail:^(NSError *error) {}];
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

- (TotalPriceToolBar *)toolBar {
    
    if (_toolBar == nil) {
        _toolBar = [[TotalPriceToolBar alloc] initWithFrame:CGRectMake(0, Screen_height - 48, Screen_width, 48) submitTitle:@"立即结算"];
    }
    return _toolBar;
}

- (CartTableView *)tableView {
    
    if (_tableView == nil) {
        _tableView = [[CartTableView alloc] initWithFrame:CGRectMake(0, 64, Screen_width, Screen_height - 110) style:UITableViewStylePlain];
        _tableView.delegate = self;
        [self.view addSubview:_tableView];
    }
    return _tableView;
}

- (NoDataView *)noDataView {
    
    if (_noDataView == nil) {
        _noDataView = [[NoDataView alloc] initWithFrame:self.view.bounds];
    }
    return _noDataView;
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
    self.toolBar.transform = CGAffineTransformIdentity;
    [self.noDataView removeFromSuperview];
    [self.toolBar removeFromSuperview];
}

- (void)showCustomToolBar {
    
    [self.view addSubview:self.toolBar];
    [UIView animateWithDuration:0.25 animations:^{
        self.toolBar.transform = CGAffineTransformMakeTranslation(0, -self.toolBar.bounds.size.height);
    }];
}

- (void)showNoDataView {

    [self.dataSource removeAllObjects];
    [self.tableView reloadData];
    [self.tableView removeFromSuperview];
    [self.view addSubview:self.noDataView];
}

- (void)dealloc {
    
    NSLog(@"%s", __FUNCTION__);
}
#pragma mark - 清空购物车
- (void)clearCarItemPressed:(UIBarButtonItem *)sender {
    
    UIAlertView * alert = [[UIAlertView alloc] initWithTitle:@"温馨提示" message:@"是否清空购物车" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"清空", nil];
    [alert show];
}

#pragma mark - <UIAlertViewDelegate> 
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    
    if (buttonIndex == 1) {//确定清空购物车
        NSLog(@"发送请求，清空购物车");
        [GlobalMethod serviceWithMothedName:ClearCar_Url parmeter:nil success:^(id responseObject) {
            [AutoDismissBox showBoxWithTitle:@"提示" message:@"购物车已清空"];
            [self showNoDataView];
        } fail:^(NSError *error) {
            
        }];
    }
}


@end

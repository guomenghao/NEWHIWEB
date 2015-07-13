//
//  OrderDetailController.m
//  Hi鲜果
//
//  Created by rimi on 15/7/9.
//  Copyright (c) 2015年 Hi fruit. All rights reserved.
//

#import "OrderDetailController.h"
#import "OrderDetailModel.h"
#import "CartCell.h"
@interface OrderDetailController () <UITableViewDataSource, UITableViewDelegate>
@property (strong, nonatomic) UITableView * tableView;
@property (strong, nonatomic) NSMutableArray * dataSource;
@property (strong, nonatomic) NSString * orderID;
@property (strong, nonatomic) NSString * status;
@property (strong, nonatomic) OrderDetailModel * model;
@end

@implementation OrderDetailController
- (instancetype)initWithOrderID:(NSString *)orderID {
    self = [super init];
    if (self) {
        self.title = @"订单详情";
        self.orderID = orderID;
    }
    return self;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.navigationController.tabBarController.tabBar.hidden = YES;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initializeDataSource];
    [self initializeUserInterface];
}

- (void)initializeDataSource {
    
    // 数据模型
    self.model = [[OrderDetailModel alloc] initWithOrderID:self.orderID];
    // 注册监听
    [self.model addObserver:self forKeyPath:@"info" options:NSKeyValueObservingOptionNew context:nil];
}

- (void)initializeUserInterface {
    
}

- (UITableView *)tableView {
    if (_tableView == nil) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, Screen_width, Screen_height - 64) style:UITableViewStyleGrouped];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        [self.view addSubview:_tableView];
    }
    return _tableView;
}

#pragma mark - <UITableViewDataSource/UITableViewDelegate>

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return self.dataSource.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return ((NSArray *)self.dataSource[section]).count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.section == 1) {
        NSDictionary * info = self.dataSource[indexPath.section][indexPath.row];
        NSString * title = info[@"title"];
        CGSize size = [GlobalMethod sizeWithString:title font:MiddleFont maxWidth:220 *[FlexibleFrame ratios].width maxHeight:40 * [FlexibleFrame ratios].height];
        CGFloat height = (size.height + 20 + 40 * [FlexibleFrame ratios].height) > 100 * [FlexibleFrame ratios].height ? (size.height + 20 * 3) : 100 * [FlexibleFrame ratios].height;
        return height;
    }
    
    if (indexPath.section == 0 && indexPath.row == 2) {//收货地址
        NSString * detail = self.dataSource[indexPath.section][indexPath.row][@"detail"];
        CGSize size = [GlobalMethod sizeWithString:detail font:MiddleFont maxWidth:215 *[FlexibleFrame ratios].width maxHeight:60 * [FlexibleFrame ratios].height];
        return size.height + 20 * [FlexibleFrame ratios].height;
    }
    return 44;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        static NSString * ID = @"ordinaryCell";
        UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:ID];
        if (!cell) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:ID];
        }
        NSDictionary * info = self.dataSource[indexPath.section][indexPath.row];
        cell.textLabel.text = info[@"title"];
        cell.detailTextLabel.text = info[@"detail"];
        cell.detailTextLabel.numberOfLines = 0;
        cell.detailTextLabel.font = MiddleFont;
        return cell;
    }
    static NSString * cartID = @"cartCell";
    CartCell * cell = [tableView dequeueReusableCellWithIdentifier:cartID];
    if (!cell) {
        cell = [[CartCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cartID];
    }
    cell.type = CartCellTypeSubmit;
    NSDictionary * info = self.dataSource[indexPath.section][indexPath.row];
    Fruit * fruit = [[Fruit alloc] initWithInfo:info];
    cell.fruit = fruit;
    return cell;
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.section == 0 && indexPath.row == 2) {
        UITableViewCell * cell = [tableView cellForRowAtIndexPath:indexPath];
        cell.textLabel.center = CGPointMake(cell.textLabel.center.x, cell.detailTextLabel.center.y);
    }
}

#pragma mark - 处理监听
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context {
    
    if ([keyPath isEqualToString:@"info"]) {
        NSDictionary * info = [change valueForKey:NSKeyValueChangeNewKey];
        NSLog(@"订单信息更新：new info = %@", info);
        
        self.dataSource = [@[
                              @[//section = 0
                                  @{
                                      @"title":@"订单编号",
                                      @"detail":self.orderID
                                      },
                                  @{
                                      @"title":@"订单状态",
                                      @"detail":info[@"haveConfrom"]
                                      },
                                  @{
                                      @"title":@"收货地址",
                                      @"detail":info[@"address"]
                                      },
                                  @{
                                      @"title":@"配送时间",
                                      @"detail":info[@"besttime"]
                                      }
                               ],
                             info[@"buycar"] //section = 1
                             ] mutableCopy];
        [self.tableView reloadData];
    } else {
        [super observeValueForKeyPath:keyPath ofObject:object change:change context:context];
    }
}

- (void)dealloc {
    // 移除监听
    [self.model removeObserver:self forKeyPath:@"info" context:nil];
}






















@end

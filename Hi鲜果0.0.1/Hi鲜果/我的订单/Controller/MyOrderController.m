//
//  MyOrderController.m
//  Hi鲜果
//
//  Created by 李波 on 15/7/2.
//  Copyright (c) 2015年 Hi fruit. All rights reserved.
//

#import "MyOrderController.h"
#import "MyOrderCustomCell.h"

@interface MyOrderController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) UISegmentedControl *segmentedControl;
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSArray * allDatas;//所有订单
@property (nonatomic, strong) NSMutableArray *dataSource;//用于显示在表视图上的订单

@end

@implementation MyOrderController

- (UISegmentedControl *)segmentedControl
{
    if (_segmentedControl == nil) {
        _segmentedControl = [[UISegmentedControl alloc] initWithItems:@[@"全部订单", @"已收货", @"待收货"]];
        _segmentedControl.frame = CGRectMake(Screen_width / 37.5, 64 + Screen_width / 37.5, Screen_width - Screen_width / 37.5 / 0.5, Screen_height / 19);
        [_segmentedControl addTarget:self action:@selector(segmentedControlValueChanged:) forControlEvents:UIControlEventValueChanged];
        _segmentedControl.selectedSegmentIndex = 0;
        _segmentedControl.tintColor = [UIColor orangeColor];
    }
    return _segmentedControl;
}

- (UITableView *)tableView
{
    if (_tableView == nil) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, Screen_width / 37.5 + CGRectGetMaxY(self.segmentedControl.frame), Screen_width, Screen_height - 44 - Screen_width / 37.5 - CGRectGetMaxY(self.segmentedControl.frame))];
        _tableView.delegate = self;
        _tableView.showsVerticalScrollIndicator = NO;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.dataSource = self;
    }
    return _tableView;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.title = @"我的订单";
        self.view.backgroundColor = [UIColor whiteColor];
        self.controllerType = UIViewControllerHaveNavigation;
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
    self.dataSource = nil;
    [GlobalMethod serviceWithMothedName:GetOrderList_Url parmeter:nil success:^(id responseObject) {
    
        if (![responseObject isKindOfClass:[NSNull class]]) {
            self.allDatas = responseObject;
            //第一次展示所有订单
            self.dataSource = [self.allDatas mutableCopy];
            [self.tableView reloadData];
        }

    } fail:^(NSError *error) {}];
}

- (void)initializeUserInterface
{
    /**
     *  自动适应边距
     */
    self.automaticallyAdjustsScrollViewInsets = NO;
    [self.view addSubview:self.segmentedControl];
    [self.view addSubview:self.tableView];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (self.dataSource != nil) {
        return self.dataSource.count;
    }
    return 0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return Screen_height / 4.5;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *identifier = @"Cell";
    MyOrderCustomCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[MyOrderCustomCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:identifier];
    }
    [GlobalMethod removeAllSubViews:cell.contentView];
    if (self.dataSource != nil) {
        [cell getOrderCellData:self.dataSource[indexPath.row]];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

#pragma mark - segmentedControlValueChanged event
- (void)segmentedControlValueChanged:(UISegmentedControl *)sender {
    
    [self.dataSource removeAllObjects];
    switch (sender.selectedSegmentIndex) {
        case 0://全部
            [self.dataSource addObjectsFromArray:self.allDatas];
            break;
        case 1://已收货
        {
            for (NSDictionary * orderInfo in self.allDatas) {
                if ([orderInfo[@"haveprice"] integerValue] == 1) {//订单状态
                    [self.dataSource addObject:orderInfo];
                }
            }
        }
            break;
        case 2://待收货
        {
            for (NSDictionary * orderInfo in self.allDatas) {
                if ([orderInfo[@"haveprice"] integerValue] == 0) {//订单状态
                    [self.dataSource addObject:orderInfo];
                }
            }
        }
            break;
        default:
            break;
    }
    [self.tableView reloadData];
}

@end

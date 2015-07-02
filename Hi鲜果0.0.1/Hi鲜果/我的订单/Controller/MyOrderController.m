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
@property (nonatomic, strong) NSMutableArray *dataSource;

@end

@implementation MyOrderController

- (UISegmentedControl *)segmentedControl
{
    if (_segmentedControl == nil) {
        _segmentedControl = [[UISegmentedControl alloc] initWithItems:@[@"全部订单", @"待支付", @"待收货"]];
        _segmentedControl.frame = CGRectMake(Screen_width / 37.5, 64 + Screen_width / 37.5, Screen_width - Screen_width / 37.5 / 0.5, Screen_height / 19);
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
    return 6;
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
    [cell getOrderCellData:nil];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

@end

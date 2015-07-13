//
//  MyOrderController.m
//  Hi鲜果
//
//  Created by 李波 on 15/7/2.
//  Copyright (c) 2015年 Hi fruit. All rights reserved.
//

#import "MyOrderController.h"
#import "MyOrderCustomCell.h"
#import "OrderDetailController.h"
#import "AutoDismissBox.h"
#import "OrderItem.h"
@interface MyOrderController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) UISegmentedControl *segmentedControl;
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray * allDatas;//所有订单
@property (nonatomic, strong) NSMutableArray *dataSource;//用于显示在表视图上的订单
@property (nonatomic, assign) NSInteger delCount;//记录选中要删除的cell个数
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
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, Screen_width / 37.5 + CGRectGetMaxY(self.segmentedControl.frame), Screen_width, Screen_height - Screen_width / 37.5 - CGRectGetMaxY(self.segmentedControl.frame))];
        _tableView.delegate = self;
        _tableView.showsVerticalScrollIndicator = NO;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.dataSource = self;
        [self.view addSubview:_tableView];
    }
    return _tableView;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.title = @"我的订单";
        self.view.backgroundColor = [UIColor whiteColor];
        [Framework controllers].myOrderVC = self;
        self.controllerType = UIViewControllerHaveNavigation;
        // 添加“编辑”按钮
        UIBarButtonItem * editItem = [[UIBarButtonItem alloc] initWithTitle:@"编辑" style:UIBarButtonItemStylePlain target:self action:@selector(editItemPressed:)];
        self.navigationItem.rightBarButtonItem = editItem;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initializeDataSource];
    [self initializeUserInterface];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.tabBarController.tabBar setHidden:YES];
}

- (void)initializeDataSource
{
    self.dataSource = nil;
    self.allDatas = [[NSMutableArray alloc] init];
    self.delCount = 0;
    [GlobalMethod serviceWithMothedName:GetOrderList_Url parmeter:nil success:^(id responseObject) {

        if ([responseObject isKindOfClass:[NSArray class]]) {
            [self packageDataWithArray:responseObject];
        }

    } fail:^(NSError *error) {}];
}

- (void)packageDataWithArray:(NSArray *)temp{
    // 封装数据
    for (int i = 0; i < temp.count; i ++) {
        OrderItem * item = [[OrderItem alloc] initWithInfo:temp[i]];
        [self.allDatas addObject:item];
    }
    //第一次展示所有订单
    self.dataSource = [self.allDatas mutableCopy];
    [self.tableView reloadData];
}

- (void)initializeUserInterface
{
    /**
     *  自动适应边距
     */
    self.automaticallyAdjustsScrollViewInsets = NO;
    [self.view addSubview:self.segmentedControl];
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
    cell.row = indexPath.row;
    [GlobalMethod removeAllSubViews:cell.contentView];
    if (self.dataSource != nil) {
        OrderItem * item = self.dataSource[indexPath.row];
        [cell getOrderCellData:item];
        [cell setChecked:item.isChecked];
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
            self.navigationItem.rightBarButtonItem.enabled = YES;
            break;
        case 1://已收货
        {
            [self.dataSource addObjectsFromArray:[self filterOrderWithStatus:YES]];
            self.navigationItem.rightBarButtonItem.enabled = YES;
        }
            break;
        case 2://待收货
        {
            // 禁用编辑按钮
            self.navigationItem.rightBarButtonItem.enabled = NO;
            [self.dataSource addObjectsFromArray:[self filterOrderWithStatus:NO]];
        }
            break;
        default:
            break;
    }
    [self.tableView reloadData];
}

- (NSArray *)filterOrderWithStatus:(BOOL)isConfirm {
    
    NSMutableArray * array = [[NSMutableArray alloc] init];
    for (OrderItem * item in self.allDatas) {
        if ([item.havePrice boolValue] == isConfirm) {//订单状态
            [array addObject:item];
        }
    }
    return array;
}

#pragma mark - 处理cell中确认收货
- (void)cellAtIndex:(NSInteger)index confirmOrder:(NSString *)orderID {
    
    [GlobalMethod NotHaveAlertServiceWithMothedName:ConfirmOrder_Url parmeter:@{@"ddno":orderID} success:^(id responseObject) {
        [AutoDismissBox showBoxWithTitle:@"温馨提示" message:@"确认收货成功"];
        [self refreshCellAtIndex:index confirmOrder:orderID];
    } fail:^(NSError *error) {}];
}

- (void)refreshCellAtIndex:(NSInteger)index confirmOrder:(NSString *)orderID {
    // 修改数据源
    OrderItem * confirmItem;
    for (OrderItem * item in self.allDatas) {
        if ([item.ddno isEqualToString:orderID]) {//订单状态
            confirmItem = item;
            break;
        }
    }
    confirmItem.havePrice = @"1";
    [self.allDatas replaceObjectAtIndex:index withObject:confirmItem];
    // 刷新tableView
    [self segmentedControlValueChanged:self.segmentedControl];
}

#pragma mark - edit item pressed
- (void)editItemPressed:(UIBarButtonItem *)sender {
    
    if ([sender.title isEqualToString:@"删除"]) {//如果是删除按钮
        [self deleteTableViewCell];
    }
    BOOL isEditing = !self.tableView.isEditing;
    sender.title = isEditing ? @"完成" : @"编辑";
    [self.tableView setEditing:isEditing animated:YES];
}

#pragma mark - 删除cell，网络请求
- (void)deleteTableViewCell {

    UIAlertView * alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"正在删除...请稍后" delegate:nil cancelButtonTitle:nil otherButtonTitles:nil];
    [alert show];
    NSInteger count = 0;
    for (__block int i = 0; i < self.dataSource.count; i ++) {
        OrderItem * item = self.dataSource[i];
        if (item.isChecked == YES) {
            count ++;
            NSLog(@"%@", item.ddno);
            [GlobalMethod NotHaveAlertServiceWithMothedName:DelOrder_Url parmeter:@{@"ddno":item.ddno} success:^(id responseObject) {
                NSLog(@"%@", responseObject);
                [self.dataSource removeObject:item];
                i --;
                if ([responseObject[@"err_msg"] isEqual:@"success"] && count == self.delCount) {
                    [alert dismissWithClickedButtonIndex:0 animated:YES];
                    [self.tableView reloadData];
                }
            } fail:^(NSError *error) {}];
        }
    }
}

// 是否可编辑
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    
    OrderItem * item = self.dataSource[indexPath.row];
    if ([item.havePrice integerValue] == 0) {//待收货不能删除
        return NO;
    }
    return YES;
}
// 选中cell
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    OrderItem * item = [self.dataSource objectAtIndex:indexPath.row];
    
    if (tableView.editing)//编辑状态
    {
        MyOrderCustomCell * cell = (MyOrderCustomCell *)[tableView cellForRowAtIndexPath:indexPath];
        item.isChecked = !item.isChecked;
        // 根据选中的cell个数，显示导航栏编辑按钮的标题
        if (item.isChecked == YES) {
            self.delCount ++;
        } else {
            self.delCount --;
        }
        [self.navigationItem.rightBarButtonItem setTitle:(self.delCount > 0 ? @"删除" : @"完成")];
        [cell setChecked:item.isChecked];
        [cell setSelected:!cell.selected animated:YES];
        [cell setEditing:tableView.editing animated:YES];
    } else {//非编辑状态
        OrderDetailController * detailVC = [[OrderDetailController alloc] initWithOrderID:item.ddno];
        [self.navigationController pushViewController:detailVC animated:YES];
    }
}

// 编辑样式
- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return UITableViewCellEditingStyleDelete|UITableViewCellEditingStyleInsert;//左侧小圆圈
}

@end

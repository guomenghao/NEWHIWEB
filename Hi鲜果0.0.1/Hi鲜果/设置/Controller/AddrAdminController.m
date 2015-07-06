//
//  AddrAdminController.m
//  Hi鲜果
//
//  Created by 李波 on 15/7/3.
//  Copyright (c) 2015年 Hi fruit. All rights reserved.
//

#import "AddrAdminController.h"
#import "AddrAdminCell.h"
#import "AddrInfoController.h"


@interface AddrAdminController ()<UITableViewDelegate,UITableViewDataSource>

@end

@implementation AddrAdminController

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.view.backgroundColor = [UIColor whiteColor];
        self.title = @"地址管理";
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
    [Framework controllers].addrAdminVC = self;
    if ([[User loginUser].userAddressList isEqual:[NSNull null]]) {
        self.dataSource = [NSMutableArray array];
    } else {
        self.dataSource = [[User loginUser].userAddressList mutableCopy];
    }
    [User loginUser].tempAddrs = self.dataSource;
}

- (void)initializeUserInterface
{
    
    UIBarButtonItem *addAddr = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(addAddrs)];
    self.navigationItem.rightBarButtonItem = addAddr;
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, Screen_width, Screen_height - 64) style:UITableViewStylePlain];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.showsVerticalScrollIndicator = NO;
    self.tableView.tableFooterView = [[UIView alloc] init];
    [self.view addSubview:self.tableView];
}

#pragma mark - <UITableViewDataSource/UITabelViewDelegate>

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return [self.dataSource count];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{ 
    return Screen_height / 4.5;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString * identifier = @"Cell";
    AddrAdminCell * cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[AddrAdminCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:identifier];
    }
    
    [GlobalMethod removeAllSubViews:cell.contentView];
    [cell getAddrCellData:self.dataSource[indexPath.row]];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    return cell;
}


/**
 *  cell点击效果
 */
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    AddrInfoController *addrInfo = [[AddrInfoController alloc] initWithData:self.dataSource[indexPath.row] isAmend:YES index:(int)indexPath.row];
    [self.navigationController pushViewController:addrInfo animated:YES];
}


- (void)addAddrs
{
    AddrInfoController *addrInfo = [[AddrInfoController alloc] initWithData:nil isAmend:NO index:(int)nil];
    [self.navigationController pushViewController:addrInfo animated:YES];
}

- (void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
    self.navigationController.tabBarController.tabBar.hidden = YES;
}


@end

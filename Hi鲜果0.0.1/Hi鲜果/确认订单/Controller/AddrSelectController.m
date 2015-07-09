//
//  AddrSelectController.m
//  Hi鲜果
//
//  Created by rimi on 15/7/7.
//  Copyright (c) 2015年 Hi fruit. All rights reserved.
//

#import "AddrSelectController.h"
#import "AddrSelectCell.h"
@interface AddrSelectController () <UITableViewDelegate, UITableViewDataSource>

@property (strong, nonatomic) UITableView * tableView;

@end

@implementation AddrSelectController

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.title = @"地址选择";
        [Framework controllers].addrSelectVC = self;
    }
    return self;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    if (self.tableView != nil) {
        [self.tableView reloadData];
    }
    self.navigationController.tabBarController.tabBar.hidden = YES;
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    self.navigationController.tabBarController.tabBar.hidden = NO;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initializeUserInterface];
}

- (void)initializeUserInterface {
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    [self.view addSubview:self.tableView];
    // 右上角“管理”按钮
    UIBarButtonItem * item = [[UIBarButtonItem alloc] initWithTitle:@"编辑" style:UIBarButtonItemStylePlain target:self action:@selector(editItemPressed:)];
    self.navigationItem.rightBarButtonItem = item;
}

- (UITableView *)tableView {
    if (_tableView == nil) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, Screen_width, Screen_height - 64) style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.tableFooterView = [[UIView alloc] init];
    }
    return _tableView;
}

#pragma mark - <UITableViewDelegate/UITableViewDataSource>
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    if (![[User loginUser].userAddressList isKindOfClass:[NSNull class]]) {
        return [User loginUser].userAddressList.count;
    }
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString * ID = @"selectCell";
    AddrSelectCell * cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (!cell) {
        cell = [[AddrSelectCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    if (![[User loginUser].userAddressList isKindOfClass:[NSNull class]]) {
        [cell setCellInfo:[User loginUser].userAddressList[indexPath.row]];
    }
    cell.accessoryType = UITableViewCellAccessoryNone;
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (![[User loginUser].userAddressList isKindOfClass:[NSNull class]]) {
        NSDictionary * info = [User loginUser].userAddressList[indexPath.row];
        NSString * addr = [NSString stringWithFormat:@"收货地址：%@", info[@"addressname"]];
        CGSize size = [GlobalMethod sizeWithString:addr font:MiddleFont maxWidth:250 *[FlexibleFrame ratios].width maxHeight:60 * [FlexibleFrame ratios].height];
        CGFloat height = 20 + 40*[FlexibleFrame ratios].height + size.height;
        return height;
    }
    return 0;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (![[User loginUser].userAddressList isKindOfClass:[NSNull class]]) {

        [Framework controllers].submitOrderVC.address = [User loginUser].userAddressList[indexPath.row];
        [self.navigationController popViewControllerAnimated:YES];
    }
}

#pragma mark - 编辑按钮点击事件
- (void)editItemPressed:(UIBarButtonItem *)sender {
    
    [self.navigationController pushViewController:[[AddrAdminController alloc] init] animated:YES];
}
@end

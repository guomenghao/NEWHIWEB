//
//  PersonalController.m
//  Hi鲜果
//
//  Created by rimi on 15/6/29.
//  Copyright (c) 2015年 Hi fruit. All rights reserved.
//

#import "PersonalController.h"

@interface PersonalController () <UITableViewDelegate, UITableViewDataSource>
@property (strong, nonatomic) NSArray * dataSource;
@property (strong, nonatomic) UITableView * tableView;
@end

@implementation PersonalController
#pragma mark - 初始化方法
- (instancetype)init
{
    self = [super init];
    if (self) {
        self.title = @"个人信息";
        [Framework controllers].personalVC = self;
    }
    return self;
 }

- (void)initializeDataSource {
    
    self.dataSource = @[@"头像", @"昵称", @"会员等级", @"性别", @"生日", @"地址管理", @"绑定手机"];
}

- (void)initializeUserInterface {
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.view.backgroundColor = [UIColor whiteColor];
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, Screen_width, Screen_height - 64) style:UITableViewStylePlain];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.tableFooterView = [[UIView alloc] init];
    [self.view addSubview:self.tableView];
}

#pragma mark - 生命周期方法
- (void)viewDidLoad {
    [super viewDidLoad];
    [self initializeDataSource];
    [self initializeUserInterface];
}

- (void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
    self.navigationController.tabBarController.tabBar.hidden = YES;
}

#pragma mark - <UITableViewDataSource/UITabelViewDelegate>
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.dataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString * identifier = @"personal";
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:identifier];
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    
    cell.textLabel.text = self.dataSource[indexPath.row];
}

@end

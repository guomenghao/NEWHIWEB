//
//  SettingController.m
//  Hi鲜果
//
//  Created by 李波 on 15/6/25.
//  Copyright (c) 2015年 Hi fruit. All rights reserved.
//

#import "SettingController.h"
#import "PersonalController.h"
@interface SettingController () <UITableViewDataSource, UITableViewDelegate>

@property (strong, nonatomic) NSArray * dataSource;
@property (strong, nonatomic) UITableView * tableView;

@end

@implementation SettingController
#pragma mark - 初始化方法
- (instancetype)init
{
    self = [super init];
    if (self) {
        [Framework controllers].settingVC = self;
        self.title = @"设置";
    }
    return self;
}

- (void)initializeDataSource {
    
    self.dataSource = @[
                          @[@"个人信息", @"清理图片缓存"],
                          @[@"当前版本", @"分享APP", @"关于我们"],
                          @[@"配送说明", @"48小时退换货"],
                          @[@"联系客服"]
                          ];
}

- (void)initializeUserInterface {
    
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, Screen_width, Screen_height - 64) style:UITableViewStyleGrouped];
//    self.tableView.delegate = self;
//    self.tableView.dataSource = self;
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

#pragma mark - <UITabelViewDataSource / UITabelViewDelegate>

/*
 打开AppStore评价页面
NSString * appstoreUrlString = @"itms-apps://ax.itunes.apple.com/WebObjects/MZStore.woa/wa/viewContentsUserReviews?mt=8&onlyLatestVersion=true&pageNumber=0&sortOrdering=1&type=Purple+Software&id=APP_ID";

NSURL * url = [NSURL URLWithString:appstoreUrlString];

if ([[UIApplication sharedApplication] canOpenURL:url])
{
    [[UIApplication sharedApplication] openURL:url];
}
else
{
    NSLog(@"can not open");
}
*/
@end

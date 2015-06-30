//
//  SettingController.m
//  Hi鲜果
//
//  Created by 李波 on 15/6/25.
//  Copyright (c) 2015年 Hi fruit. All rights reserved.
//

#import "SettingController.h"

@interface SettingController () <UITableViewDataSource, UITableViewDelegate, UIAlertViewDelegate>

@property (strong, nonatomic) NSArray * dataSource;
@property (strong, nonatomic) UITableView * tableView;
@property (strong, nonatomic) NSString * telephone;

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
                          @[@"清理图片缓存"],
                          @[@"当前版本", @"分享APP", @"关于我们"],
                          @[@"配送说明", @"48小时退换货"],
                          @[@"联系客服"]
                          ];
    self.telephone = @"10086";
}

- (void)initializeUserInterface {
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, Screen_width, Screen_height - 64) style:UITableViewStyleGrouped];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
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

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    NSArray * sectionArray = self.dataSource[section];
    return sectionArray.count;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return self.dataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString * identifier = @"setting";
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:identifier];
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    cell.textLabel.text = self.dataSource[indexPath.section][indexPath.row];
    if (indexPath.section == 3 && indexPath.row == 0) {//联系客服电话
        cell.detailTextLabel.text = self.telephone;
        cell.detailTextLabel.textColor = [UIColor orangeColor];
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (indexPath.section == 3 && indexPath.row == 0) {//联系客服电话
        
        UIAlertView * alert = [[UIAlertView alloc] initWithTitle:@"是否联系客服" message:self.telephone delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"呼叫", nil];
        [alert show];
    }
}

#pragma mark - <UIAlertViewDelegate>
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    
    if (buttonIndex == 1) {
        
        /**
         拨号(Phone Number)
         URL模式：tel://<strong>${PHONE_NUMBER}</strong>
         代码示例：
         [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"tel://10086"]];
         */
        NSURL * url = [NSURL URLWithString:[NSString stringWithFormat:@"tel://%@", self.telephone]];
        [[UIApplication sharedApplication] openURL:url];
        NSLog(@"呼叫10086");
    }
}

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

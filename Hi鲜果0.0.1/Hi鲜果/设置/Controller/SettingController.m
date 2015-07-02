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
@property (assign, nonatomic) NSInteger cacheSize;
@property (assign, nonatomic) NSInteger totlaSize;
//逐渐减少缓存值
- (void)decreaseCacheWithLabel:(UILabel *)label;
@end

@implementation SettingController

- (void)dealloc {
    
    NSLog(@"%s", __FUNCTION__);
}
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
    self.cacheSize = 0;
    cell.textLabel.text = self.dataSource[indexPath.section][indexPath.row];
    if (indexPath.section == 3 && indexPath.row == 0) {//联系客服电话
        cell.detailTextLabel.text = self.telephone;
        cell.detailTextLabel.textColor = [UIColor orangeColor];
    } else if (indexPath.section == 0 && indexPath.row == 0) {//清理图片缓存
        
        self.cacheSize = [[SDImageCache sharedImageCache] getSize];
        NSLog(@"缓存大小：%ld", (long)self.cacheSize);
        if (self.cacheSize < 100000) {
            cell.detailTextLabel.text = [NSString stringWithFormat:@"共%.2lfKB", self.cacheSize / 1024.0];
        } else {
            cell.detailTextLabel.text = [NSString stringWithFormat:@"共%.2lfMB", self.cacheSize / 1024.0/ 1024.0];
        }
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (indexPath.section == 3 && indexPath.row == 0) {//联系客服电话
        
        UIAlertView * alert = [[UIAlertView alloc] initWithTitle:@"是否联系客服" message:self.telephone delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"呼叫", nil];
        [alert show];
    } else if (indexPath.section == 0 && indexPath.row == 0) {
        UILabel * detailLabel = [tableView cellForRowAtIndexPath:indexPath].detailTextLabel;
        self.cacheSize = [[SDImageCache sharedImageCache] getSize];
        self.totlaSize = [[SDImageCache sharedImageCache] getSize];
        [[SDImageCache sharedImageCache] clearDisk];//clearDisk:清除;cleanDisk:删除
        [self decreaseCacheWithLabel:detailLabel];
    }
}

- (void)decreaseCacheWithLabel:(UILabel *)label {

    [UIView animateWithDuration:1 animations:^{
        
        if (self.cacheSize < 100000) {
            label.text = [NSString stringWithFormat:@"共%.2lfKB", self.cacheSize / 1024.0];
            
        } else {
            label.text = [NSString stringWithFormat:@"共%.2lfMB", self.cacheSize / 1024.0/ 1024.0];
        }
    } completion:^(BOOL finished) {

        if (self.cacheSize == 0) {
            NSString * msg;
            if (self.totlaSize < 100000) {
               msg = [NSString stringWithFormat:@"清理完毕，本次清理缓存%.2fKB", self.totlaSize / 1024.0];
            } else {
               msg = [NSString stringWithFormat:@"清理完毕，本次清理缓存%.2fMB", self.totlaSize /1024.0/ 1024.0];
            }
            UIAlertView * alert = [[UIAlertView alloc] initWithTitle:@"温馨提示" message:msg delegate:nil cancelButtonTitle:@"我知道了" otherButtonTitles:nil];
            [alert show];
            return ;
        }
        self.cacheSize -= 1000;
        if (self.cacheSize < 0) {
            self.cacheSize = 0;
        }
        [self decreaseCacheWithLabel:label];
    }];
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
